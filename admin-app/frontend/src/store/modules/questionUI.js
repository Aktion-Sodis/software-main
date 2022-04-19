import { emptyQuestionOption, emptyQuestion, emptyI18nString } from '../../lib/classes';

const QUESTION_UI = {
  namespaced: true,
  state: () => ({
    iQuestions: 0,
    questionDrafts: [emptyQuestion()],
    optionDrafts: [[emptyQuestionOption()]],
    questionImages: [],
  }),
  getters: {
    /* READ */
    getIQuestions: ({ iQuestions }) => iQuestions ?? 0,
    getQuestionDrafts: ({ questionDrafts }) => questionDrafts || [emptyQuestion()],
    getOptionDrafts: ({ optionDrafts }) => optionDrafts || [[emptyQuestionOption()]],
    getQuestionImages: ({ questionImages }) => questionImages,

    questionWithOptionDrafts: (_, { getQuestionDrafts, getOptionDrafts }) => getQuestionDrafts.map((q, i) => ({
      ...q,
      optionDrafts: getOptionDrafts[i],
    })),
    nQuestions: (_, { getQuestionDrafts }) => getQuestionDrafts.length ?? 1,
    isAtFirstQuestion: (_, { getIQuestions }) => getIQuestions === 0,
    isAtLastQuestion: (_, { getIQuestions, nQuestions }) => getIQuestions === nQuestions - 1,
    questionCurrentDraft: (_, { getQuestionDrafts, getIQuestions }) => getQuestionDrafts[getIQuestions],
    optionsCurrentDraft: (_, { getOptionDrafts, getIQuestions }) => getOptionDrafts[getIQuestions],
    currentQuestionWithOptions: (_, { getOptionDrafts, getQuestionDrafts, getIQuestions }) => ({
      ...getQuestionDrafts[getIQuestions],
      optionDrafts: getOptionDrafts[getIQuestions],
    }),
    questionTextInFocus: (state, { getIQuestions }, rootState, rootGetters) => rootGetters['SURVEY_Data/SURVEYById']({ id: rootGetters['dataModal/getDataIdInFocus'] })
      ?.questions[getIQuestions].text ?? emptyI18nString(),
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

    /* BULK UPDATE */
    setQuestions: (state, { payload }) => {
      state.questionDrafts = payload;
    },
    setOptions: (state, { payload }) => {
      state.optionDrafts = payload;
    },
    setQuestionImages: (state, { payload }) => {
      state.questionImages = payload;
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

    /* OPTION CREATE, UPDATE, DELETE */
    addOptionAtIndex: (state, { newOptions, index }) => {
      state.optionDrafts.splice(index, 0, newOptions);
    },
    replaceOptionAtIndex: (state, { newOptions, index }) => {
      state.optionDrafts.splice(index, 1, newOptions);
    },
    deleteOptionAtIndex: (state, { index }) => {
      state.optionDrafts.splice(index, 1);
    },

    /* QUESTION IMAGE CREATE, UPDATE, DELETE */
    addQuestionImageAtIndex: (state, { newQuestionImage, index }) => {
      state.questionImages.splice(index, 0, newQuestionImage);
    },
    replaceQuestionImageAtIndex: (state, { newQuestionImage, index }) => {
      state.questionImages.splice(index, 1, newQuestionImage);
    },
    deleteQuestionImageAtIndex: (state, { index }) => {
      state.questionImages.splice(index, 1);
    },
    pushNullToQuestionImages: (state) => state.questionImages.push(null),
  },
  actions: {
    nextQuestionHandler: ({ commit, getters }, { newQuestion, newOptions }) => {
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceOptionAtIndex', {
        newOptions,
        index: getters.getIQuestions,
      });
      if (getters.isAtLastQuestion) {
        commit('addQuestionAtIndex', {
          newQuestion: emptyQuestion(),
          index: getters.getIQuestions + 1,
        });
        commit('addOptionAtIndex', {
          newOptions: [emptyQuestionOption()],
          index: getters.getIQuestions + 1,
        });
      }
      commit('incrementIQuestions');
    },
    priorQuestionHandler: ({ commit, getters }, { newQuestion, newOptions }) => {
      if (getters.isAtFirstQuestion) return;
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceOptionAtIndex', {
        newOptions,
        index: getters.getIQuestions,
      });
      commit('decrementIQuestions');
    },
    discardQuestionHandler: ({ commit, getters }) => {
      if (getters.isAtLastQuestion) {
        commit('replaceQuestionAtIndex', {
          newQuestion: emptyQuestion(),
          index: getters.getIQuestions,
        });
        commit('replaceOptionAtIndex', {
          newOptions: [emptyQuestionOption()],
          index: getters.getIQuestions,
        });
        return;
      }
      commit('deleteQuestionAtIndex', { index: getters.getIQuestions });
      commit('deleteOptionAtIndex', { index: getters.getIQuestions });
    },
    saveQuestionHandler: ({ commit, getters }, { newQuestion, newOptions }) => {
      commit('replaceQuestionAtIndex', {
        newQuestion,
        index: getters.getIQuestions,
      });
      commit('replaceOptionAtIndex', {
        newOptions,
        index: getters.getIQuestions,
      });
      if (getters.isAtLastQuestion) {
        commit('addQuestionAtIndex', {
          newQuestion: emptyQuestion(),
          index: getters.getIQuestions + 1,
        });
        commit('addOptionAtIndex', {
          newOptions: [emptyQuestionOption()],
          index: getters.getIQuestions + 1,
        });
        commit('incrementIQuestions');
      }
    },
    addImageToQuestion: ({ commit, getters }, { newQuestionImage }) => {
      const currentIndex = getters.getIQuestions;
      if (getters.getQuestionImages[currentIndex] === undefined) {
        while (getters.getQuestionImages.length <= currentIndex) {
          commit('pushNullToQuestionImages');
        }
      }
      commit('replaceQuestionImageAtIndex', { newQuestionImage, index: currentIndex });
    },
  },
};

export default QUESTION_UI;
