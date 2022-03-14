import Vue from 'vue';
import { EmptyEntity, Entity } from './utils';
import { modalModesDict } from '../constants';

const entitiesUI = {
  namespaced: true,
  state: () => ({
    entityDraft: new EmptyEntity(),

    entityIdInFocus: null,
    isEntityModalDisplayed: false,
    entityModalMode: modalModesDict.read,
    creatingEntityInLevelId: null,
  }),
  getters: {
    /* READ */
    getEntityDraft: ({ entityDraft }) => entityDraft,
    getEntityIdInFocus: ({ entityIdInFocus }) => entityIdInFocus,
    getIsEntityModalDisplayed: ({ isEntityModalDisplayed }) => isEntityModalDisplayed,
    getEntityModalMode: ({ entityModalMode }) => entityModalMode,
    getCreatingEntityInLevelId: ({ creatingEntityInLevelId }) => creatingEntityInLevelId,

    entityInFocus: (state, { getEntityIdInFocus }, rootState, rootGetters) =>
      rootGetters['ENTITY_Data/ENTITYById']({
        id: getEntityIdInFocus,
      }) ?? null,
  },
  mutations: {
    /* CREATE, UPDATE, DELETE */
    setEntityDraft: (state, { id, name, description, id, parentEntityID, tagIds }) => {
      state.entityDraft = new Entity({
        id,
        name,
        description,
        id,
        parentEntityID,
        tagIds,
      });
    },
    resetEntityDraft: (state) => {
      state.entityDraft = new EmptyEntity();
    },
    setEntityIdInFocus: (state, { newValue }) => {
      state.entityIdInFocus = newValue;
    },
    setIsEntityModalDisplayed: (state, { newValue }) => {
      state.isEntityModalDisplayed = newValue;
    },
    setEntityModalMode: (state, { newValue }) => {
      state.entityModalMode = newValue;
    },
    setCreatingEntityInLevelId: (state, { id }) => {
      state.creatingEntityInLevelId = id;
    },
  },
  actions: {
    readEntityHandler: ({ commit }, { id }) => {
      commit('setEntityModalMode', { newValue: modalModesDict.read });
      commit('setEntityIdInFocus', { newValue: id });
      commit('resetEntityDraft');
      commit('setIsEntityModalDisplayed', { newValue: true });
    },
    abortReadEntityHandler: async ({ commit }) => {
      commit('setIsEntityModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('setEntityIdInFocus', { newValue: null });
    },
    newEntityHandler: ({ commit }) => {
      commit('setEntityModalMode', { newValue: modalModesDict.create });
      commit('setEntityIdInFocus', { newValue: null });
      commit('resetEntityDraft');
      commit('setIsEntityModalDisplayed', { newValue: true });
    },
    abortNewEntityHandler: async ({ commit }) => {
      commit('setIsEntityModalDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('resetEntityDraft');
      commit('setCreatingEntityInLevelId', { id: null });
      commit('setEntityModalMode', { newValue: modalModesDict.read });
    },
    editEntityHandler: ({ commit, rootGetters }, { id }) => {
      commit('setEntityModalMode', { newValue: modalModesDict.edit });
      commit('setEntityIdInFocus', { newValue: id });
      const entity = rootGetters['ENTITY_Data/ENTITYById']({ id });
      commit('setEntityDraft', entity);
      commit('setIsEntityModalDisplayed', { newValue: true });
    },
    abortEditEntityHandler: async ({ commit }) => {
      commit('resetEntityDraft');
      await Vue.nextTick();
      commit('setEntityModalMode', { newValue: modalModesDict.read });
    },

    saveEntityHandler: async ({ dispatch, getters }) => {
      if (getters.getEntityModalMode === modalModesDict.read) return;
      const entityDraft = getters.getEntityDraft;
      if (getters.getEntityModalMode === modalModesDict.create) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to entities
        await dispatch('ENTITY_Data/APIpost', entityDraft, {
          root: true,
        });
        return;
      }
      if (getters.getEntityModalMode === modalModesDict.edit) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to entities
        await dispatch('ENTITY_Data/APIput', entityDraft, { root: true });
      }
    },
    deleteEntityHandler: async ({ dispatch, getters }) => {
      if (getters.getEntityModalMode === modalModesDict.read) return;
      if (getters.getEntityModalMode === modalModesDict.create) return;
      // 1. DELETE this in the ./data.js
      // 2. Await the response DB object
      // 3. Put the response DB object to entities
      await dispatch('ENTITY_Data/APIdelete', getters.getEntityIdInFocus, {
        root: true,
      });
    },
  },
};

export default entitiesUI;
