import { emptyQuestionOption, emptyQuestion, emptyI18nString } from '../../lib/classes';
import { vuexModulesDict } from '../../lib/constants';

const QUESTION_UI = {
  namespaced: true,
  state: () => ({
    iQuestions: 0,
    questionDrafts: [emptyQuestion()],
    optionDrafts: [[emptyQuestionOption()]],
    questionImages: [],
    questionAudios: [],
  }),
  getters: {
    /* READ */
    getIQuestions: ({ iQuestions }) => iQuestions ?? 0,
    getQuestionDrafts: ({ questionDrafts }) => questionDrafts || [emptyQuestion()],
    getOptionDrafts: ({ optionDrafts }) => optionDrafts || [[emptyQuestionOption()]],
    getQuestionImages: ({ questionImages }) => questionImages,
    getQuestionAudios: ({ questionAudios }) => questionAudios,

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
    questionTextInFocus: (state, { getIQuestions }, rootState, rootGetters) => rootGetters[`${vuexModulesDict.survey}/SURVEYById`]({
      id: rootGetters[`${vuexModulesDict.dataModal}/getDataIdInFocus`],
    })?.questions[getIQuestions].text ?? emptyI18nString(),
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
    setQuestionAudios: (state, { payload }) => {
      state.questionAudios = payload;
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
    addQuestionImageAtIndex: (state, { newFile, index }) => {
      state.questionImages.splice(index, 0, newFile);
    },
    replaceQuestionImageAtIndex: (state, { newFile, index }) => {
      state.questionImages.splice(index, 1, newFile);
    },
    deleteQuestionImageAtIndex: (state, { index }) => {
      state.questionImages.splice(index, 1);
    },
    pushNullToQuestionImages: (state) => state.questionImages.push(null),

    /* QUESTION AUDIO CREATE, UPDATE, DELETE */
    addQuestionAudioAtIndex: (state, { newFile, index }) => {
      state.questionAudios.splice(index, 0, newFile);
    },
    replaceQuestionAudioAtIndex: (state, { newFile, index }) => {
      state.questionAudios.splice(index, 1, newFile);
    },
    deleteQuestionAudioAtIndex: (state, { index }) => {
      state.questionAudios.splice(index, 1);
    },
    pushNullToQuestionAudios: (state) => state.questionAudios.push(null),
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
    addImageToQuestion: ({ commit, getters }, { newFile }) => {
      console.log({ newFile });
      const currentIndex = getters.getIQuestions;
      if (getters.getQuestionImages[currentIndex] === undefined) {
        while (getters.getQuestionImages.length <= currentIndex) {
          commit('pushNullToQuestionImages');
        }
      }
      commit('replaceQuestionImageAtIndex', { newFile, index: currentIndex });
    },
    addFileToQuestion: ({ commit, getters }, { file, type }) => {
      const currentIndex = getters.getIQuestions;
      const isImage = type === 'image';
      if (getters.getQuestionAudios[currentIndex] === undefined) {
        while (getters.getQuestionAudios.length <= currentIndex) {
          if (isImage) {
            commit('pushNullToQuestionImages');
            continue;
          }
          commit('pushNullToQuestionAudios');
        }
      }
      const mutationName = isImage ? 'addQuestionImageAtIndex' : 'addQuestionAudioAtIndex';
      commit(mutationName, { newFile: file, index: currentIndex });
    },
  },
};

export default QUESTION_UI;
