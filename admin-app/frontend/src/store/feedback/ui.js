import i18n from '../../i18n';
import { typesDictionary } from './utils';

const defaultDuration = 5000;

const FEEDBACK_UI = {
  namespaced: true,
  state: () => ({
    type: typesDictionary.success,
    text: '',
    isDisplayed: false,
    duration: defaultDuration,
  }),
  getters: {
    getType: ({ type }) => type,
    getText: ({ text }) => text,
    getIsDisplayed: ({ isDisplayed }) => isDisplayed,
    getDuration: ({ duration }) => duration,
  },
  mutations: {
    setType: (state, { newType }) => {
      state.type = newType;
    },
    setText: (state, { newText }) => {
      state.text = newText;
    },
    setIsDisplayed: (state, { newValue }) => {
      state.isDisplayed = newValue;
    },
    setDuration: (state, { newDuration }) => {
      state.duration = newDuration;
    },
  },
  actions: {
    showFeedbackForDuration: ({ commit, getters }, { type, duration, text }) => {
      if (getters.getIsDisplayed) commit('setIsDisplayed', { newValue: false });
      commit('setDuration', { newDuration: duration ?? defaultDuration });
      commit('setType', { newType: type });
      commit('setText', { newText: text });
      commit('setIsDisplayed', { newValue: true });
    },
    showToBeImplementedFeedback: ({ dispatch }) => {
      dispatch('showFeedbackForDuration', {
        type: typesDictionary.info,
        text: i18n.t('development.notYetImplemented'),
      });
    },
  },
};

export default FEEDBACK_UI;
