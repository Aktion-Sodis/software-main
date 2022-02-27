import { Survey } from './utils';

const surveysData = {
  namespaced: true,
  state: () => ({
    surveys: [
      {
        id: '6a13dbb7-7cc3-45d7-99e9-a6f764156fc6',
        name: 'My survey',
        description: 'Just some survey',
        type: 'Initial',
        questions: [],
        creationDate: 1641335580514,
        lastEditDate: null,
        tags: ['c3089035-a6c7-417f-bed5-6a2d4ba44ec6'],
      },
    ],
    surveyTags: [{ tagId: 'c3089035-a6c7-417f-bed5-6a2d4ba44ec6', name: 'Some tag' }],
  }),
  getters: {
    /* READ */
    getSurveys: ({ surveys }) => surveys,
    getSurveyTags: ({ surveyTags }) => surveyTags,

    SURVEYById:
      (_, { getSurveys }) => ({ id }) => getSurveys.find((s) => s.id === id),
    tagById:
      (_, { getSurveyTags }) => ({ tagId }) => getSurveyTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addSurvey: (state, {
      id, name, description, type, questions, creationDate, lastEditDate,
    }) => {
      state.surveys.push(
        new Survey({
          id,
          name,
          description,
          type,
          questions,
          creationDate,
          lastEditDate,
        }),
      );
    },
    replaceSurvey: (
      state,
      {
        id, name, description, type, questions, creationDate, lastEditDate,
      },
    ) => {
      state.surveys = state.surveys.map((s) => (s.id === id
        ? {
          ...s,
          id,
          name,
          description,
          type,
          questions,
          creationDate,
          lastEditDate,
        }
        : s));
    },
    deleteSurvey: (state, id) => {
      state.surveys = state.surveys.filter((s) => s.id !== id);
    },
  },
  actions: {
    // APIpost: async ({ commit }) => {},
    // APIput: async ({ commit }) => {},
    // APIgetNewSurvey: async ({ commit }) => {},
  },
};

export default surveysData;
