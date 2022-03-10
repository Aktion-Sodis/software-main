import {
  Level, postNewLevel, putLevel, deleteLevel,
} from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

const levelsData = {
  namespaced: true,
  state: () => ({
    levels: [
      {
        id: '5a93459f-f23d-44e6-a112-c41e90473a2d',
        name: 'Gemeinde',
        description: 'Some description',
        upperLevelId: null,
        allowedInterventions: [],
        tagIds: [],
      },
      {
        id: 'e7a03934-90b9-405b-807b-3f748b15ae69',
        name: 'Dorf',
        description: 'Some description',
        upperLevelId: '5a93459f-f23d-44e6-a112-c41e90473a2d',
        allowedInterventions: ['bd5f6df6-a64c-4d60-9df2-8f29bb7944d5'],
        tagIds: ['468084f3-6ec4-42ea-bdb2-40900816b64f', 'e5ebc38b-abed-498d-9052-6c8767cc341e'],
      },
      {
        id: 'd1faef12-cf15-4b5e-9637-b4ffbd156954',
        name: 'Family',
        description: 'Some description',
        upperLevelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
        allowedInterventions: [
          'bd5f6df6-a64c-4d60-9df2-8f29bb7944d5',
          '59fe15e7-59ad-46bf-a196-cbab81885d5b',
          'c220fb83-a0e4-4463-a28a-f21b260e609a',
        ],
        tagIds: ['468084f3-6ec4-42ea-bdb2-40900816b64f'],
      },
    ],

    levelTags: [
      { tagId: '468084f3-6ec4-42ea-bdb2-40900816b64f', name: 'Tag 1' },
      { tagId: 'e5ebc38b-abed-498d-9052-6c8767cc341e', name: 'Tag 2' },
    ],
    loading: false,
  }),
  getters: {
    /* READ */
    getLevels: ({ levels }) => levels,
    getLevelTags: ({ levelTags }) => levelTags,
    getLoading: ({ loading }) => loading,

    sortedLevels: (_, getters) => getters.getLevels.sort((a, b) => getters.hierarchySort(a, b)),
    // used in the getter "sortedLevels". Don't use directly outside of Vuex environment.
    hierarchySort: (_, getters) => (a, b) => {
      if (a.upperLevelId === null) return -1;
      if (b.upperLevelId === null) return 1;
      if (a.id === b.upperLevelId) return -1;
      return getters.hierarchySort(a, getters.LEVELById({ id: b.upperLevelId }));
    },

    lowestLevelId: (_, { sortedLevels }) => sortedLevels[sortedLevels.length - 1].id,
    upperLevelById:
      (_, { getLevels }) => ({ id }) => {
        const currentLevel = getLevels.find((l) => l.id === id);
        if (!currentLevel) return null;
        const upperLevel = getLevels.find((l) => l.id === currentLevel.upperLevelId);
        return upperLevel || null;
      },

    LEVELById:
      (_, { getLevels }) => ({ id }) => getLevels.find((i) => i.id === id),
    tagById:
      (_, { getLevelTags }) => ({ tagId }) => getLevelTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addLevel: (state, {
      id, name, description, upperLevelId, allowedInterventions, tagIds,
    }) => {
      state.levels.push(
        new Level({
          id,
          name,
          description,
          upperLevelId,
          allowedInterventions,
          tagIds,
        }),
      );
    },
    replaceLevel: (
      state,
      {
        id, name, upperLevelId, tagIds, allowedInterventions, description,
      },
    ) => {
      state.levels.splice(
        state.levels.findIndex((i) => i.id === id),
        1,
        new Level({
          id,
          name,
          description,
          upperLevelId,
          allowedInterventions,
          tagIds,
        }),
      );
    },
    deleteLevel: (state, { id }) => {
      state.levels.splice(
        Array.from(state.levels).findIndex((i) => i.id === id),
        1,
      );
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch }, levelDraft) => {
      commit('setLoading', { newValue: true });
      const postResponse = await postNewLevel(levelDraft);
      commit('addLevel', postResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: postResponse.id,
          dataType: dataTypesDict.level,
        },
        {
          root: true,
        },
      );

      commit('setLoading', { newValue: false });
    },
    APIput: async ({ commit, dispatch }, levelDraft) => {
      commit('setLoading', { newValue: true });
      const putResponse = await putLevel(levelDraft);
      commit('replaceLevel', putResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: putResponse.id,
          dataType: dataTypesDict.level,
        },
        {
          root: true,
        },
      );
      commit('setLoading', { newValue: false });
    },
    APIdelete: async ({ commit, dispatch }, { id }) => {
      commit('setLoading', { newValue: true });
      const deleteResponse = await deleteLevel();
      if (deleteResponse.errors.length > 0) {
        commit('setLoading', { newValue: false });
      }
      commit('deleteLevel', {
        id,
      });
      commit('ENTITY_Data/deleteEntitiesByLevelId', { levelId: id }, { root: true });
      commit('dataModal/setDataIdInFocus', { newValue: null }, { root: true });
      commit('dataModal/setMode', { newValue: modalModesDict.read }, { root: true });
      dispatch(
        'dataModal/abortReadData',
        {},
        {
          root: true,
        },
      );

      commit('setLoading', { newValue: false });
    },
  },
};

export default levelsData;
