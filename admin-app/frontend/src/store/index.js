import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';

// import modules
import authModule from './authModule';
import interventionsData from './interventions/data';
import surveysData from './survey/data';
import QUESTION_UI from './questions/ui';
import FEEDBACK_UI from './feedback/ui';
import levelsData from './levels/data';
import entitiesData from './entities/data';
import dataModal from './modal/ui';

// persist
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  modules: ['auth'],
});

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    lineColors: ['green', 'orange', 'blue', 'red', 'yellow', 'purple'],
    creatingEntityInLevelId: null,
    surveyModalCompletionIndex: 1,
  },
  getters: {
    getLineColors: (state) => state.lineColors,
    getCreatingEntityInLevelId: ({ creatingEntityInLevelId }) => creatingEntityInLevelId,
    getSurveyModalCompletionIndex: ({ surveyModalCompletionIndex }) => surveyModalCompletionIndex,
  },
  mutations: {
    setCreatingEntityInLevelId: (state, { id }) => {
      state.creatingEntityInLevelId = id;
    },
    incrementSurveyModalCompletionIndex: (state) => {
      state.surveyModalCompletionIndex += 1;
    },
    decrementSurveyModalCompletionIndex: (state) => {
      state.surveyModalCompletionIndex -= 1;
    },
  },
  actions: {
    publishSurveyHandler: () => {},
  },
  modules: {
    auth: authModule,
    dataModal,
    ENTITY_Data: entitiesData,
    SURVEY_Data: surveysData,
    LEVEL_Data: levelsData,
    INTERVENTION_Data: interventionsData,
    QUESTION_UI,
    FEEDBACK_UI,
  },
  plugins: [vuexLocal.plugin],
});
