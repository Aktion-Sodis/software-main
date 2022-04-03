// import { API, DataStore } from 'aws-amplify';
// import { createSurvey } from '../../graphql/mutations';
import { API, DataStore } from 'aws-amplify';
import { v4 as uuidv4 } from 'uuid';
import { deleteSurvey, updateSurvey } from '../../graphql/mutations';
// import { listSurveys, listSurveyTags } from '../../graphql/queries';
import {
  I18nString,
  Question,
  QuestionOption,
  Survey,
  SurveyTag,
  SurveySurveyTagRelation,
} from '../../models';
import { dataTypesDict, modalModesDict } from '../constants';

const surveysData = {
  namespaced: true,
  state: () => ({
    surveys: [],
    surveyTags: [],
    relationSurveysAndTags: [],
    loading: false,
  }),
  getters: {
    /* READ */
    getSurveys: ({ surveys }) => surveys.filter((i) => !i._deleted).sort((a, b) => a.id - b.id),
    getSurveyTags: ({ surveyTags }) => surveyTags,
    getRelationSurveysAndTags: ({ relationSurveysAndTags }) => relationSurveysAndTags,
    getLoading: ({ loading }) => loading,

    SURVEYById:
      (_, { getSurveys }) => ({ id }) => getSurveys.find((s) => s.id === id),
    tagById:
      (_, { getSurveyTags }) => ({ tagId }) => getSurveyTags.find((t) => t.tagId === tagId),

    tagIdsBySurveyId:
      (_, { getRelationSurveysAndTags }) => ({ surveyId }) => getRelationSurveysAndTags.filter((r) => r.surveyId === surveyId).map((r) => r.surveyTagId),
  },
  mutations: {
    addSurvey: (state, survey) => {
      state.surveys.push(survey);
    },
    replaceSurvey: (state, survey) => {
      state.surveys.splice(
        state.surveys.findIndex((i) => i.id === survey.id),
        1,
        survey,
      );
    },
    deleteSurvey: (state, { id }) => {
      state.surveys.splice(
        Array.from(state.surveys).findIndex((i) => i.id === id),
        1,
      );
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
    setSurveys: (state, { newValue }) => {
      state.surveys = newValue;
    },
    setRelationSurveysAndTags: (state, { newValue }) => {
      state.relationSurveysAndTags = newValue;
    },
    setSurveyTags: (state, { newValue }) => {
      state.surveyTags = newValue;
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
        name: new I18nString(surveyDraft.name),
        description: new I18nString(surveyDraft.description),
        interventionSurveysId: surveyDraft.interventionSurveysId,
        questions: questions.map(
          (q, i) => new Question({
            ...q,
            questionOptions: options[i].map(
              (o) => new QuestionOption({ ...o, id: uuidv4(), followUpQuestionID: null }),
            ),
          }),
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
          dispatch('dataModal/abortCreateData', { dataType: dataTypesDict.survey }, { root: true });
          commit('setSurveyModalCompletionIndex', { newValue: 1 }, { root: true });
        })
        .catch((err) => {
          console.log({ err });
          commit('setLoading', { newValue: false });
        });
    },
    APIput: async ({ commit, dispatch }, { newData, originalId, originalVersion }) => {
      commit('setLoading', { newValue: true });
      API.graphql({
        query: updateSurvey,
        variables: {
          input: {
            id: originalId,
            _version: originalVersion,
            name: newData.name,
            description: newData.description,
            surveyType: newData.surveyType,
          },
        },
      })
        .then((putResponse) => {
          dispatch(
            'dataModal/readData',
            {
              dataId: putResponse.data.updateSurvey.id,
              dataType: dataTypesDict.survey,
            },
            {
              root: true,
            },
          );
          commit('replaceSurvey', putResponse.data.updateSurvey);
          commit('setLoading', { newValue: false });
        })
        .catch((err) => {
          console.log({ err });
          commit('setLoading', { newValue: false });
        });
    },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      commit('setLoading', { newValue: true });
      API.graphql({ query: deleteSurvey, variables: { input: { id, _version } } })
        .then(() => {
          commit('deleteSurvey', {
            id,
          });
          commit('dataModal/setDataIdInFocus', { newValue: null }, { root: true });
          commit('dataModal/setMode', { newValue: modalModesDict.read }, { root: true });
          dispatch(
            'dataModal/abortReadData',
            {},
            {
              root: true,
            },
          );
          commit('setLoading', { newValue: false });
        })
        .catch((err) => {
          // TODO: Handle error
          console.log({ err });
        });
    },
    APIgetAll: async () => ({
      apiSurveys: await DataStore.query(Survey),
      apiSurveyTags: await DataStore.query(SurveyTag),
      apiRelationSurveysAndTags: await DataStore.query(SurveySurveyTagRelation),
    }),
    sync: async ({ commit, dispatch }) => {
      commit('setLoading', { newValue: true });

      // const apiSurveys = await DataStore.query(Survey);

      // const apiSurveyTags = await DataStore.query(SurveyTag);

      const { apiSurveys, apiSurveyTags, apiRelationSurveysAndTags } = await dispatch('APIgetAll');

      commit('setSurveys', { newValue: apiSurveys });
      commit('setSurveyTags', { newValue: apiSurveyTags });
      commit('setRelationSurveysAndTags', {
        newValue: apiRelationSurveysAndTags.map((r) => ({
          surveyId: r.survey.id,
          surveyTagId: r.surveyTag.id,
        })),
      });
      commit('setLoading', { newValue: false });
    },
  },
};

export default surveysData;
