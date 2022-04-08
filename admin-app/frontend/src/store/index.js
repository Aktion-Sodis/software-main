import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';
import i18n from '../i18n';

// import modules
import authModule from './authModule';
import interventionsData from './interventions/data';
import surveysData from './survey/data';
import QUESTION_UI from './questions/ui';
import FEEDBACK_UI from './feedback/ui';
import levelsData from './levels/data';
import entitiesData from './entities/data';
import dataModal from './modal/ui';
import SYNC_UI from './sync/ui';

// persist
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  modules: ['auth'],
});

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    // TODO: Later, a randomized color method must be appealed.
    lineColors: [
      'green',
      'orange',
      'blue',
      'red',
      'yellow',
      'purple',
      'pink',
      'grey',
      'black',
      'brown',
      'cyan',
      'indigo',
      'lime',
      'magenta',
      'olive',
      'teal',
      'violet',
      'crimson',
      'darkblue',
      'darkgreen',
      'darkred',
      'darkyellow',
      'darkpurple',
      'darkorange',
      'darkpink',
      'darkgrey',
      'darkbrown',
      'darkcyan',
      'darkindigo',
      'darklime',
      'darkmagenta',
      'darkolive',
      'darkteal',
      'darkviolet',
      'darkcrimson',
      'lightblue',
      'lightgreen',
      'lightred',
      'lightyellow',
      'lightpurple',
      'lightorange',
      'lightpink',
      'lightgrey',
      'lightbrown',
      'lightcyan',
      'lightindigo',
      'lightlime',
      'lightmagenta',
      'lightolive',
      'lightteal',
      'lightviolet',
      'lightcrimson',
    ],
    creatingEntityInLevelId: null,
    surveyModalCompletionIndex: 1,
  },
  getters: {
    getLineColors: (state) => state.lineColors,
    getCreatingEntityInLevelId: ({ creatingEntityInLevelId }) => creatingEntityInLevelId,
    getSurveyModalCompletionIndex: ({ surveyModalCompletionIndex }) => surveyModalCompletionIndex,

    // NOTE: You probably will never need the following two getters. Use the latter two instead, since they are based on these two!
    fallbackLocaleIndex: () => i18n.availableLocales.findIndex((l) => l === i18n.fallbackLocale),
    uiLocaleIndex: () => i18n.availableLocales.findIndex((l) => l === i18n.locale),

    calculateLocalizedString:
      (_, { fallbackLocaleIndex }) => ({ languageTexts }) => languageTexts[fallbackLocaleIndex] || i18n.t('general.noTextProvided'),

    // For the localization, you will most probably only need this getter and no other! Please don't consider using the others.
    calculateUILocaleString:
      (_, { uiLocaleIndex, calculateLocalizedString }) => ({ languageTexts }) => languageTexts[uiLocaleIndex] || calculateLocalizedString({ languageTexts }),

    calculateIndexByLocale:
      () => ({ locale }) => i18n.availableLocales.findIndex((l) => l === locale),
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
    setSurveyModalCompletionIndex: (state, { newValue }) => {
      state.surveyModalCompletionIndex = newValue;
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
    SYNC_UI,
  },
  plugins: [vuexLocal.plugin],
});
