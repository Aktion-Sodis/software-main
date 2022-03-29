import { DataStore } from '@aws-amplify/datastore';
import { API } from 'aws-amplify';
import {
  // putIntervention,
  // deleteIntervention,
  getAllInterventions,
  getAllInterventionTags,
} from './utils';
import { Intervention } from '../../models';
import { dataTypesDict, modalModesDict } from '../constants';
import { deleteIntervention } from '../../graphql/mutations';

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
      console.log(intervention.id);
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
          console.log(postResponse.id);
          commit('addIntervention', postResponse);
          // commit('dataModal/setINTERVENTIONDraft', postResponse, { root: true });
          // commit('dataModal/setDataIdInFocus', { newValue: postResponse.id }, { root: true });
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
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
    },

    APIput: async ({ commit, dispatch }, interventionDraft) => {
      commit('setLoading', { newValue: true });
      DataStore.save(
        Intervention.copyOf(interventionDraft, (updated) => {
          updated.name = interventionDraft.name;
          updated.description = interventionDraft.description;
          updated.interventionType = interventionDraft.interventionType;
          updated.contents = interventionDraft.contents;
          updated.surveys = interventionDraft.surveys;
          updated.surveys = interventionDraft.surveys;
          updated.tags = interventionDraft.tags;
          updated.levels = interventionDraft.levels;
        }),
      )
        .then((putResponse) => {
          console.log({ putResponse });
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
        })
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
    },
    // APIdelete: async ({ commit, dispatch }, { id }) => {
    //   console.log({ id });
    //   commit('setLoading', { newValue: true });
    //   const x = await DataStore.query(Intervention, id);
    //   console.log({ x });
    //   DataStore.query(Intervention, id).then(async (toDelete) => {
    //     console.log({ toDelete });
    //     const deleteResponse = await DataStore.delete(toDelete);
    //     console.log({ deleteResponse });
    //     commit('deleteIntervention', {
    //       id,
    //     });
    //     commit('dataModal/setDataIdInFocus', { newValue: null }, { root: true });
    //     commit('dataModal/setMode', { newValue: modalModesDict.read }, { root: true });
    //     dispatch(
    //       'dataModal/abortReadData',
    //       {},
    //       {
    //         root: true,
    //       },
    //     );
    //   });
    //   commit('setLoading', { newValue: false });
    // },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      console.log('v', _version);
      console.log({ id, _version });
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

      console.log({ apiInterventions });

      commit('setInterventions', { newValue: apiInterventions.map((i) => ({ ...i, levels: [] })) });
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
