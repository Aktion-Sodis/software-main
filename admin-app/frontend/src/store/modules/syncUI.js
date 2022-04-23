import { syncStatusDict, vuexModulesDict } from '../../lib/constants';
import { waitForMilliseconds } from '../../lib/utils';

const SYNC_UI = {
  namespaced: true,
  state: () => ({
    status: syncStatusDict.synched,
    isStatusLocked: false,
  }),
  getters: {
    getStatus: ({ status }) => status,
    syncActionIcon: (_, { getState }) => getState,
  },
  mutations: {
    setStatus: (state, { newStatus }) => {
      if (!state.isStatusLocked) state.status = newStatus;
    },
    setIsStatusLocked: (state, { newValue }) => {
      state.isStatusLocked = newValue;
    },
  },
  actions: {
    refreshHandler: async ({ commit, dispatch }) => {
      commit('setStatus', { newStatus: syncStatusDict.synchronizing });
      await dispatch('syncAll');
      commit('setStatus', { newStatus: syncStatusDict.synched });
      commit('setIsStatusLocked', { newValue: true });
      await waitForMilliseconds(2000);
      commit('setIsStatusLocked', { newValue: false });
      commit('setStatus', { newStatus: syncStatusDict.inSync });
    },
    /* Don't call this directly. Call the refreshHandler. */
    syncAll: async ({ commit, dispatch }) => {
      const { apiLevelInterventionRelations, apiLevels } = await dispatch(
        `${vuexModulesDict.level}/APIgetAll`,
        {},
        { root: true },
      );
      commit(
        `${vuexModulesDict.level}/setRelationLevelIntervention`,
        {
          newValue: apiLevelInterventionRelations,
        },
        { root: true },
      );
      commit(
        `${vuexModulesDict.level}/setLevels`,
        {
          newValue: apiLevels,
        },
        { root: true },
      );

      const apiEntities = await dispatch(`${vuexModulesDict.entity}/APIgetAll`, {}, { root: true });
      commit(`${vuexModulesDict.entity}/setEntities`, { newValue: apiEntities }, { root: true });

      const apiInterventions = await dispatch(
        `${vuexModulesDict.intervention}/APIgetAll`,
        {},
        { root: true },
      );
      commit(
        `${vuexModulesDict.intervention}/setInterventions`,
        { newValue: apiInterventions },
        { root: true },
      );

      const apiSurveys = await dispatch(`${vuexModulesDict.survey}/APIgetAll`, {}, { root: true });
      commit(`${vuexModulesDict.survey}/setSurveys`, { newValue: apiSurveys }, { root: true });
    },
  },
};

export default SYNC_UI;
