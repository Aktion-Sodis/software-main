import { EmptySurvey, Survey } from './utils';
import { modalModesDict } from '../../lib/constants';

const surveysUI = {
  namespaced: true,
  state: () => ({
    surveyDraft: new EmptySurvey(),

    surveyIdInFocus: null,
    isSurveyModalDisplayed: false,
    surveyModalMode: modalModesDict.read,
    surveyModalCompletionIndex: 0,
    loading: false,
  }),
  getters: {
    /* READ */
    getSurveyIdInFocus: ({ surveyIdInFocus }) => surveyIdInFocus,
    getIsSurveyModalDisplayed: ({ isSurveyModalDisplayed }) => isSurveyModalDisplayed,
    getSurveyModalMode: ({ surveyModalMode }) => surveyModalMode,
    getSurveyModalCompletionIndex: ({ surveyModalCompletionIndex }) => surveyModalCompletionIndex,
    getSurveyDraft: ({ surveyDraft }) => surveyDraft,
    getLoading: ({ loading }) => loading,
    surveyInFocus: (state, { getSurveyIdInFocus }, rootState, rootGetters) => getSurveyIdInFocus
      && (rootGetters['SURVEY_Data/SURVEYById']({ id: getSurveyIdInFocus }) ?? null),
    surveyNameInFocus: (_, { surveyIdInFocus }) => surveyIdInFocus?.name ?? '',
  },
  mutations: {
    /* CREATE, UPDATE, DELETE */
    setSurveyIdInFocus: (state, { newValue }) => {
      state.surveyIdInFocus = newValue;
    },
    setIsSurveyModalDisplayed: (state, { newValue }) => {
      state.isSurveyModalDisplayed = newValue;
    },
    setSurveyModalMode: (state, { newValue }) => {
      state.surveyModalMode = newValue;
    },
    setSurveyModalCompletionIndex: (state, { newValue }) => {
      state.surveyModalCompletionIndex = newValue;
    },
    incrementSurveyModalCompletionIndex: (state) => {
      state.surveyModalCompletionIndex += 1;
    },
    decrementSurveyModalCompletionIndex: (state) => {
      state.surveyModalCompletionIndex -= 1;
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
    setSurveyDraft: (
      state,
      {
        id, name, description, tags, type, questionIds, creationDate, lastEditDate,
      },
    ) => {
      state.surveyDraft = new Survey({
        id,
        name,
        description,
        type,
        tags,
        questionIds,
        creationDate,
        lastEditDate,
      });
    },
    resetSurveyDraft: (state) => {
      state.surveyDraft = new EmptySurvey();
    },
  },
  actions: {
    readSurveyHandler: ({ commit }, { id }) => {
      commit('setSurveyModalMode', { newValue: modalModesDict.read });
      commit('setSurveyModalCompletionIndex', { newValue: 1 });
      commit('setSurveyIdInFocus', { newValue: id });
      commit('setIsSurveyModalDisplayed', { newValue: true });
    },
    abortReadSurveyHandler: ({ commit }) => {
      commit('setIsSurveyModalDisplayed', { newValue: false });
      commit('setSurveyIdInFocus', { newValue: null });
      commit('setSurveyModalCompletionIndex', { newValue: 0 });
    },
    newSurveyHandler: ({ commit }) => {
      commit('setSurveyModalMode', { newValue: modalModesDict.create });
      commit('setSurveyIdInFocus', { newValue: null });
      commit('resetSurveyDraft');
      commit('setSurveyModalCompletionIndex', { newValue: 1 });
      commit('setIsSurveyModalDisplayed', { newValue: true });
    },
    abortNewSurveyHandler: ({ commit }) => {
      commit('setIsSurveyModalDisplayed', { newValue: false });
      commit('setSurveyModalCompletionIndex', { newValue: 0 });
      commit('resetSurveyDraft');
      commit('setSurveyModalMode', { newValue: modalModesDict.read });
    },
    editSurveyHandler: ({ commit, rootGetters }, { id }) => {
      commit('setSurveyModalMode', { newValue: modalModesDict.edit });
      commit('setSurveyIdInFocus', { newValue: id });
      const survey = rootGetters['SURVEY_Data/SURVEYById']({ id });
      commit('setSurveyDraft', survey);
      commit('setSurveyModalCompletionIndex', { newValue: 1 });
      commit('setIsSurveyModalDisplayed', { newValue: true });
    },
    abortEditSurveyHandler: ({ commit }) => {
      commit('setIsSurveyModalDisplayed', { newValue: false });
      commit('setSurveyModalCompletionIndex', { newValue: 0 });
      commit('resetSurveyDraft');
      commit('setSurveyIdInFocus', { newValue: null });
      commit('setSurveyModalMode', { newValue: modalModesDict.read });
    },

    saveSurveyHandler: async ({ commit, dispatch, getters }) => {
      if (getters.getSurveyModalMode === modalModesDict.read) return;
      commit('setLoading', { newValue: true });
      const surveyDraft = getters.getSurveyDraft;
      if (getters.getSurveyModalMode === modalModesDict.create) {
        // 1. POST this in the ./data.js
        // 2. Await the response DB object
        // 3. Put the response DB object to surveys
        const createdSurvey = await dispatch('SURVEY_Data/APIpost', surveyDraft, {
          root: true,
        });
        commit('SURVEY_Data/addSurvey', createdSurvey, { root: true });
        commit('setSurveyIdInFocus', { newValue: createdSurvey.id });
        commit('setSurveyModalMode', { newValue: modalModesDict.read });
        commit('setLoading', { newValue: false });
      }
    },
  },
};

export default surveysUI;
