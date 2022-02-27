import { EmptyQuestion, EmptyAnswer } from './utils';

const QUESTION_UI = {
  namespaced: true,
  state: () => ({
    iQuestions: 0,
    questionDrafts: [new EmptyQuestion()],
    answerDrafts: [[new EmptyAnswer()]],
  }),
  getters: {
    /* READ */
    getIQuestions: ({ iQuestions }) => iQuestions ?? 0,
    getQuestionDrafts: ({ questionDrafts }) => questionDrafts || [new EmptyQuestion()],
    getAnswerDrafts: ({ answerDrafts }) => answerDrafts || [[new EmptyAnswer()]],

    questionWithAnswersDrafts: (_, { getQuestionDrafts, getAnswerDrafts }) => getQuestionDrafts.map((q, i) => ({
      ...q,
      answerDrafts: getAnswerDrafts[i],
    })),
    nQuestions: (_, { getQuestionDrafts }) => getQuestionDrafts.length ?? 1,
    isAtFirstQuestion: (_, { getIQuestions }) => getIQuestions === 0,
    isAtLastQuestion: (_, { getIQuestions, nQuestions }) => getIQuestions === nQuestions - 1,
    questionCurrentDraft: (_, { getQuestionDrafts, getIQuestions }) => getQuestionDrafts[getIQuestions],
    answersCurrentDraft: (_, { getAnswerDrafts, getIQuestions }) => getAnswerDrafts[getIQuestions],
    currentQuestionWithAnswers: (_, { getAnswerDrafts, getQuestionDrafts, getIQuestions }) => ({
      ...getQuestionDrafts[getIQuestions],
      answerDrafts: getAnswerDrafts[getIQuestions],
    }),
    questionTextInFocus: (state, { getIQuestions }, rootState, rootGetters) => rootGetters['SURVEY_Data/SURVEYById']({ id: rootGetters['modalData/getDataIdInFocus'] })
      ?.questions[getIQuestions] ?? '',
  },
  mutations: {
    /* INDEX OPERATIONS */
    setIQuestions: (state, { payload }) => {
      state.iQuestions = payload;
    },
    incrementIQuestions: (state) => {
      state.iQuestions += 1;
    },
    decrementIQuestions: (state) => {
      state.iQuestions -= 1;
    },

    /* QUESTION & ANSWER BULK UPDATE */
    setQuestions: (state, { payload }) => {
      state.questionDrafts = payload;
    },
    setAnswers: (state, { payload }) => {
      state.answerDrafts = payload;
    },

    /* QUESTION CREATE, UPDATE, DELETE */
    addQuestionAtIndex: (state, { newQuestion, index }) => {
      state.questionDrafts.splice(index, 0, newQuestion);
    },
    replaceQuestionAtIndex: (state, { newQuestion, index }) => {
      state.questionDrafts.splice(index, 1, newQuestion);
    },
    deleteQuestionAtIndex: (state, { index }) => {
      state.questionDrafts.splice(index, 1);
    },

    /* ANSWER CREATE, UPDATE, DELETE */
    addAnswerAtIndex: (state, { newAnswers, index }) => {
      state.answerDrafts.splice(index, 0, newAnswers);
    },
    replaceAnswerAtIndex: (state, { newAnswers, index }) => {
      state.answerDrafts.splice(index, 1, newAnswers);
    },
    deleteAnswerAtIndex: (state, { index }) => {
      state.answerDrafts.splice(index, 1);
    },
  },
  actions: {
    nextQuestionHandler: ({ commit, getters }, { newQuestion, newAnswers }) => {
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceAnswerAtIndex', {
        newAnswers,
        index: getters.getIAnswers,
      });
      if (getters.isAtLastQuestion) {
        commit('addQuestionAtIndex', {
          newQuestion: new EmptyQuestion(),
          index: getters.getIQuestions + 1,
        });
        commit('addAnswerAtIndex', {
          newAnswers: [new EmptyAnswer()],
          index: getters.getIQuestions + 1,
        });
      }
      commit('incrementIQuestions');
    },
    priorQuestionHandler: ({ commit, getters }, { newQuestion, newAnswers }) => {
      if (getters.isAtFirstQuestion) return;
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceAnswerAtIndex', {
        newAnswers,
        index: getters.getIQuestions,
      });
      commit('decrementIQuestions');
    },
    discardQuestionHandler: ({ commit, getters }) => {
      if (getters.isAtLastQuestion) {
        commit('replaceQuestionAtIndex', {
          newQuestion: new EmptyQuestion(),
          index: getters.getIQuestions,
        });
        commit('replaceAnswerAtIndex', {
          newAnswers: [new EmptyAnswer()],
          index: getters.getIQuestions,
        });
        return;
      }
      commit('deleteQuestionAtIndex', { index: getters.getIQuestions });
      commit('deleteAnswerAtIndex', { index: getters.getIQuestions });
    },
    saveQuestionHandler: ({ commit, getters }, { newQuestion, newAnswers }) => {
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceAnswerAtIndex', {
        newAnswers,
        index: getters.getIQuestions,
      });
      if (getters.isAtLastQuestion) {
        commit('addQuestionAtIndex', {
          newQuestion: new EmptyQuestion(),
          index: getters.getIQuestions + 1,
        });
        commit('addAnswerAtIndex', {
          newAnswers: [new EmptyAnswer()],
          index: getters.getIQuestions + 1,
        });
        commit('incrementIQuestions');
      }
    },
  },
};

export default QUESTION_UI;
