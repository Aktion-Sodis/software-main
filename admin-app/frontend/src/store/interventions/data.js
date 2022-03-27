import {
  Intervention,
  // postNewIntervention,
  putIntervention,
  deleteIntervention,
  getAllInterventions,
  getAllInterventionTags,
} from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

const interventionsData = {
  namespaced: true,
  state: () => ({
    interventions: [],
    interventionTags: [],
    loading: false,
  }),
  getters: {
    /* READ */
    getInterventions: ({ interventions }) => interventions.sort((a, b) => a.id - b.id),
    getInterventionTags: ({ interventionTags }) => interventionTags,
    getLoading: ({ loading }) => loading,

    INTERVENTIONById:
      (_, { getInterventions }) => ({ id }) => getInterventions.find((i) => i.id === id) ?? null,
    tagById:
      (_, { getInterventionTags }) => ({ tagId }) => getInterventionTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addIntervention: (state, {
      id, name, description, tagIds, contents,
    }) => {
      state.interventions.push(
        new Intervention({
          id,
          name,
          description,
          tagIds,
          contents,
        }),
      );
    },
    replaceIntervention: (state, {
      id, name, description, tagIds, contents,
    }) => {
      state.interventions.splice(
        state.interventions.findIndex((i) => i.id === id),
        1,
        new Intervention({
          id,
          name,
          description,
          tagIds,
          contents,
        }),
      );
    },
    deleteIntervention: (state, { id }) => {
      state.interventions.splice(
        Array.from(state.interventions).findIndex((i) => i.id === id),
        1,
      );
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
    setInterventions: (state, { newValue }) => {
      state.interventions = newValue;
    },

    setInterventionTags: (state, { newValue }) => {
      state.interventionTags = newValue;
    },
  },
  actions: {
    // APIpost: async ({ commit, dispatch }, { intervention }) => {
    //   commit('setLoading', { newValue: true });
    //   postNewIntervention(intervention);

    //   commit('setLoading', { newValue: false });
    // },

    APIput: async ({ commit, dispatch }, interventionDraft) => {
      commit('setLoading', { newValue: true });
      const putResponse = await putIntervention(interventionDraft);
      commit('replaceIntervention', putResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: putResponse.id,
          dataType: dataTypesDict.intervention,
        },
        {
          root: true,
        },
      );
      commit('setLoading', { newValue: false });
    },
    APIdelete: async ({ commit, dispatch }, { id }) => {
      commit('setLoading', { newValue: true });
      const deleteResponse = await deleteIntervention();
      if (deleteResponse.errors.length > 0) {
        commit('setLoading', { newValue: false });
      }
      commit('deleteIntervention', {
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
    },
    sync: async ({ commit, dispatch }) => {
      commit('setLoading', { newValue: true });

      const { apiInterventions, apiInterventionTags } = await dispatch('APIgetAll');

      console.log({ apiInterventions });

      commit('setInterventions', { newValue: apiInterventions });
      commit('setInterventionTags', { newValue: apiInterventionTags });
      commit('setLoading', { newValue: false });
    },
    APIgetAll: async () => ({
      apiInterventions: (await getAllInterventions()).data.listInterventions.items,
      apiInterventionTags: (await getAllInterventionTags()).data.listInterventionTags.items,
    }),
  },
};

export default interventionsData;
