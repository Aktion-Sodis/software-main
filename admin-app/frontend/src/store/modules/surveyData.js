import { API, DataStore, Storage } from 'aws-amplify';
import { v4 as uuidv4 } from 'uuid';
import { deleteSurvey } from '../../graphql/mutations';
import {
  I18nString,
  Question,
  QuestionOption,
  Survey,
  // SurveyTag,
  // SurveySurveyTagRelation,
} from '../../models';
import { emptyQuestion, emptyQuestionOption } from '../../lib/classes';
import { dataTypesDict, modalModesDict, vuexModulesDict } from '../../lib/constants';
import { deriveFilePath } from '../../lib/utils';

const surveysData = {
  namespaced: true,
  state: () => ({
    surveys: [],
    // surveyTags: [],
    // relationSurveysAndTags: [],
    loading: false,
  }),
  getters: {
    /* READ */
    getSurveys: ({ surveys }) => surveys.filter((i) => !i._deleted).sort((a, b) => a.id - b.id),
    // getSurveyTags: ({ surveyTags }) => surveyTags,
    // getRelationSurveysAndTags: ({ relationSurveysAndTags }) => relationSurveysAndTags,
    getLoading: ({ loading }) => loading,

    SURVEYById:
      (_, { getSurveys }) => ({ id }) => getSurveys.find((s) => s.id === id),
    // tagById:
    // (_, { getSurveyTags }) => ({ tagId }) => getSurveyTags.find((t) => t.tagId === tagId),

    // tagIdsBySurveyId:
    // (_, { getRelationSurveysAndTags }) => ({ surveyId }) => getRelationSurveysAndTags.filter((r) => r.surveyId === surveyId).map((r) => r.surveyTagId),
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
    // setRelationSurveysAndTags: (state, { newValue }) => {
    //   state.relationSurveysAndTags = newValue;
    // },
    // setSurveyTags: (state, { newValue }) => {
    //   state.surveyTags = newValue;
    // },
  },
  actions: {
    APIpost: async ({ commit, dispatch, rootGetters }) => {
      let success = true;
      commit('setLoading', { newValue: true });

      const questionsWithUnnecessaryLastOne = rootGetters[`${vuexModulesDict.question}/getQuestionDrafts`];
      const questions = questionsWithUnnecessaryLastOne.slice(0, -1);
      const rawOptions = rootGetters[`${vuexModulesDict.question}/getOptionDrafts`];
      const options = [];

      // eslint-disable-next-line no-restricted-syntax
      for (const rawOption of rawOptions) {
        options.push(rawOption.filter((o) => !o.text.languageTexts.every((t) => t === '')));
      }

      const surveyDraft = rootGetters[`${vuexModulesDict.dataModal}/getDataDraft`];

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
      try {
        const postResponse = await DataStore.save(survey);
        // const tagIds = surveyDraft.tags;
        // // eslint-disable-next-line no-restricted-syntax
        // for (const tagId of tagIds) {
        //   const localTag = getters.tagById({ id: tagId });
        //   // eslint-disable-next-line no-await-in-loop
        //   await DataStore.save(
        //     new SurveySurveyTagRelation({
        //       survey: postResponse,
        //       surveyTag: localTag,
        //     }),
        //   );
        // }

        if (rootGetters[`${vuexModulesDict.dataModal}/getImageFile`]) {
          await Storage.put(
            deriveFilePath('interventionSurveyPicPath', {
              interventionID: survey.interventionSurveysId,
              surveyId: postResponse.id,
            }),
            rootGetters[`${vuexModulesDict.dataModal}/getImageFile`],
          );
        }

        rootGetters[`${vuexModulesDict.question}/getQuestionImages`].forEach(
          async (questionImg, index) => {
            if (questionImg) {
              await Storage.put(
                deriveFilePath('questionPicPath', {
                  interventionID: survey.interventionSurveysId,
                  surveyId: postResponse.id,
                  questionId: survey.questions[index].id,
                }),
                questionImg,
              );
            }
          },
        );

        commit('addSurvey', postResponse);
        dispatch(
          `${vuexModulesDict.dataModal}/readData`,
          {
            dataId: postResponse.id,
            dataType: dataTypesDict.survey,
          },
          {
            root: true,
          },
        );
      } catch {
        success = false;
      }

      commit('setLoading', { newValue: false });
      dispatch(
        `${vuexModulesDict.dataModal}/abortCreateData`,
        { dataType: dataTypesDict.survey },
        { root: true },
      );
      commit('setSurveyModalCompletionIndex', { newValue: 1 }, { root: true });
      commit(
        `${vuexModulesDict.question}/setQuestions`,
        { payload: [emptyQuestion()] },
        { root: true },
      );
      commit(
        `${vuexModulesDict.question}/setOptions`,
        { payload: [emptyQuestionOption()] },
        { root: true },
      );
      commit(`${vuexModulesDict.question}/setQuestionImages`, [], { root: true });
      return success;
    },
    APIput: async ({
      commit, dispatch, getters, rootGetters,
    }, { newData, originalId }) => {
      let success = true;
      commit('setLoading', { newValue: true });
      const original = getters.SURVEYById({ id: originalId });

      try {
        const res = await DataStore.save(
          Survey.copyOf(original, (updated) => {
            updated.name = newData.name;
            updated.description = newData.description;
            // updated.questions = newData.questions;
            updated.surveyType = newData.surveyType;
            updated.intervention = newData.intervention;
          }),
        );

        if (rootGetters[`${vuexModulesDict.dataModal}/getImageFile`]) {
          await Storage.put(
            deriveFilePath('interventionSurveyPicPath', {
              interventionID: res.intervention.id,
              surveyId: res.id,
            }),
            rootGetters[`${vuexModulesDict.dataModal}/getImageFile`],
          );
        }

        dispatch(
          `${vuexModulesDict.dataModal}/readData`,
          {
            dataId: originalId,
            dataType: dataTypesDict.survey,
          },
          {
            root: true,
          },
        );
      } catch {
        success = false;
      }
      commit('setLoading', { newValue: false });
      return success;
    },
    APIdelete: async ({ commit, dispatch, getters }, { id, _version }) => {
      let success = true;
      commit('setLoading', { newValue: true });

      try {
        await API.graphql({ query: deleteSurvey, variables: { input: { id, _version } } });
      } catch {
        success = false;
      }

      if (success) {
        const survey = getters.SURVEYById({ id });
        commit('deleteSurvey', {
          id,
        });

        Storage.remove(
          deriveFilePath('interventionSurveyPicPath', {
            interventionID: survey.intervention.id,
            surveyId: survey.id,
          }),
        );

        commit(`${vuexModulesDict.dataModal}/setDataIdInFocus`, { newValue: null }, { root: true });
        commit(
          `${vuexModulesDict.dataModal}/setMode`,
          { newValue: modalModesDict.read },
          { root: true },
        );
        dispatch(
          `${vuexModulesDict.dataModal}/abortReadData`,
          {},
          {
            root: true,
          },
        );
      }

      commit('setLoading', { newValue: false });
      return success;
    },
    APIgetAll: async () => {
      try {
        return await DataStore.query(Survey);
      } catch {
        return [];
      }
    },
  },
};

export default surveysData;
