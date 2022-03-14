import Vue from 'vue';
import { dataTypesDict, modalModesDict } from '../constants';
import { EmptyEntity, Entity } from '../entities/utils';
import { EmptyIntervention, Intervention } from '../interventions/utils';
import { EmptyLevel, Level } from '../levels/utils';
import { EmptySurvey, Survey } from '../survey/utils';

const dataModal = {
  namespaced: true,
  state: () => ({
    dataType: dataTypesDict.entity,
    mode: modalModesDict.read,
    isDisplayed: false,
    dataIdInFocus: null,
    dataDraft: new EmptyEntity(),
  }),
  getters: {
    /* READ */
    getDataType: ({ dataType }) => dataType,
    getMode: ({ mode }) => mode,
    getIsDisplayed: ({ isDisplayed }) => isDisplayed,
    getDataIdInFocus: ({ dataIdInFocus }) => dataIdInFocus,
    getDataDraft: ({ dataDraft }) => dataDraft,
  },
  mutations: {
    /* UPDATE, DELETE */
    setDataIdInFocus: (state, { newValue }) => {
      state.dataIdInFocus = newValue;
    },
    setIsDisplayed: (state, { newValue }) => {
      state.isDisplayed = newValue;
    },
    setMode: (state, { newValue }) => {
      state.mode = newValue;
    },
    setDataType: (state, { newValue }) => {
      state.dataType = newValue;
    },

    /* ENTITY DRAFT: SET & RESET */
    setENTITYDraft: (state, {
      id, name, description, entityLevelId, parentEntityID, _version,
    }) => {
      state.dataDraft = new Entity({
        id,
        name,
        description,
        entityLevelId,
        parentEntityID,
        _version,
      });
    },
    resetENTITYDraft: (state) => {
      state.dataDraft = new EmptyEntity();
    },

    /* LEVEL DRAFT: SET & RESET */
    setLEVELDraft: (
      state,
      {
        id, name, description, parentLevelID, allowedInterventions, _version,
      },
    ) => {
      state.dataDraft = new Level({
        id,
        name,
        description,
        parentLevelID,
        allowedInterventions,
        _version,
      });
    },
    resetLEVELDraft: (state) => {
      state.dataDraft = new EmptyLevel();
    },

    /* INTERVENTION DRAFT: SET & RESET */
    setINTERVENTIONDraft: (state, {
      id, name, description, tagIds, contents, _version,
    }) => {
      state.dataDraft = new Intervention({
        id,
        name,
        description,
        tagIds,
        contents,
        _version,
      });
    },
    resetINTERVENTIONDraft: (state) => {
      state.dataDraft = new EmptyIntervention();
    },

    /* SURVEY DRAFT: SET & RESET */
    setSURVEYDraft: (
      state,
      {
        id, name, description, tags, type, questionIds, creationDate, lastEditDate, _version,
      },
    ) => {
      state.dataDraft = new Survey({
        id,
        name,
        description,
        tags,
        type,
        questionIds,
        creationDate,
        lastEditDate,
        _version,
      });
    },
    resetSURVEYDraft: (state) => {
      state.dataDraft = new EmptySurvey();
    },
  },
  actions: {
    readData: ({ commit }, { dataId, dataType }) => {
      commit('setDataType', { newValue: dataType });
      commit('setMode', { newValue: modalModesDict.read });
      commit('setDataIdInFocus', { newValue: dataId });
      commit('setIsDisplayed', { newValue: true });
    },
    abortReadData: async ({ commit }) => {
      commit('setIsDisplayed', { newValue: false });
      await Vue.nextTick();
      commit('setDataIdInFocus', { newValue: null });
    },
    createData: ({ commit }, { dataType }) => {
      commit('setMode', { newValue: modalModesDict.create });
      commit('setDataIdInFocus', { newValue: null });
      commit('setDataType', { newValue: dataType });
      commit(`reset${dataType}Draft`);
      commit('setIsDisplayed', { newValue: true });
    },
    abortCreateData: async ({ commit }, { dataType }) => {
      commit('setIsDisplayed', { newValue: false });
      await Vue.nextTick();
      commit(`reset${dataType}Draft`);
      commit('setMode', { newValue: modalModesDict.read });
    },
    editData: ({ commit, rootGetters }, { dataId, dataType }) => {
      commit('setMode', { newValue: modalModesDict.edit });
      commit('setDataIdInFocus', { newValue: dataId });
      commit('setDataType', { newValue: dataType });
      const data = rootGetters[`${dataType}_Data/${dataType}ById`]({ id: dataId });
      commit(`set${dataType}Draft`, data);
      // commit('setIsDisplayed', { newValue: true });
    },
    abortEditData: async ({ commit }, { dataType }) => {
      commit(`reset${dataType}Draft`);
      await Vue.nextTick();
      commit('setMode', { newValue: modalModesDict.read });
    },

    saveData: async ({ dispatch, getters }, { dataType }) => {
      if (getters.getMode === modalModesDict.read) return;
      const draft = getters.getDataDraft;
      if (getters.getMode === modalModesDict.create) {
        await dispatch(`${dataType}_Data/APIpost`, draft, { root: true });
        return;
      }
      if (getters.getMode === modalModesDict.edit) {
        await dispatch(`${dataType}_Data/APIput`, draft, { root: true });
      }
    },
    deleteData: async ({ dispatch, getters }, { dataType }) => {
      if (getters.getEntityModalMode === modalModesDict.read) return;
      if (getters.getEntityModalMode === modalModesDict.create) return;
      await dispatch(`${dataType}_Data/APIdelete`, getters.getDataDraft, { root: true });
    },
  },
};

export default dataModal;
