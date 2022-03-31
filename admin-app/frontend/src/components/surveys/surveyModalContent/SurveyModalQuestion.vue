<template>
  <v-card class="px-0 pt-0 px-md-4 pt-md-4">
    <v-form lazy-validation>
      <v-card-title class="flex-column flex-sm-row">
        <h2 v-if="read">
          {{ surveyNameInFocus }}
        </h2>
        <h2 v-else>
          {{ surveyDraft.name }}
        </h2>
        <v-spacer v-if="$vuetify.breakpoint.name !== 'xs'"></v-spacer>
        <div class="d-flex">
          <v-btn
            :x-large="$vuetify.breakpoint.name !== 'xs'"
            text
            :fab="$vuetify.breakpoint.name === 'xs'"
            class="text-none"
            @click="backToDetailsHandler"
            :disabled="!canGoBackToDetails"
          >
            <v-icon large class="ml-0 ml-sm-2"> mdi-chevron-left </v-icon>
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('interventions.surveyModal.questionCard.backToDetails')
            }}
          </v-btn>
          <v-btn
            :x-large="$vuetify.breakpoint.name !== 'xs'"
            text
            :fab="$vuetify.breakpoint.name === 'xs'"
            class="text-none"
            @click="finalizeSurveyHandler"
            :disabled="!canFinalize"
          >
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('interventions.surveyModal.questionCard.finalizeSurvey')
            }}
            <v-icon large class="ml-2"> mdi-chevron-right </v-icon>
          </v-btn>
        </div>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" sm="6" class="pb-0 px-0 px-sm-3">
              <h2 class="mb-2">
                {{ $t('interventions.surveyModal.questionCard.form.question.title') }}
              </h2>
              <h3 v-if="read">
                {{ questionTextInFocus }}
              </h3>
              <v-textarea
                v-else
                autofocus
                v-model="questionText"
                :rules="[rules.maxChar]"
                :label="$t('interventions.surveyModal.questionCard.form.question.textLabel')"
                outlined
                dense
              ></v-textarea>

              <h3>
                {{ $t('interventions.surveyModal.questionCard.form.question.imageTitle') }}
              </h3>
              <div class="d-flex justify-center">
                <v-btn
                  v-if="edit || create"
                  color="primary"
                  rounded
                  x-large
                  @click="clickOnAddImage"
                  class="mt-4"
                >
                  <v-icon class="mr-2"> mdi-image </v-icon>
                  <span class="overflow-hidden">
                    {{ $t('interventions.surveyModal.questionCard.form.question.addImage') }}
                  </span>
                </v-btn>
                <input
                  v-if="edit || create"
                  type="file"
                  accept="image/png, image/jpeg"
                  ref="question-img-upload"
                  style="display: none"
                />
              </div>

              <h3 class="mt-8">
                {{ $t('interventions.surveyModal.questionCard.form.question.audioTitle') }}
              </h3>
              <div class="d-flex justify-center">
                <v-btn
                  v-if="edit || create"
                  color="primary"
                  rounded
                  x-large
                  @click="clickOnAddAudio"
                  class="mt-4"
                >
                  <v-icon class="mr-2"> mdi-waveform </v-icon>
                  <span class="overflow-hidden">
                    {{ $t('interventions.surveyModal.questionCard.form.question.addAudio') }}
                  </span>
                </v-btn>
                <input
                  v-if="edit || create"
                  type="file"
                  accept="image/png, image/jpeg"
                  ref="question-audio-upload"
                  style="display: none"
                />
              </div>
            </v-col>

            <v-col cols="12" sm="6" class="pt-4 px-0 px-sm-3 pt-sm-0">
              <h2 class="mb-2">
                {{ $t('interventions.surveyModal.questionCard.form.answer.title') }}
              </h2>
              <v-select
                v-if="edit || create"
                v-model="questionType"
                :items="questionTypesItemValue"
                :label="$t('interventions.surveyModal.questionCard.form.answer.typeLabel')"
                outlined
                dense
              ></v-select>

              <v-divider class="mb-4"></v-divider>

              <div v-if="areAnswersNeeded">
                <div v-for="(answer, index) in answers" :key="index">
                  <h3>
                    {{ $t('interventions.surveyModal.questionCard.form.answer.answer') }}
                    {{ index + 1 }}
                  </h3>
                  <div class="d-flex justify-space-between">
                    <v-text-field
                      v-model="answers[index].answerText"
                      :label="$t('interventions.surveyModal.questionCard.form.answer.textLabel')"
                      outlined
                      dense
                      :hide-details="true"
                      class="mb-2"
                    ></v-text-field>

                    <div class="d-flex">
                      <v-btn
                        v-if="edit || create"
                        color="primary"
                        rounded
                        outlined
                        @click="clickOnAddImgToAnswer"
                        class="ml-2"
                      >
                        <v-icon class="mr-2"> mdi-image </v-icon>
                        <span class="overflow-hidden">
                          {{ $t('interventions.surveyModal.questionCard.form.answer.addImage') }}
                        </span>
                      </v-btn>
                      <input
                        v-if="edit || create"
                        type="file"
                        accept="image/png, image/jpeg"
                        :ref="`answer-img-upload`"
                        style="display: none"
                      />
                      <v-btn
                        v-if="edit || create"
                        color="primary"
                        outlined
                        icon
                        @click="clickOnRemoveAnswer(index)"
                        class="ml-2"
                      >
                        <v-icon> mdi-minus </v-icon>
                      </v-btn>
                    </div>
                  </div>
                </div>

                <div class="d-flex justify-center" v-if="maxNOptionsAchieved">
                  <v-btn
                    v-if="edit || create"
                    color="primary"
                    rounded
                    x-large
                    class="mt-2"
                    @click="clickOnAddAnswer"
                  >
                    <v-icon class="mr-2"> mdi-plus </v-icon>
                    <span class="overflow-hidden">
                      {{ $t('interventions.surveyModal.questionCard.form.answer.addAnswer') }}
                    </span>
                  </v-btn>
                  <input
                    v-if="edit || create"
                    type="file"
                    accept="audio/*"
                    ref="question-audio-upload"
                    style="display: none"
                  />
                </div>
              </div>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-btn x-large text color="warning" class="text-none" @click="discardQuestionHandler">
          {{
            $vuetify.breakpoint.name === 'xs'
              ? ''
              : $t('interventions.surveyModal.questionCard.discardQuestion')
          }}
          <v-icon large> mdi-delete </v-icon>
        </v-btn>
        <v-spacer v-if="!isAtLastQuestion"></v-spacer>
        <div class="d-flex" v-if="$vuetify.breakpoint.name !== 'xs'">
          <v-btn
            x-large
            text
            class="text-none"
            @click="priorQuestion"
            :disabled="!canAdvanceBack"
            v-if="!isAtLastQuestion"
          >
            <v-icon large> mdi-skip-previous </v-icon>
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('interventions.surveyModal.questionCard.priorQuestion')
            }}
          </v-btn>
          <v-btn
            x-large
            text
            class="text-none"
            @click="nextQuestion"
            :disabled="!canAdvance"
            v-if="!isAtLastQuestion"
          >
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('interventions.surveyModal.questionCard.nextQuestion')
            }}
            <v-icon large> mdi-skip-next </v-icon>
          </v-btn>
        </div>

        <v-spacer></v-spacer>
        <v-btn x-large text class="text-none" @click="saveQuestion" :disabled="!canSave">
          {{
            $vuetify.breakpoint.name === 'xs'
              ? ''
              : $t('interventions.surveyModal.questionCard.saveDraft')
          }}
          <v-icon large class="ml-2"> mdi-content-save-outline </v-icon>
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
import { modalModesDict, questionTypesDict } from '../../../store/constants';
import { EmptyQuestion, EmptyAnswer, Answer } from '../../../store/questions/utils';

