import { DataStore } from '@aws-amplify/datastore';
import { API } from 'aws-amplify';
import {
  Level, I18nString, Entity, LevelInterventionRelation,
} from '../../models';
import { dataTypesDict, modalModesDict } from '../constants';
import { deleteLevel, updateLevel } from '../../graphql/mutations';
// import { listLevels } from '../../graphql/queries';

const levelsData = {
  namespaced: true,
  state: () => ({
    levels: [],
    // levelTags: [
    //   { tagId: '468084f3-6ec4-42ea-bdb2-40900816b64f', name: 'Tag 1' },
    //   { tagId: 'e5ebc38b-abed-498d-9052-6c8767cc341e', name: 'Tag 2' },
    // ],
    loading: false,
    relationLevelIntervention: [],
  }),
  getters: {
    /* READ */
    getLevels: ({ levels }) => levels.filter((l) => !l._deleted),
    // getLevelTags: ({ levelTags }) => levelTags,
    getLoading: ({ loading }) => loading,
    getRelationLevelIntervention: ({ relationLevelIntervention }) => relationLevelIntervention,

    interventionsOfLevelById:
      (_, { getRelationLevelIntervention }) => ({ levelId }) => getRelationLevelIntervention
        .filter((rel) => rel.level.id === levelId)
        .map((rel) => rel.intervention),

    sortedLevels: (_, getters) => getters.getLevels.sort((a, b) => getters.hierarchySort(a, b)),
    // used in the getter "sortedLevels". Don't use directly outside of Vuex environment.
    hierarchySort: (_, getters) => (a, b) => {
      if (a.parentLevelID === null) return -1;
      if (b.parentLevelID === null) return 1;
      if (a.id === b.parentLevelID) return -1;
      return getters.hierarchySort(a, getters.LEVELById({ id: b.parentLevelID }));
    },

    lowestLevelId: (_, { sortedLevels }) => sortedLevels[sortedLevels.length - 1].id,
    highestLevelId: (_, { sortedLevels }) => sortedLevels[0].id,
    upperLevelById:
      (_, { getLevels }) => ({ id }) => {
        const currentLevel = getLevels.find((l) => l.id === id);
        if (!currentLevel) return null;
        const upperLevel = getLevels.find((l) => l.id === currentLevel.parentLevelID);
        return upperLevel || null;
      },

    LEVELById:
      (_, { getLevels }) => ({ id }) => getLevels.find((i) => i.id === id),

    nLevels: (_, { getLevels }) => getLevels.length,
    // tagById:
    // (_, { getLevelTags }) => ({ tagId }) => getLevelTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addLevel: (state, level) => {
      state.levels.push(level);
    },
    replaceLevel: (state, level) => {
      state.levels.splice(
        state.levels.findIndex((i) => i.id === level.id),
        1,
        level,
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
    setLevels: (state, { newValue }) => {
      state.levels = newValue;
    },
    setRelationLevelIntervention: (state, { newValue }) => {
      state.relationLevelIntervention = newValue;
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch }, levelDraft) => {
      console.log(levelDraft);
      const level = new Level({
        ...levelDraft,
        name: new I18nString(levelDraft.name),
        description: new I18nString(levelDraft.description),
      });
      commit('setLoading', { newValue: true });
      DataStore.save(level)
        .then((postResponse) => {
          commit('addLevel', postResponse);
          console.log({ postResponse });
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
        })
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
    },
    APIput: async ({ commit, dispatch }, levelDraft) => {
      commit('setLoading', { newValue: true });
      await API.graphql({
        query: updateLevel,
        variables: {
          input: {
            id: levelDraft.originalId,
            name: levelDraft.newData.name,
            description: levelDraft.newData.description,
            _version: levelDraft.originalVersion,
          },
        },
      })
        .then(() => {
          dispatch(
            'SYNC_UI/refreshHandler',
            {
              routeName: 'OrganizationStructure',
            },
            {
              root: true,
            },
          );
          dispatch(
            'dataModal/readData',
            {
              dataId: levelDraft.originalId,
              dataType: dataTypesDict.level,
            },
            {
              root: true,
            },
          );
        })
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
    },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      commit('setLoading', { newValue: true });
      API.graphql({ query: deleteLevel, variables: { input: { id, _version } } })
        .then(() => {
          commit('deleteLevel', {
            id,
          });
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
        })
        .catch((err) => {
          commit('setLoading', { newValue: false });
          // TODO: Handle error
          console.log({ err });
        });
    },
    sync: async ({ commit, dispatch }) => {
      commit('setLoading', { newValue: true });
      commit('setLevels', {
        newValue: [
          new Level({
            id: 'dummyLevel0',
            name: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Name', 'Isimo', 'İsim'],
            }),
            description: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Description', 'Desaciklamo', 'Açıklama'],
            }),
            parentLevelID: null,
            interventionsAreAllowed: true,
            allowedInterventions: [],
            customData: [],
            schemeVersion: 1020,
          }),
          new Level({
            id: 'dummyLevel1',
            name: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Name', 'Isimo', 'İsim'],
            }),
            description: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Description', 'Desaciklamo', 'Açıklama'],
            }),
            parentLevelID: null,
            interventionsAreAllowed: true,
            allowedInterventions: [],
            customData: [],
            schemeVersion: 1020,
          }),
          new Level({
            id: 'dummyLevel2',
            name: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Name', 'Isimo', 'İsim'],
            }),
            description: new I18nString({
              languageKeys: ['en-US', 'es-BO', 'tr-TR'],
              languageTexts: ['Description', 'Desaciklamo', 'Açıklama'],
            }),
            parentLevelID: null,
            interventionsAreAllowed: true,
            allowedInterventions: [],
            customData: [],
            schemeVersion: 1020,
          }),
        ],
      });
      commit(
        'ENTITY_Data/setEntities',
        {
          newValue: [
            new Entity({
              id: 'dummyEntity0',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel0',
              parentEntityID: null,
              _version: 1,
            }),
            new Entity({
              id: 'dummyEntity1',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel0',
              parentEntityID: null,
              _version: 1,
            }),
            new Entity({
              id: 'dummyEntity2',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel1',
              parentEntityID: 'dummyEntity0',
              _version: 1,
            }),
            new Entity({
              id: 'dummyEntity3',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel2',
              parentEntityID: 'dummyEntity2',
              _version: 1,
            }),
            new Entity({
              id: 'dummyEntity4',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel2',
              parentEntityID: 'dummyEntity3',
              _version: 1,
            }),
            new Entity({
              id: 'dummyEntity5',
              name: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
              description: {
                languageKeys: ['en-US', 'es-BO', 'tr-TR'],
                languageTexts: ['', '', ''],
              },
              entityLevelId: 'dummyLevel2',
              parentEntityID: 'dummyEntity3',
              _version: 1,
            }),
          ],
        },
        { root: true },
      );
      try {
        const apiLevelInterventionRelation = await DataStore.query(LevelInterventionRelation);
        console.log({ apiLevelInterventionRelation });
        commit('setRelationLevelIntervention', { newValue: apiLevelInterventionRelation });
        const apiLevels = await dispatch('APIgetAll');
        commit('setLevels', {
          newValue: apiLevels,
        });
      } catch (error) {
        console.log({ error });
      }

      try {
        const apiEntities = await dispatch('ENTITY_Data/APIgetAll', null, { root: true });
        commit(
          'ENTITY_Data/setEntities',
          { newValue: apiEntities.filter((e) => !e._deleted) },
          { root: true },
        );
      } catch (error) {
        console.log({ error });
      }

      commit('setLoading', { newValue: false });
    },
    APIgetAll: async () => DataStore.query(Level),
  },
};

export default levelsData;
