<template>
  <v-card class="px-0 pt-0 px-md-4 pt-md-4">
    <v-form lazy-validation>
      <v-card-title class="flex-column flex-sm-row">
        <h2>
          {{
            calculateUILocaleString({
              languageTexts: surveyDraft.name.languageTexts,
            })
          }}
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
                : $t('surveys.modal.questionCard.backToDetails')
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
                : $t('surveys.modal.questionCard.finalizeSurvey')
            }}
            <v-icon large class="ml-2"> mdi-chevron-right </v-icon>
          </v-btn>
        </div>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" sm="6" class="py-0 px-0 px-sm-3">
              <h2 class="mb-2">
                {{ $t('surveys.modal.questionCard.form.question.title') }}
              </h2>
              <LocaleTextBox
                labelPrefixI18nSelector="surveys.modal.questionCard.form.question.textLabel"
                :initVal="text"
                @res="questionUpdatedHandler"
                :key="questionTextBoxKey"
              >
                <template v-slot:text-input="slotProps">
                  <v-textarea
                    autofocus
                    required
                    outlined
                    dense
                    :label="slotProps.label"
                    v-model="slotProps.model"
                    @input="slotProps.inputHandler"
                  ></v-textarea>
                </template>
              </LocaleTextBox>

              <h3 class="mt-4">
                {{ $t('surveys.modal.questionCard.form.question.imageTitle') }}
              </h3>
              <div class="d-flex justify-center">
                <v-btn color="primary" rounded x-large @click="selectQuestionImg" class="mt-4">
                  <v-icon class="mr-2"> mdi-image </v-icon>
                  <span class="overflow-hidden">
                    {{ edit ? $t('general.editImage') : $t('general.addImage') }}
                  </span>
                </v-btn>
                <FileInput
                  ref="question-img-upload"
                  style="display: none"
                  :acceptedType="'image/png'"
                  :isForQuestions="true"
                />
              </div>

              <h3 class="mt-8">
                {{ $t('surveys.modal.questionCard.form.question.audioTitle') }}
              </h3>
              <div class="d-flex justify-center">
                <v-btn color="primary" rounded x-large @click="clickOnAddAudio" class="mt-4">
                  <v-icon class="mr-2"> mdi-waveform </v-icon>
                  <span class="overflow-hidden">
                    {{ $t('surveys.modal.questionCard.form.question.addAudio') }}
                  </span>
                </v-btn>
                <input
                  type="file"
                  accept="image/png, image/jpeg"
                  ref="question-audio-upload"
                  style="display: none"
                />
              </div>
            </v-col>

            <v-col cols="12" sm="6" class="pt-4 px-0 px-sm-3 pt-sm-0">
              <h2 class="mb-2">
                <span>
                  {{ $t('surveys.modal.questionCard.form.answer.title') }}
                </span>
              </h2>
              <v-select
                v-model="type"
                :items="questionTypesItemValue"
                :label="$t('surveys.modal.questionCard.form.answer.typeLabel')"
                outlined
                dense
              ></v-select>

              <v-divider class="mb-4"></v-divider>

              <div v-if="areAnswersNeeded">
                <div>
                  <div v-for="(option, index) in options" :key="index">
                    <h3>
                      {{ $t('surveys.modal.questionCard.form.answer.answer') }}
                      {{ index + 1 }}
                    </h3>
                    <div class="d-flex justify-space-between">
                      <v-text-field
                        v-model="options[index].text.languageTexts[fallbackLocaleIndex]"
                        :label="$t('surveys.modal.questionCard.form.answer.textLabel')"
                        outlined
                        dense
                        :hide-details="true"
                        class="mb-2"
                      ></v-text-field>

                      <div class="d-flex">
                        <v-btn
                          color="primary"
                          rounded
                          outlined
                          @click="clickOnAddImgToOption"
                          class="ml-2"
                        >
                          <v-icon class="mr-2"> mdi-image </v-icon>
                          <span class="overflow-hidden">
                            {{ $t('surveys.modal.questionCard.form.answer.addImage') }}
                          </span>
                        </v-btn>
                        <input
                          type="file"
                          accept="image/png, image/jpeg"
                          :ref="`option-img-upload`"
                          style="display: none"
                        />
                        <v-btn
                          v-if="options.length > 2"
                          color="primary"
                          outlined
                          icon
                          @click="clickOnRemoveOption(index)"
                          class="ml-2"
                        >
                          <v-icon> mdi-minus </v-icon>
                        </v-btn>
                      </div>
                    </div>
                  </div>

                  <div class="d-flex justify-center" v-if="maxNOptionsAchieved">
                    <v-btn color="primary" rounded x-large class="mt-2" @click="clickOnAddOption">
                      <v-icon class="mr-2"> mdi-plus </v-icon>
                      <span class="overflow-hidden">
                        {{ $t('surveys.modal.questionCard.form.answer.addAnswer') }}
                      </span>
                    </v-btn>
                    <input
                      type="file"
                      accept="audio/*"
                      ref="question-audio-upload"
                      style="display: none"
                    />
                  </div>
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
              : $t('surveys.modal.questionCard.discardQuestion')
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
                : $t('surveys.modal.questionCard.priorQuestion')
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
              $vuetify.breakpoint.name === 'xs' ? '' : $t('surveys.modal.questionCard.nextQuestion')
            }}
            <v-icon large> mdi-skip-next </v-icon>
          </v-btn>
        </div>

        <v-spacer></v-spacer>
        <v-btn x-large text class="text-none" @click="saveQuestion" :disabled="!canSave">
          {{ $vuetify.breakpoint.name === 'xs' ? '' : $t('surveys.modal.questionCard.saveDraft') }}
          <v-icon large class="ml-2"> mdi-content-save-outline </v-icon>
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
import { v4 as uuidv4 } from 'uuid';
import { Question, QuestionType } from '../../../../models';
import {
  emptyMutableI18nString,
  emptyMutableQuestionOption,
  mutableI18nString,
  mutableQuestionOption,
} from '../../../../lib/classes';
import { modalModesDict, questionTypesIconDict, vuexModulesDict } from '../../../../lib/constants';
// eslint-disable-next-line import/named
import { compareI18nStrings, deriveFilePath } from '../../../../lib/utils';

