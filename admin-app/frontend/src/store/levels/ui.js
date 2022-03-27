import Vue from 'vue';
import { EmptyLevel, Level } from './utils';
import { modalModesDict } from '../constants';

const levelsUI = {
  namespaced: true,
  state: () => ({
    levelDraft: new EmptyLevel(),

    levelIdInFocus: null,
    isLevelModalDisplayed: false,
    levelModalMode: modalModesDict.read,
  }),
  getters: {
    /* READ */
    getLevelDraft: ({ levelDraft }) => levelDraft,
    getLevelIdInFocus: ({ levelIdInFocus }) => levelIdInFocus,
    getIsLevelModalDisplayed: ({ isLevelModalDisplayed }) => isLevelModalDisplayed,
    getLevelModalMode: ({ levelModalMode }) => levelModalMode,

    levelInFocus: (state, { getLevelIdInFocus }, rootState, rootGetters) => rootGetters['LEVEL_Data/LEVELById']({
      id: getLevelIdInFocus,
    }) ?? null,
  },
  mutations: {
    /* CREATE, UPDATE, DELETE */
    setLevelDraft: (
      state,
      {
        id, name, description, parentLevelID, allowedInterventions, tagIds,
      },
    ) => {
      state.levelDraft = new Level({
        id,
        name,
        description,
        parentLevelID,
        allowedInterventions,
        tagIds,
      });
    },
    resetLevelDraft: (state) => {
      state.levelDraft = new EmptyLevel();
    },
    setLevelIdInFocus: (state, { newValue }) => {
      state.levelIdInFocus = newValue;
    },
    setIsLevelModalDisplayed: (state, { newValue }) => {
      state.isLevelModalDisplayed = newValue;
    },
    setLevelModalMode: (state, { newValue }) => {
      state.levelModalMode = newValue;
    },
  },
  actions: {
    readLevelHandler: ({ commit }, { id }) => {
      commit('setLevelModalMode', { newValue: modalModesDict.read });
      commit('setLevelIdInFocus', { newValue: id });
      commit('resetLevelDraft');
      commit('setIsLevelModalDisplayed', { newValue: true });
    },
    abortReadLevelHandler: async ({ commit }) => {
      commit('setIsLevelModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('setLevelIdInFocus', { newValue: null });
    },
    newLevelHandler: ({ commit }) => {
      commit('setLevelModalMode', { newValue: modalModesDict.create });
      commit('setLevelIdInFocus', { newValue: null });
      commit('resetLevelDraft');
      commit('setIsLevelModalDisplayed', { newValue: true });
    },
    abortNewLevelHandler: async ({ commit }) => {
      commit('setIsLevelModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('resetLevelDraft');
      commit('setLevelModalMode', { newValue: modalModesDict.read });
    },
    editLevelHandler: ({ commit, rootGetters }, { id }) => {
      commit('setLevelModalMode', { newValue: modalModesDict.edit });
      commit('setLevelIdInFocus', { newValue: id });
      const level = rootGetters['LEVEL_Data/LEVELById']({ id });
      commit('setLevelDraft', level);
      commit('setIsLevelModalDisplayed', { newValue: true });
    },
    abortEditLevelHandler: async ({ commit }) => {
      await Vue.nextTick();
      commit('resetLevelDraft');
      commit('setLevelModalMode', { newValue: modalModesDict.read });
    },

    saveLevelHandler: async ({ dispatch, getters }) => {
      if (getters.getLevelModalMode === modalModesDict.read) return;
      const levelDraft = getters.getLevelDraft;
      if (getters.getLevelModalMode === modalModesDict.create) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to levels
        await dispatch('LEVEL_Data/APIpost', levelDraft, {
          root: true,
        });
        return;
      }
      if (getters.getLevelModalMode === modalModesDict.edit) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to levels
        await dispatch('LEVEL_Data/APIput', levelDraft, { root: true });
      }
    },
    deleteLevelHandler: async ({ dispatch, getters }) => {
      if (getters.getLevelModalMode === modalModesDict.read) return;
      if (getters.getLevelModalMode === modalModesDict.create) return;
      // 1. DELETE this in the ./data.js
      // 2. Await the response DB object
      // 3. Put the response DB object to levels
      await dispatch('LEVEL_Data/APIdelete', getters.levelInFocus, {
        root: true,
      });
    },
  },
};

export default levelsUI;
