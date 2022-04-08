import { syncStatusDict } from '../constants';
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
    syncAll: async ({ commit, dispatch }) => {
      const { apiLevelInterventionRelations, apiLevels } = await dispatch(
        'LEVEL_Data/APIgetAll',
        {},
        { root: true },
      );
      commit(
        'LEVEL_Data/setRelationLevelIntervention',
        {
          newValue: apiLevelInterventionRelations,
        },
        { root: true },
      );
      commit(
        'LEVEL_Data/setLevels',
        {
          newValue: apiLevels,
        },
        { root: true },
      );

      const apiEntities = await dispatch('ENTITY_Data/APIgetAll', {}, { root: true });
      commit('ENTITY_Data/setEntities', { newValue: apiEntities }, { root: true });

      const apiInterventions = await dispatch('INTERVENTION_Data/APIgetAll', {}, { root: true });
      commit('INTERVENTION_Data/setInterventions', { newValue: apiInterventions }, { root: true });
    },
  },
};

export default SYNC_UI;
