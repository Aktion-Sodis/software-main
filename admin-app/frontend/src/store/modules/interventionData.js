import { DataStore } from '@aws-amplify/datastore';
import { API, Storage } from 'aws-amplify';
import { dataTypesDict, modalModesDict, vuexModulesDict } from '../../lib/constants';
import { deriveFilePath } from '../../lib/utils';
import { deleteIntervention } from '../../graphql/mutations';
import {
  I18nString,
  Intervention,
  // InterventionInterventionTagRelation,
  // InterventionTag,
} from '../../models';

const interventionsData = {
  namespaced: true,
  state: () => ({
    interventions: [],
    // interventionTags: [],
    // relationInterventionsAndTags: [],
    loading: false,
  }),
  getters: {
    /* READ */
    getInterventions: ({ interventions }) => interventions.filter((i) => !i._deleted).sort((a, b) => a.id - b.id),
    // getInterventionTags: ({ interventionTags }) => interventionTags,
    getLoading: ({ loading }) => loading,

    INTERVENTIONById:
      (_, { getInterventions }) => ({ id }) => getInterventions.find((i) => i.id === id) ?? null,
    // tagById:
    // (_, { getInterventionTags }) => ({ tagId }) => getInterventionTags.find((t) => t.tagId === tagId),
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

    // setInterventionTags: (state, { newValue }) => {
    //   state.interventionTags = newValue;
    // },

    // setRelationInterventionsAndTags: (state, { newValue }) => {
    //   state.relationInterventionsAndTags = newValue;
    // },
  },
  actions: {
    APIpost: async ({ commit, dispatch, rootGetters }, interventionDraft) => {
      let success = true;
      commit('setLoading', { newValue: true });
      const intervention = new Intervention({
        ...interventionDraft,
        name: new I18nString(interventionDraft.name),
        description: new I18nString(interventionDraft.description),
      });

      try {
        const postResponse = await DataStore.save(intervention);
        // const tagIds = interventionDraft.tags;
        // // eslint-disable-next-line no-restricted-syntax
        // for (const tagId of tagIds) {
        //   const localTag = getters.tagById({ id: tagId });
        //   // eslint-disable-next-line no-await-in-loop
        //   await DataStore.save(
        //     new InterventionInterventionTagRelation({
        //       intervention: postResponse,
        //       interventionTag: localTag,
        //     }),
        //   );
        // }

        if (rootGetters[`${vuexModulesDict.dataModal}/getImageFile`] instanceof File) {
          try {
            await Storage.put(
              deriveFilePath('interventionPicPath', { interventionID: postResponse.id }),
              rootGetters[`${vuexModulesDict.dataModal}/getImageFile`],
            );
          } catch {
            success = false;
          }
        }
        commit('addIntervention', postResponse);

        dispatch(
          `${vuexModulesDict.dataModal}/readData`,
          {
            dataId: postResponse.id,
            dataType: dataTypesDict.intervention,
          },
          {
            root: true,
          },
        );
      } catch {
        success = false;
      }
      commit('setLoading', { newValue: false });
      return success;
    },
    APIput: async ({
      commit, dispatch, getters, rootGetters,
    }, { newData, originalId }) => {
      commit('setLoading', { newValue: true });
      let success = true;

      const original = getters.INTERVENTIONById({ id: originalId });

      try {
        const putResponse = await DataStore.save(
          Intervention.copyOf(original, (updated) => {
            updated.name = newData.name;
            updated.description = newData.description;
            updated.interventionType = newData.interventionType;
          }),
        );

        if (rootGetters[`${vuexModulesDict.dataModal}/getImageFile`] instanceof File) {
          try {
            await Storage.put(
              deriveFilePath('interventionPicPath', { interventionID: putResponse.id }),
              rootGetters[`${vuexModulesDict.dataModal}/getImageFile`],
            );
          } catch {
            success = false;
          }
        }

        dispatch(
          `${vuexModulesDict.dataModal}/readData`,
          {
            dataId: putResponse.id,
            dataType: dataTypesDict.intervention,
          },
          {
            root: true,
          },
        );
        commit('replaceIntervention', putResponse);
      } catch {
        success = false;
      }
      commit('setLoading', { newValue: false });
      return success;
    },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      let success = true;
      commit('setLoading', { newValue: true });
      try {
        await API.graphql({
          query: deleteIntervention,
          variables: { input: { id, _version } },
        });
      } catch {
        success = false;
      }

      if (success) {
        Storage.remove(deriveFilePath('interventionPicPath', { interventionID: id }));
        commit('deleteIntervention', {
          id,
        });
        commit(`${vuexModulesDict.dataModal}/setDataIdInFocus`, { newValue: null }, { root: true });
        commit(
          `${vuexModulesDict.dataModal}/setMode`,
          { newValue: modalModesDict.read },
          { root: true },
        );
        dispatch(
          `${vuexModulesDict.dataModal}/abortReadData`,
          {},
          {
            root: true,
          },
        );
      }

      commit('setLoading', { newValue: false });
      return success;
    },
    APIgetAll: async () => {
      try {
        return await DataStore.query(Intervention);
      } catch (error) {
        console.log({ error });
        return [];
      }
    },
  },
};

export default interventionsData;
