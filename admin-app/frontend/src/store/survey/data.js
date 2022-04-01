// import { API, DataStore } from 'aws-amplify';
// import { createSurvey } from '../../graphql/mutations';
import { DataStore } from 'aws-amplify';
import { Question, QuestionOption, Survey } from '../../models';
import { dataTypesDict } from '../constants';

const surveysData = {
  namespaced: true,
  state: () => ({
    surveys: [],
    surveyTags: [],
    loading: false,
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

    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch, rootGetters }) => {
      commit('setLoading', { newValue: true });

      const questionsWithUnnecessaryLastOne = rootGetters['QUESTION_UI/getQuestionDrafts'];
      const questions = questionsWithUnnecessaryLastOne.slice(0, -1);
      const rawOptions = rootGetters['QUESTION_UI/getOptionDrafts'];
      const options = [];

      // eslint-disable-next-line no-restricted-syntax
      for (const rawOption of rawOptions) {
        options.push(rawOption.filter((o) => !o.text.languageTexts.every((t) => t === '')));
      }

      const surveyDraft = rootGetters['dataModal/getDataDraft'];

      const survey = new Survey({
        name: surveyDraft.name,
        interventionSurveysId: surveyDraft.interventionSurveysId,
        description: surveyDraft.description,
        questions: questions.map(
          (q, i) => new Question({ ...q, questionOptions: options[i].map((o) => new QuestionOption(o)) }),
        ),
        tags: [],
        surveyType: surveyDraft.surveyType,
      });

      DataStore.save(survey)
        .then((postResponse) => {
          commit('addSurvey', postResponse);
          dispatch(
            'dataModal/readData',
            {
              dataId: postResponse.id,
              dataType: dataTypesDict.survey,
            },
            {
              root: true,
            },
          );
          commit('setLoading', { newValue: false });
        })
        .catch((err) => {
          console.log({ err });
          commit('setLoading', { newValue: false });
        });
    },
    // APIput: async ({ commit }) => {},
    // API.graphql({query: createSurvey, variables: {input: surveyDraft}})
    // APIgetNewSurvey: async ({ commit }) => {},
  },
};

export default surveysData;