import LocaleTextBox from '../../../commons/form/LocaleTextBox.vue';
import FileInput from '../../../commons/form/FileInput.vue';

const maxNOptions = Math.min(Number(process.env.VUE_APP_MAX_N_QUESTION_OPTIONS), 0);

export default {
  name: 'SurveyModalQuestion',
  components: {
    LocaleTextBox,
    FileInput,
  },
  watch: {
    questionCurrentDraft: 'updateComponentData',
  },
  data() {
    return {
      text: emptyMutableI18nString(),
      type: QuestionType.TEXT,
      options: [emptyMutableQuestionOption()],
      questionTextBoxKey: false,
      questionTypesIconDict,
    };
  },
  beforeRouteLeave(to, from, next) {
    // If the form is dirty and the user did not confirm leave,
    // prevent losing unsaved changes by canceling navigation
    if (this.confirmStayInDirtyForm() || this.nQuestions > 1) {
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
      dataIdInFocus: `${vuexModulesDict.dataModal}/getDataIdInFocus`,
      SURVEYById: `${vuexModulesDict.survey}/SURVEYById`,
      surveyModalMode: `${vuexModulesDict.dataModal}/getMode`,
      questionCurrentDraft: `${vuexModulesDict.question}/questionCurrentDraft`,
      optionsCurrentDraft: `${vuexModulesDict.question}/optionsCurrentDraft`,
      nQuestions: `${vuexModulesDict.question}/nQuestions`,
      iQuestions: `${vuexModulesDict.question}/getIQuestions`,
      isAtLastQuestion: `${vuexModulesDict.question}/isAtLastQuestion`,
      isAtFirstQuestion: `${vuexModulesDict.question}/isAtFirstQuestion`,
      surveyDraft: `${vuexModulesDict.dataModal}/getDataDraft`,
      questionTextInFocus: `${vuexModulesDict.question}/questionTextInFocus`,

      calculateUILocaleString: 'calculateUILocaleString',
      fallbackLocaleIndex: 'fallbackLocaleIndex',
    }),
    surveyInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
    },
    questionTypesItemValue() {
      return Object.keys(QuestionType)
        .map((key) => ({
          text: this.$t(`surveys.modal.questionCard.form.answer.questionTypes.${key}`),
          value: key,
        }))
        .filter((t) => t.value !== QuestionType.PICTUREWITHTAGS);
    },
    areThereChanges() {
      if (!compareI18nStrings(this.text, this.questionCurrentDraft.text)) return true;
      if (this.type !== this.questionCurrentDraft.type) return true;
      if (this.areAnswersNeeded) {
        if (this.options.length !== this.optionsCurrentDraft.length) return true;
        if (
          this.options.filter(
            (a, i) => !compareI18nStrings(a.text, this.optionsCurrentDraft[i].text),
          ).length > 0
        ) return true;
      }
      return false;
    },
    edit() {
      return this.surveyModalMode === modalModesDict.edit;
    },
    canAdvanceBack() {
      return !this.isAtFirstQuestion && !this.areThereChanges;
    },
    canAdvance() {
      return !this.isAtLastQuestion;
    },
    canSave() {
      return (
        (!this.areAnswersNeeded
          || (this.options.length > 0
            && !this.options.find((a) => a.text[this.fallbackLocaleIndex] === '')))
        && (!(this.questionCurrentDraft.isEmptyQuestion ?? true) || this.areThereChanges)
      );
    },
    canFinalize() {
      return this.nQuestions > 1 && !this.areThereChanges;
    },
    canGoBackToDetails() {
      return !this.areThereChanges;
    },
    areAnswersNeeded() {
      return [QuestionType.SINGLECHOICE, QuestionType.MULTIPLECHOICE].includes(this.type);
    },
    maxNOptionsAchieved() {
      return this.options.length >= maxNOptions;
    },
    deriveImgPath() {
      return deriveFilePath('questionPicPath', {
        interventionID: this.surveyInFocus.intervention.id,
        surveyID: this.dataIdInFocus,
        questionID: this.surveyInFocus.questions[this.iQuestions].id,
      });
    },
  },
  methods: {
    ...mapActions({
      nextQuestionHandler: `${vuexModulesDict.question}/nextQuestionHandler`,
      priorQuestionHandler: `${vuexModulesDict.question}/priorQuestionHandler`,
      discardQuestionHandler: `${vuexModulesDict.question}/discardQuestionHandler`,
      saveQuestionHandler: `${vuexModulesDict.question}/saveQuestionHandler`,

      showToBeImplementedFeedback: `${vuexModulesDict.feedback}/showToBeImplementedFeedback`,
      abortReadSurveyHandler: `${vuexModulesDict.dataModal}/abortReadData`,
    }),
    ...mapMutations({
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
      decrementCompletionIndex: 'decrementSurveyModalCompletionIndex',
      setIQuestions: `${vuexModulesDict.question}/setIQuestions`,
    }),
    confirmLeave() {
      // eslint-disable-next-line
      return window.confirm(this.$t('general.form.unsavedChanges'));
    },
    confirmStayInDirtyForm() {
      return this.areThereChanges && !this.confirmLeave();
    },
    beforeWindowUnload(e) {
      if (this.confirmStayInDirtyForm() || this.nQuestions > 1) {
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
      const { optionsCurrentDraft } = this;

      this.text = mutableI18nString({
        languageTexts: Array.from(q.text.languageTexts),
      });
      this.type = q.type;

      this.options = [emptyMutableQuestionOption()];
      for (let index = 0; index < optionsCurrentDraft.length; index += 1) {
        const newOption = mutableQuestionOption({
          text: optionsCurrentDraft[index].text,
        });
        this.options.splice(index, 1, newOption);
      }

      // Remounts the LocaleTextBox component
      this.questionTextBoxKey = !this.questionTextBoxKey;
    },
    saveQuestion() {
      this.saveQuestionHandler({
        newQuestion: new Question({
          id: uuidv4(),
          text: this.text,
          type: this.type,
          isFollowUpQuestion: false,
          questionOptions: [],
        }),
        // TODO: See whether reactivity breaks when direct reference is used
        // instead of generating a new array instance as follows
        newOptions: [QuestionType.SINGLECHOICE, QuestionType.MULTIPLECHOICE].includes(this.type)
          ? this.options
          : [],
      });
      this.type = QuestionType.TEXT;
      this.text = emptyMutableI18nString();
    },
    selectQuestionImg() {
      const imgInput = this.$refs['question-img-upload'];
      imgInput.$el.click();
    },
    clickOnAddAudio() {
      const audioInput = this.$refs['question-audio-upload'];
      if (Array.isArray(audioInput)) audioInput[0].click();
      else audioInput.click();
      this.showToBeImplementedFeedback();
      // console.log('TODO: do something with', audioInput);
    },
    clickOnAddOption() {
      this.options.push(emptyMutableQuestionOption());
    },
    clickOnAddImgToOption() {
      const imgInput = this.$refs['option-img-upload'];
      if (Array.isArray(imgInput)) imgInput[0].click();
      else imgInput.click();
      this.showToBeImplementedFeedback();
      // console.log('TODO: handle adding image to option');
    },
    clickOnRemoveOption(index) {
      this.options.splice(index, 1);
    },
    nextQuestion() {
      this.nextQuestionHandler({
        newQuestion: new Question({
          id: uuidv4(),
          text: this.text,
          type: this.type,
          isFollowUpQuestion: false,
          questionOptions: [],
        }),
        newOptions: [QuestionType.SINGLECHOICE, QuestionType.MULTIPLECHOICE].includes(this.type)
          ? this.options
          : [],
      });
    },
    priorQuestion() {
      this.priorQuestionHandler({
        newQuestion: new Question({
          id: uuidv4(),
          text: this.text,
          type: this.type,
          isFollowUpQuestion: false,
          questionOptions: [],
        }),
        newOptions: [QuestionType.SINGLECHOICE, QuestionType.MULTIPLECHOICE].includes(this.type)
          ? this.options
          : [],
      });
    },
    questionUpdatedHandler(res) {
      this.text = res;
    },
  },
};
</script>
