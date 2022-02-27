import Vue from 'vue';
import { EmptyIntervention, Intervention } from './utils';
import { modalModesDict } from '../constants';

const interventionsUI = {
  namespaced: true,
  state: () => ({
    interventionDraft: new EmptyIntervention(),

    interventionIdInFocus: null,
    isInterventionModalDisplayed: false,
    interventionModalMode: modalModesDict.read,
  }),
  getters: {
    /* READ */
    getInterventionDraft: ({ interventionDraft }) => interventionDraft,
    getInterventionIdInFocus: ({ interventionIdInFocus }) => interventionIdInFocus,
    getIsInterventionModalDisplayed: ({ isInterventionModalDisplayed }) => isInterventionModalDisplayed,
    getInterventionModalMode: ({ interventionModalMode }) => interventionModalMode,

    interventionInFocus: (state, { getInterventionIdInFocus }, rootState, rootGetters) => rootGetters['INTERVENTION_Data/INTERVENTIONById']({
      id: getInterventionIdInFocus,
    }) ?? null,
  },
  mutations: {
    /* CREATE, UPDATE, DELETE */
    setINTERVENTIONDraft: (state, {
      id, name, description, tagIds, contents,
    }) => {
      state.interventionDraft = new Intervention({
        id,
        name,
        description,
        tagIds,
        contents,
      });
    },
    resetInterventionDraft: (state) => {
      state.interventionDraft = new EmptyIntervention();
    },
    setInterventionIdInFocus: (state, { newValue }) => {
      state.interventionIdInFocus = newValue;
    },
    setIsInterventionModalDisplayed: (state, { newValue }) => {
      state.isInterventionModalDisplayed = newValue;
    },
    setInterventionModalMode: (state, { newValue }) => {
      state.interventionModalMode = newValue;
    },
  },
  actions: {
    readInterventionHandler: ({ commit }, { id }) => {
      commit('setInterventionModalMode', { newValue: modalModesDict.read });
      commit('setInterventionIdInFocus', { newValue: id });
      commit('resetInterventionDraft');
      commit('setIsInterventionModalDisplayed', { newValue: true });
    },
    abortReadInterventionHandler: async ({ commit }) => {
      commit('setIsInterventionModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('setInterventionIdInFocus', { newValue: null });
    },
    newInterventionHandler: ({ commit }) => {
      commit('setInterventionModalMode', { newValue: modalModesDict.create });
      commit('setInterventionIdInFocus', { newValue: null });
      commit('resetInterventionDraft');
      commit('setIsInterventionModalDisplayed', { newValue: true });
    },
    abortNewInterventionHandler: async ({ commit }) => {
      commit('setIsInterventionModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('resetInterventionDraft');
      commit('setInterventionModalMode', { newValue: modalModesDict.read });
    },
    editInterventionHandler: ({ commit, rootGetters }, { id }) => {
      commit('setInterventionModalMode', { newValue: modalModesDict.edit });
      commit('setInterventionIdInFocus', { newValue: id });
      const intervention = rootGetters['INTERVENTION_Data/INTERVENTIONById']({ id });
      commit('setINTERVENTIONDraft', intervention);
      commit('setIsInterventionModalDisplayed', { newValue: true });
    },
    abortEditInterventionHandler: async ({ commit }) => {
      await Vue.nextTick();
      commit('resetInterventionDraft');
      commit('setInterventionModalMode', { newValue: modalModesDict.read });
    },

    saveInterventionHandler: async ({ dispatch, getters }) => {
      if (getters.getInterventionModalMode === modalModesDict.read) return;
      const interventionDraft = getters.getInterventionDraft;
      if (getters.getInterventionModalMode === modalModesDict.create) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to interventions
        await dispatch('INTERVENTION_Data/APIpost', interventionDraft, {
          root: true,
        });
        return;
      }
      if (getters.getInterventionModalMode === modalModesDict.edit) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to interventions
        await dispatch('INTERVENTION_Data/APIput', interventionDraft, { root: true });
      }
    },
    deleteInterventionHandler: async ({ dispatch, getters }) => {
      if (getters.getInterventionModalMode === modalModesDict.read) return;
      if (getters.getInterventionModalMode === modalModesDict.create) return;
      // 1. DELETE this in the ./data.js
      // 2. Await the response DB object
      // 3. Put the response DB object to interventions
      await dispatch('INTERVENTION_Data/APIpost', getters.getInterventionIdInFocus, {
        root: true,
      });
    },
  },
};

export default interventionsUI;
