import Vue from 'vue';
import { dataTypesDict, modalModesDict, vuexModulesDict } from '../../lib/constants';
import {
  emptySurvey, emptyIntervention, emptyLevel, emptyEntity,
} from '../../lib/classes';
import i18n from '../../i18n';

const dataModal = {
  namespaced: true,
  state: () => ({
    dataType: dataTypesDict.entity,
    mode: modalModesDict.read,
    isDisplayed: false,
    dataIdInFocus: null,
    dataDraft: null,
    imageFile: null,
  }),
  getters: {
    /* READ */
    getDataType: ({ dataType }) => dataType,
    getMode: ({ mode }) => mode,
    getIsDisplayed: ({ isDisplayed }) => isDisplayed,
    getDataIdInFocus: ({ dataIdInFocus }) => dataIdInFocus,
    getDataDraft: ({ dataDraft }) => dataDraft,
    getImageFile: ({ imageFile }) => imageFile,
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
    setImageFile: (state, { newValue }) => {
      state.imageFile = newValue;
    },

    setDraft: (state, draft) => {
      state.dataDraft = draft;
    },

    resetENTITYDraft: (state) => {
      state.dataDraft = emptyEntity();
    },
    resetLEVELDraft: (state) => {
      state.dataDraft = emptyLevel();
    },
    resetINTERVENTIONDraft: (state) => {
      state.dataDraft = emptyIntervention();
    },
    resetSURVEYDraft: (state) => {
      state.dataDraft = emptySurvey();
    },
  },
  actions: {
    readData: ({ commit }, { dataId, dataType }) => {
      commit('setDataType', { newValue: dataType });
      commit('setMode', { newValue: modalModesDict.read });
      commit('setDataIdInFocus', { newValue: dataId });
      commit('setIsDisplayed', { newValue: true });
      commit('setImageFile', { newValue: null });
    },
    abortReadData: async ({ commit, getters }) => {
      commit('setIsDisplayed', { newValue: false });
      if (getters.getDataType === dataTypesDict.survey) {
        commit('setSurveyModalCompletionIndex', { newValue: 1 }, { root: true });
        commit('QUESTION_UI/setIQuestions', { payload: 0 }, { root: true });
      }
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
    abortCreateData: async ({ commit, getters }) => {
      const dataType = getters.getDataType;
      commit('setIsDisplayed', { newValue: false });
      await Vue.nextTick();
      commit(`reset${dataType}Draft`);
      commit('setMode', { newValue: modalModesDict.read });
      commit('setImageFile', { newValue: null });
      if (dataType === dataTypesDict.entity) commit('setCreatingEntityInLevelId', { id: null }, { root: true });
    },
    editData: ({ commit, getters, rootGetters }) => {
      const dataId = getters.getDataIdInFocus;
      const dataType = getters.getDataType;
      commit('setMode', { newValue: modalModesDict.edit });
      commit('setDataIdInFocus', { newValue: dataId });
      commit('setDataType', { newValue: dataType });
      const data = rootGetters[`${dataType}_Data/${dataType}ById`]({ id: dataId });
      commit('setDraft', data);
    },
    abortEditData: async ({ commit, getters }) => {
      const dataType = getters.getDataType;
      commit(`reset${dataType}Draft`);
      await Vue.nextTick();
      commit('setMode', { newValue: modalModesDict.read });
      commit('setImageFile', { newValue: null });
    },

    saveData: async ({ dispatch, getters }) => {
      const dataType = getters.getDataType;
      if (getters.getMode === modalModesDict.read) return;
      const draft = getters.getDataDraft;
      let success = false;
      if (getters.getMode === modalModesDict.create) {
        success = await dispatch(`${dataType}_Data/APIpost`, draft, { root: true });
      } else if (getters.getMode === modalModesDict.edit) {
        success = await dispatch(
          `${dataType}_Data/APIput`,
          {
            newData: draft,
            originalId: getters.getDataIdInFocus,
          },
          { root: true },
        );
      }
      dispatch(
        `${vuexModulesDict.feedback}/showFeedbackForDuration`,
        {
          type: success ? 'success' : 'error',
          text: i18n.t(
            `general.operationFeedback.data.${success ? 'success' : 'error'}.${
              getters.getMode === modalModesDict.create ? 'create' : 'update'
            }`,
          ),
        },
        {
          root: true,
        },
      );
      // TODO: Too costly. Find a leaner way of updating the data.
      dispatch(
        `${vuexModulesDict.sync}/refreshHandler`,
        {},
        {
          root: true,
        },
      );
    },
    deleteData: async ({ dispatch, getters }) => {
      const dataType = getters.getDataType;
      if (getters.getMode === modalModesDict.read) return;
      const success = await dispatch(
        `${dataType}_Data/APIdelete`,
        { id: getters.getDataIdInFocus, _version: getters.getDataDraft._version },
        { root: true },
      );
      dispatch(
        `${vuexModulesDict.feedback}/showFeedbackForDuration`,
        {
          type: success ? 'success' : 'error',
          text: i18n.t(`general.operationFeedback.data.${success ? 'success' : 'error'}.archive`),
        },
        {
          root: true,
        },
      );

      // TODO: Too costly. Find a leaner way of updating the data.
      dispatch(
        `${vuexModulesDict.sync}/refreshHandler`,
        {},
        {
          root: true,
        },
      );
    },
    archiveData: async ({ dispatch, getters }) => {
      const dataType = getters.getDataType;
      if (getters.getMode !== modalModesDict.edit) return;
      const success = await dispatch(
        `${dataType}_Data/APIput`,
        {
          newData: { ...getters.getDataDraft, archived: true },
          originalId: getters.getDataIdInFocus,
        },
        { root: true },
      );
      dispatch(
        `${vuexModulesDict.feedback}/showFeedbackForDuration`,
        {
          type: success ? 'success' : 'error',
          text: i18n.t(`general.operationFeedback.data.${success ? 'success' : 'error'}.delete`),
        },
        {
          root: true,
        },
      );

      // TODO: Too costly. Find a leaner way of updating the data.
      dispatch(
        `${vuexModulesDict.sync}/refreshHandler`,
        {},
        {
          root: true,
        },
      );
    },
  },
};

export default dataModal;
