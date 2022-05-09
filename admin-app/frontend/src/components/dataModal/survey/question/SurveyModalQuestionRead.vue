<template>
  <v-card class="px-0 pt-0 px-md-4 pt-md-4">
    <v-form lazy-validation>
      <v-card-title class="flex-column flex-sm-row">
        <h2 v-if="surveyInFocus">
          {{
            calculateUILocaleString({
              languageTexts: surveyInFocus.name.languageTexts,
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
            @click="decrementCompletionIndex"
          >
            <v-icon large class="ml-0 ml-sm-2"> mdi-chevron-left </v-icon>
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('surveys.modal.questionCard.backToDetails')
            }}
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
              <h3>
                {{
                  calculateUILocaleString({
                    languageTexts: questionTextInFocus.languageTexts,
                  })
                }}
              </h3>

              <h3 class="mt-4">
                {{ $t('surveys.modal.questionCard.form.question.imageTitle') }}
              </h3>
              <div v-if="surveyInFocus">
                <ImgFromS3 :assumedSrc="deriveImgPath" dataType="survey">
                  <template v-slot:v-img="slotProps">
                    <v-img max-height="200px" :src="slotProps.src"> </v-img>
                  </template>
                </ImgFromS3>
              </div>

              <h3 class="mt-4">
                {{ $t('surveys.modal.questionCard.form.question.audioTitle') }}
              </h3>
              <div v-if="surveyInFocus">
                <AudioFromS3 :assumedSrc="deriveAudioPath" />
              </div>
            </v-col>

            <v-col cols="12" sm="6" class="pt-4 px-0 px-sm-3 pt-sm-0">
              <h2 class="mb-2">
                <span>
                  {{ $t('surveys.modal.questionCard.form.answer.title') }}
                </span>
                <span v-if="surveyInFocus">
                  ({{
                    $t(
                      `surveys.modal.questionCard.form.answer.questionTypes.${surveyInFocus.questions[iQuestions].type}`
                    )
                  }})
                </span>
              </h2>
              <v-divider class="mb-4"></v-divider>

              <div v-if="surveyInFocus">
                <div>
                  <v-list dense disabled>
                    <v-list-item-group color="primary">
                      <v-list-item
                        v-for="option in surveyInFocus.questions[iQuestions].questionOptions"
                        :key="option.id"
                      >
                        <v-list-item-icon>
                          <v-icon
                            v-text="questionTypesIconDict[surveyInFocus.questions[iQuestions].type]"
                          ></v-icon>
                        </v-list-item-icon>
                        <v-list-item-content>
                          <v-list-item-title
                            v-text="
                              calculateUILocaleString({
                                languageTexts: option.text.languageTexts,
                              })
                            "
                          ></v-list-item-title>
                        </v-list-item-content>
                      </v-list-item>
                    </v-list-item-group>
                  </v-list>
                </div>
              </div>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-btn color="warning" text @click="abortReadData">
          {{ $t('general.close') }}
        </v-btn>
        <v-spacer></v-spacer>
        <div class="d-flex" v-if="$vuetify.breakpoint.name !== 'xs'">
          <v-btn x-large text class="text-none" @click="priorQuestion" :disabled="cantAdvanceBack">
            <v-icon large> mdi-skip-previous </v-icon>
            {{
              $vuetify.breakpoint.name === 'xs'
                ? ''
                : $t('surveys.modal.questionCard.priorQuestion')
            }}
          </v-btn>
          <v-btn x-large text class="text-none" @click="nextQuestion" :disabled="cantAdvance">
            {{
              $vuetify.breakpoint.name === 'xs' ? '' : $t('surveys.modal.questionCard.nextQuestion')
            }}
            <v-icon large> mdi-skip-next </v-icon>
          </v-btn>
        </div>
        <v-spacer></v-spacer>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';

import { questionTypesIconDict } from '../../../../lib/constants';
// eslint-disable-next-line import/named
import { deriveFilePath } from '../../../../lib/utils';

import ImgFromS3 from '../../../commons/ImgFromS3.vue';
import AudioFromS3 from '../../../commons/AudioFromS3.vue';

export default {
  name: 'SurveyModalQuestionRead',
  components: {
    ImgFromS3,
    AudioFromS3,
  },
  data() {
    return {
      questionTypesIconDict,
    };
  },
  computed: {
    ...mapGetters({
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      SURVEYById: 'SURVEY_Data/SURVEYById',
      surveyModalMode: 'dataModal/getMode',
      iQuestions: 'QUESTION_UI/getIQuestions',
      questionTextInFocus: 'QUESTION_UI/questionTextInFocus',

      calculateUILocaleString: 'calculateUILocaleString',
      fallbackLocaleIndex: 'fallbackLocaleIndex',
    }),
    nQuestions() {
      return this.surveyInFocus.questions.length;
    },
    surveyInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
    },
    cantAdvanceBack() {
      return this.iQuestions === 0;
    },
    cantAdvance() {
      return this.iQuestions === this.nQuestions - 1;
    },
    deriveImgPath() {
      return deriveFilePath('questionPicPath', {
        interventionID: this.surveyInFocus.intervention.id,
        surveyID: this.dataIdInFocus,
        questionID: this.surveyInFocus.questions[this.iQuestions].id,
      });
    },
    deriveAudioPath() {
      return deriveFilePath('questionAudioPath', {
        interventionID: this.surveyInFocus.intervention.id,
        surveyID: this.dataIdInFocus,
        questionID: this.surveyInFocus.questions[this.iQuestions].id,
      });
    },
  },
  async mounted() {
    if (this.iQuestions >= this.nQuestions) this.setIQuestions({ payload: 0 });

    // const questionAudio = await Storage.get(this.deriveAudioPath, { download: true });
    // this.audioURL = URL.createObjectURL(questionAudio.Body);
  },
  methods: {
    ...mapActions({
      nextQuestionHandler: 'QUESTION_UI/nextQuestionHandler',
      priorQuestionHandler: 'QUESTION_UI/priorQuestionHandler',
      discardQuestionHandler: 'QUESTION_UI/discardQuestionHandler',
      saveQuestionHandler: 'QUESTION_UI/saveQuestionHandler',

      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
      abortReadData: 'dataModal/abortReadData',
    }),
    ...mapMutations({
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
      decrementCompletionIndex: 'decrementSurveyModalCompletionIndex',
      setIQuestions: 'QUESTION_UI/setIQuestions',
      incrementIQuestions: 'QUESTION_UI/incrementIQuestions',
      decrementIQuestions: 'QUESTION_UI/decrementIQuestions',
    }),
    nextQuestion() {
      this.incrementIQuestions();
    },
    priorQuestion() {
      this.decrementIQuestions();
    },
    questionUpdatedHandler(res) {
      this.text = res;
    },
  },
};
</script>
