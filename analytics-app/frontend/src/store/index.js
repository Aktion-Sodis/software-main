import { createStore } from 'vuex';

import surveyData from './surveys';
import questionData from './questions';
import charts from './charts';

const store = createStore({
  state: () => ({

  }),
  modules: {
    surveyData: surveyData,
    questionData: questionData,
    charts: charts,
  },
});

export default store;