const questionTextMaxChar = Math.max(parseInt(process.env.VUE_APP_QUESTION_TEXT_MAX_CHAR, 10), 0);
const maxNAnswers = Math.min(Number(process.env.VUE_APP_MAX_N_QUESTION_OPTIONS), 0);

export default {
  name: 'SurveyModalQuestion',
  watch: {
    questionCurrentDraft: 'updateComponentData',
  },
  data() {
    return {
      rules: {
        maxChar: (value) => value.length <= questionTextMaxChar || this.maxCharExceededi18n,
      },
      questionText: new EmptyQuestion().questionText,
      questionType: new EmptyQuestion().questionType,
      answers: [new EmptyAnswer()],
    };
  },
  beforeRouteLeave(to, from, next) {
    // If the form is dirty and the user did not confirm leave,
    // prevent losing unsaved changes by canceling navigation
    if (this.confirmStayInDirtyForm()) {
      next(false);
    } else {
      // Navigate to next view
      next();
    }
  },
  created() {
    window.addEventListener('beforeunload', this.beforeWindowUnload);
  },
  beforeDestroy() {
    window.removeEventListener('beforeunload', this.beforeWindowUnload);
  },
  computed: {
    ...mapGetters({
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      SURVEYById: 'SURVEY_Data/SURVEYById',
      surveyModalMode: 'dataModal/getMode',
      questionCurrentDraft: 'QUESTION_UI/questionCurrentDraft',
      answersCurrentDraft: 'QUESTION_UI/answersCurrentDraft',
      nQuestions: 'QUESTION_UI/nQuestions',
      iQuestions: 'QUESTION_UI/getIQuestions',
      isAtLastQuestion: 'QUESTION_UI/isAtLastQuestion',
      isAtFirstQuestion: 'QUESTION_UI/isAtFirstQuestion',
      surveyDraft: 'dataModal/getDataDraft',
      questionTextInFocus: 'QUESTION_UI/questionTextInFocus',
    }),
    surveyNameInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
    },
    questionTypesItemValue() {
      return Object.keys(questionTypesDict).map((key) => ({
        text: this.$t(`interventions.surveyModal.questionCard.form.answer.questionTypes.${key}`),
        value: key,
      }));
    },
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: questionTextMaxChar,
      });
    },
    areThereChanges() {
      if (this.questionText !== this.questionCurrentDraft.questionText) return true;
      if (this.questionType !== this.questionCurrentDraft.questionType) return true;
      if (this.areAnswersNeeded) {
        if (this.answers.length !== this.answersCurrentDraft.length) return true;
        if (
          this.answers.filter((a, i) => a.answerText !== this.answersCurrentDraft[i].answerText)
            .length > 0
        ) return true;
      }
      return false;
    },
    edit() {
      return this.surveyModalMode === modalModesDict.edit;
    },
    create() {
      return this.surveyModalMode === modalModesDict.create;
    },
    read() {
      return this.surveyModalMode === modalModesDict.read;
    },
    canAdvanceBack() {
      return !this.isAtFirstQuestion && !this.areThereChanges;
    },
    canAdvance() {
      return this.iQuestions < this.nQuestions - 2 && !this.areThereChanges;
    },
    canSave() {
      if (this.read) return false;
      return (
        (!this.areAnswersNeeded
          || (this.answers.length > 0 && !this.answers.find((a) => a.answerText === '')))
        && (!(this.questionCurrentDraft.isEmptyQuestion ?? true) || this.areThereChanges)
      );
    },
    canFinalize() {
      return this.nQuestions > 1 && !this.areThereChanges;
    },
    canGoBackToDetails() {
      return this.read || !this.areThereChanges;
    },
    areAnswersNeeded() {
    maxNOptionsAchieved() {
      return this.options.length >= maxNAnswers;
    },
  },
  methods: {
    ...mapActions({
      nextQuestionHandler: 'QUESTION_UI/nextQuestionHandler',
      priorQuestionHandler: 'QUESTION_UI/priorQuestionHandler',
      discardQuestionHandler: 'QUESTION_UI/discardQuestionHandler',
      saveQuestionHandler: 'QUESTION_UI/saveQuestionHandler',

      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
    }),
    ...mapMutations({
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
      decrementCompletionIndex: 'decrementSurveyModalCompletionIndex',
    }),
    confirmLeave() {
      // eslint-disable-next-line
      return window.confirm(this.$t('general.form.unsavedChanges'));
    },
    confirmStayInDirtyForm() {
      return this.areThereChanges && !this.confirmLeave();
    },
    beforeWindowUnload(e) {
      if (this.confirmStayInDirtyForm()) {
        // Cancel the event
        e.preventDefault();
        // Chrome requires returnValue to be set
        e.returnValue = '';
      }
    },
    finalizeSurveyHandler() {
      this.incrementCompletionIndex();
    },
    backToDetailsHandler() {
      this.decrementCompletionIndex();
    },
    updateComponentData() {
      const q = this.questionCurrentDraft;
      const { answersCurrentDraft } = this;

      this.questionText = q.questionText;
      this.questionType = q.questionType;
      this.answers = [new EmptyAnswer()];
      if (answersCurrentDraft[0].isEmptyAnswer) return;

      for (let index = 0; index < answersCurrentDraft.length; index += 1) {
        const newAnswer = new Answer({ answerText: answersCurrentDraft[index].answerText });
        this.answers.splice(index, 1, newAnswer);
      }
    },
    saveQuestion() {
      this.saveQuestionHandler({
        newQuestion: {
          questionText: this.questionText,
          questionType: this.questionType,
        },
        // TODO: See whether reactivity breaks when direct reference is used
        // instead of generating a new array instance as follows
        newAnswers: [...this.answers.map((a) => ({ answerText: a.answerText }))],
      });
    },
    clickOnAddImage() {
      const imgInput = this.$refs['question-img-upload'];
      if (Array.isArray(imgInput)) imgInput[0].click();
      else imgInput.click();
      this.showToBeImplementedFeedback();
      // console.log('TODO: do something with', imgInput);
    },
    clickOnAddAudio() {
      const audioInput = this.$refs['question-audio-upload'];
      if (Array.isArray(audioInput)) audioInput[0].click();
      else audioInput.click();
      this.showToBeImplementedFeedback();
      // console.log('TODO: do something with', audioInput);
    },
    clickOnAddAnswer() {
      this.answers.push({ answerText: '' });
    },
    clickOnAddImgToAnswer() {
      const imgInput = this.$refs['answer-img-upload'];
      if (Array.isArray(imgInput)) imgInput[0].click();
      else imgInput.click();
      this.showToBeImplementedFeedback();
      // console.log('TODO: handle adding image to answer');
    },
    clickOnRemoveAnswer(index) {
      this.answers.splice(index, 1);
    },
    nextQuestion() {
      this.nextQuestionHandler({
        newQuestion: {
          questionText: this.questionText,
          questionType: this.questionType,
        },
        // TODO: See whether reactivity breaks when direct reference is used
        // instead of generating a new array instance as follows
        newAnswers: [...this.answers.map((a) => ({ answerText: a.answerText }))],
      });
    },
    priorQuestion() {
      this.priorQuestionHandler({
        newQuestion: {
          questionText: this.questionText,
          questionType: this.questionType,
        },
        // TODO: See whether reactivity breaks when direct reference is used
        // instead of generating a new array instance as follows
        newAnswers: [...this.answers.map((a) => ({ answerText: a.answerText }))],
      });
    },
  },
};
</script>
