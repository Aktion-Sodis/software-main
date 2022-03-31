import { DataStore } from '@aws-amplify/datastore';
import { API, graphqlOperation } from 'aws-amplify';
import { dataTypesDict, modalModesDict } from '../constants';
import { deleteIntervention, updateIntervention } from '../../graphql/mutations';
import { listInterventions, listInterventionTags } from '../../graphql/queries';

const interventionsData = {
  namespaced: true,
  state: () => ({
    interventions: [],
    interventionTags: [],
    loading: false,
  }),
  getters: {
    /* READ */
    getInterventions: ({ interventions }) => interventions.filter((i) => !i._deleted).sort((a, b) => a.id - b.id),
    getInterventionTags: ({ interventionTags }) => interventionTags,
    getLoading: ({ loading }) => loading,

    INTERVENTIONById:
      (_, { getInterventions }) => ({ id }) => getInterventions.find((i) => i.id === id) ?? null,
    tagById:
      (_, { getInterventionTags }) => ({ tagId }) => getInterventionTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addIntervention: (state, intervention) => {
      state.interventions.push(intervention);
    },
    replaceIntervention: (state, intervention) => {
      state.interventions.splice(
        state.interventions.findIndex((i) => i.id === intervention.id),
        1,
        intervention,
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
    APIpost: async ({ commit, dispatch }, interventionDraft) => {
      commit('setLoading', { newValue: true });
      DataStore.save(interventionDraft)
        .then((postResponse) => {
          commit('addIntervention', postResponse);
          dispatch(
            'dataModal/readData',
            {
              dataId: postResponse.id,
              dataType: dataTypesDict.intervention,
            },
            {
              root: true,
            },
          );
          commit('setLoading', { newValue: false });
        })
        .catch((err) => {
          console.log({ err });
          commit('setLoading', { newValue: false });
        });
    },
    APIput: async ({ commit, dispatch }, { newData, originalId, originalVersion }) => {
      commit('setLoading', { newValue: true });
      API.graphql({
        query: updateIntervention,
        variables: {
          input: {
            id: originalId,
            _version: originalVersion,
            name: newData.name,
            description: newData.description,
            interventionType: newData.interventionType,
          },
        },
      })
        .then((putResponse) => {
          dispatch(
            'dataModal/readData',
            {
              dataId: putResponse.data.updateIntervention.id,
              dataType: dataTypesDict.intervention,
            },
            {
              root: true,
            },
          );
          commit('replaceIntervention', putResponse.data.updateIntervention);
          commit('setLoading', { newValue: false });
        })
        .catch((err) => {
          console.log({ err });
          commit('setLoading', { newValue: false });
        });
    },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      commit('setLoading', { newValue: true });
      API.graphql({ query: deleteIntervention, variables: { input: { id, _version } } })
        .then(() => {
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
        })
        .catch((err) => {
          // TODO: Handle error
          console.log({ err });
        });
    },
    sync: async ({ commit, dispatch }) => {
      commit('setLoading', { newValue: true });

      const { apiInterventions, apiInterventionTags } = await dispatch('APIgetAll');

      commit('setInterventions', { newValue: apiInterventions.map((i) => ({ ...i, levels: [] })) });
      commit('setInterventionTags', { newValue: apiInterventionTags });
      commit('setLoading', { newValue: false });
    },
    APIgetAll: async () => ({
      apiInterventions: (await API.graphql(graphqlOperation(listInterventions))).data
        .listInterventions.items,
      apiInterventionTags: (await API.graphql(graphqlOperation(listInterventionTags))).data
        .listInterventionTags.items,
    }),
  },
};

export default interventionsData;
