import { createStore } from 'vuex';

import surveyData from './surveys';
import questionData from './questions';

const store = createStore({
  state: () => ({

  }),
  modules: {
    surveyData: surveyData,
    questionData: questionData,
  },
});

export default store;
