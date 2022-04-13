import { DataStore } from '@aws-amplify/datastore';
import { API } from 'aws-amplify';
import {
  Level, I18nString, LevelInterventionRelation, CustomData,
} from '../../models';
import { dataTypesDict, modalModesDict } from '../../lib/constants';
import { deleteLevel /* , updateLevel */ } from '../../graphql/mutations';
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
    getRelationLevelIntervention: ({ relationLevelIntervention }) => relationLevelIntervention.filter((r) => r?.level),

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
    APIpost: async ({ commit, dispatch, rootGetters }, levelDraft) => {
      let success = true;
      commit('setLoading', { newValue: true });
      const level = new Level({
        ...levelDraft,
        name: new I18nString(levelDraft.name),
        description: new I18nString(levelDraft.description),
        customData: levelDraft.customData.map((cd) => new CustomData(cd)),
      });

      try {
        const postResponse = await DataStore.save(level);

        // eslint-disable-next-line no-restricted-syntax
        for (const interventionId of levelDraft.allowedInterventions) {
          try {
            // eslint-disable-next-line no-await-in-loop
            await DataStore.save(
              new LevelInterventionRelation({
                level: postResponse,
                intervention: rootGetters['INTERVENTION_Data/INTERVENTIONById']({
                  id: interventionId,
                }),
              }),
            );
          } catch (error) {
            success = false;
            console.log(error);
          }
        }
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
      } catch (error) {
        success = false;
        console.log(error);
      }
      commit('setLoading', { newValue: false });
      return success;
    },
    APIput: async ({
      commit, dispatch, getters, rootGetters,
    }, { newData, originalId }) => {
      commit('setLoading', { newValue: true });
      let success = true;

      const original = getters.LEVELById({ id: originalId });
      const relationsOfOriginal = getters.getRelationLevelIntervention.filter(
        (rel) => rel.level.id === original.id,
      );

      try {
        const putResponse = await DataStore.save(
          Level.copyOf(original, (updated) => {
            updated.name = newData.name;
            updated.description = newData.description;
            updated.parentLevelID = newData.parentLevelID;
            updated.interventionsAreAllowed = newData.interventionsAreAllowed;
            updated.tags = [];
            updated.customData = newData.customData.map((cd) => new CustomData(cd));
          }),
        );

        commit('replaceLevel', putResponse);

        // FIRST DELETE ALL INTERVENTION RELATIONS OF THE LEVEL

        // eslint-disable-next-line no-restricted-syntax
        for (const relation of relationsOfOriginal) {
          try {
            // eslint-disable-next-line no-await-in-loop
            await DataStore.delete(relation);
          } catch (error) {
            success = false;
            console.log(error);
          }
        }

        // THEN RECREATE THEM AS WHAT IS GIVEN IN THE MODAL

        // eslint-disable-next-line no-restricted-syntax
        for (const interventionId of newData.allowedInterventions) {
          try {
            // eslint-disable-next-line no-await-in-loop
            await DataStore.save(
              new LevelInterventionRelation({
                level: putResponse,
                intervention: rootGetters['INTERVENTION_Data/INTERVENTIONById']({
                  id: interventionId,
                }),
              }),
            );
          } catch (error) {
            success = false;
            console.log(error);
          }
        }

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
      } catch (error) {
        success = false;
        console.log(error);
      }
      commit('setLoading', { newValue: false });
      return success;
    },
    APIdelete: async ({ commit, dispatch, getters }, { id, _version }) => {
      let success = true;
      commit('setLoading', { newValue: true });

      try {
        await API.graphql({ query: deleteLevel, variables: { input: { id, _version } } });
      } catch (error) {
        success = false;
        console.log(error);
      }

      const relationsOfOriginal = getters.getRelationLevelIntervention.filter(
        (rel) => rel.level.id === id,
      );

      // eslint-disable-next-line no-restricted-syntax
      for (const relation of relationsOfOriginal) {
        try {
          // eslint-disable-next-line no-await-in-loop
          await DataStore.delete(relation);
        } catch (error) {
          success = false;
          console.log(error);
        }
      }

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
      return success;
    },
    APIgetAll: async () => {
      let apiLevelInterventionRelations = [];
      let apiLevels = [];
      try {
        apiLevels = await DataStore.query(Level);
      } catch (error) {
        console.log({ error });
      }
      try {
        apiLevelInterventionRelations = await DataStore.query(LevelInterventionRelation);
      } catch (error) {
        console.log({ error });
      }
      return { apiLevelInterventionRelations, apiLevels };
    },
  },
};

export default levelsData;
