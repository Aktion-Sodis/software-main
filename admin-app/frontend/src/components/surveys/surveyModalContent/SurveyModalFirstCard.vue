<template>
  <v-card class="px-0 pt-0 px-md-4 pt-md-4">
    <v-form lazy-validation>
      <v-card-title>
        <h2 v-if="edit">
          {{ $t('surveys.modal.firstCard.title.edit') }}
          <i>
            {{
              calculateUILocaleString({
                languageTexts: surveyInFocus.name.languageTexts,
              })
            }}
          </i>
        </h2>
        <h2 v-else-if="create">
          {{ $t('surveys.modal.firstCard.title.create') }}
        </h2>
        <h2 v-else-if="read">
          {{
            calculateUILocaleString({
              languageTexts: surveyInFocus.name.languageTexts,
            })
          }}
        </h2>
        <v-spacer></v-spacer>
        <v-btn x-large text class="text-none" @click="nextStepHandler" :disabled="!canAdvance">
          {{
            $vuetify.breakpoint.name === 'xs'
              ? ''
              : read
              ? $t('surveys.modal.firstCard.questions')
              : $t(`surveys.modal.firstCard.next-step`)
          }}
          <v-icon large> mdi-chevron-right </v-icon>
        </v-btn>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" sm="6" class="pb-0 px-0 px-md-3">
              <v-card-title class="pt-0 pt-sm-2">
                {{ $t('surveys.modal.firstCard.form.name') }}
              </v-card-title>
              <h2 v-if="read">
                {{
                  calculateUILocaleString({
                    languageTexts: surveyInFocus.name.languageTexts,
                  })
                }}
              </h2>
              <LocaleTextBox
                v-else
                labelPrefixI18nSelector="surveys.modal.firstCard.form.name"
                :initVal="name"
                @res="nameUpdatedHandler"
                :key="nameTextBoxKey"
              >
                <template v-slot:text-input="slotProps">
                  <v-text-field
                    :label="slotProps.label"
                    v-model="slotProps.model"
                    autofocus
                    required
                    outlined
                    dense
                    @input="slotProps.inputHandler"
                  ></v-text-field>
                </template>
              </LocaleTextBox>

              <v-card-title class="pt-4">
                {{ $t('surveys.modal.firstCard.form.description') }}
              </v-card-title>
              <div v-if="read" class="d-flex flex-column justify-center" style="min-height: 10rem">
                <h3>
                  {{
                    calculateUILocaleString({
                      languageTexts: surveyInFocus.description.languageTexts,
                    })
                  }}
                </h3>
              </div>
              <LocaleTextBox
                v-else
                labelPrefixI18nSelector="surveys.modal.firstCard.form.description"
                :initVal="description"
                @res="descriptionUpdatedHandler"
                :key="descriptionTextBoxKey"
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
            </v-col>
            <v-col cols="12" sm="6" class="pt-0 px-0 px-md-3">
              <v-card-title class="pt-0 pt-sm-2">
                {{ $t('surveys.type.title') }}:
                <div v-if="read && surveyInFocus">
                  <v-tooltip top>
                    <template v-slot:activator="{ on, attrs }">
                      <v-avatar v-bind="attrs" v-on="on">
                        <v-icon>
                          {{
                            surveyInFocus.surveyType === SurveyType.INITIAL
                              ? 'mdi-lightbulb-question-outline'
                              : 'mdi-crosshairs-question'
                          }}
                        </v-icon>
                      </v-avatar>
                    </template>
                    <span>{{ $t(`surveys.type.types.${surveyInFocus.surveyType}`) }}</span>
                  </v-tooltip>
                </div>

                <v-btn-toggle v-else v-model="typeIndex" mandatory class="ml-2">
                  <v-tooltip top>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn v-bind="attrs" v-on="on">
                        <v-icon>mdi-lightbulb-question-outline</v-icon>
                      </v-btn>
                    </template>
                    <span>{{ $t('surveys.type.types.INITIAL') }}</span>
                  </v-tooltip>
                  <v-tooltip top>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn v-bind="attrs" v-on="on">
                        <v-icon>mdi-crosshairs-question</v-icon>
                      </v-btn>
                    </template>
                    <span>{{ $t('surveys.type.types.DEFAULT') }}</span>
                  </v-tooltip>
                </v-btn-toggle>
              </v-card-title>

              <v-card-title class="pt-0 pt-sm-2">
                {{ $t('surveys.modal.image') }}
              </v-card-title>

              <v-img src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg" max-height="200px">
                <div v-if="!read" class="iv-edit-icon">
                  <v-btn fab color="primary" @click="selectImg">
                    <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
                  </v-btn>
                  <input
                    type="file"
                    accept="image/png, image/jpeg"
                    ref="img-upload"
                    style="display: none"
                  />
                </div>
              </v-img>

              <div v-if="read && surveyInFocus">
                <v-card-title class="pr-0 d-flex justify-space-between">
                  <span class="mr-2">
                    {{ $t('surveys.modal.firstCard.form.tags') }}
                  </span>
                </v-card-title>
                <div v-if="tagIdsBySurveyId({ surveyId: dataIdInFocus }).length === 0">
                  {{ $t('general.noTags') }}
                </div>
                <div v-else>
                  <v-chip
                    v-for="tagId in tagIdsBySurveyId({ surveyId: dataIdInFocus })"
                    :key="tagId"
                  >
                    {{
                      calculateUILocaleString({
                        languageTexts: tagById({ id: tagId }).text.languageTexts,
                      })
                    }}
                  </v-chip>
                </div>
              </div>
              <v-select
                v-else-if="!read"
                v-model="surveyTags"
                :items="allSurveyTags"
                item-value="tagId"
                deletable-chips
                chips
                dense
                :label="$t('surveys.modal.firstCard.form.tags')"
                multiple
                outlined
                class="mt-8"
              >
                <template v-slot:selection="data">
                  {{
                    calculateUILocaleString({
                      languageTexts: data.item.text.languageTexts,
                    })
                  }}
                </template>
                <template v-slot:item="data">
                  {{
                    calculateUILocaleString({
                      languageTexts: data.item.text.languageTexts,
                    })
                  }}
                </template>
              </v-select>

              <v-card-title class="pr-0 d-flex">
                <span class="mr-2">
                  {{ $t('surveys.modal.intervention') }}
                </span>
                <v-chip v-if="read && surveyInFocus.intervention">
                  {{
                    calculateUILocaleString({
                      languageTexts: surveyInFocus.intervention.name.languageTexts,
                    })
                  }}
                </v-chip>
                <v-select
                  v-else-if="!read"
                  v-model="interventionId"
                  :items="interventions"
                  item-value="id"
                  dense
                  :label="$t('interventions.title')"
                  outlined
                  class="mt-6"
                >
                  <template v-slot:selection="data">
                    {{
                      calculateUILocaleString({
                        languageTexts: data.item.name.languageTexts,
                      })
                    }}
                  </template>
                  <template v-slot:item="data">
                    {{
                      calculateUILocaleString({
                        languageTexts: data.item.name.languageTexts,
                      })
                    }}
                  </template>
                </v-select>
              </v-card-title>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-card-actions>
        <v-btn color="warning" text @click="exitHandler">
          {{ read ? 'Close' : $t('general.cancel') }}
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn color="primary" text @click="editHandler">
          {{ $t('general.edit') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
import { dataTypesDict, modalModesDict } from '../../../store/constants';
import LocaleTextBox from '../../global/LocaleTextBox.vue';
import { Survey, SurveyType } from '../../../models';
import { emptyMutableI18nString, mutableI18nString } from '../../../store/classes';

const surveyDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_SURVEY_DESCRIPTION_MAX_CHAR, 10),
  0,
);

export default {
  name: 'SurveyModalFirstCard',
  components: { LocaleTextBox },
  data() {
    return {
      surveyDescriptionMaxChar,
      rules: {
        maxChar: (value) => value.length <= surveyDescriptionMaxChar || this.maxCharExceededi18n,
      },
      name: emptyMutableI18nString(),
      description: emptyMutableI18nString(),
      surveyTags: [],
      SurveyType,
      typeIndex: 0,
      types: [SurveyType.INITIAL, SurveyType.DEFAULT],
      interventionId: null,
      nameTextBoxKey: 0,
      descriptionTextBoxKey: 1,
    };
  },
  mounted() {
    if (!this.read) this.prefillComponentDataFromSurveyDraft();
  },
  computed: {
    ...mapGetters({
      surveyModalMode: 'dataModal/getMode',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      surveyDraft: 'dataModal/getDataDraft',
      SURVEYById: 'SURVEY_Data/SURVEYById',
      allSurveyTags: 'SURVEY_Data/getSurveyTags',
      tagById: 'SURVEY_Data/tagById',
      tagIdsBySurveyId: 'SURVEY_Data/tagIdsBySurveyId',

      fallbackLocaleIndex: 'fallbackLocaleIndex',
      calculateUILocaleString: 'calculateUILocaleString',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      interventions: 'INTERVENTION_Data/getInterventions',
    }),
    surveyInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
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
    canAdvance() {
      return this.read || this.name.languageTexts[this.fallbackLocaleIndex];
    },
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: surveyDescriptionMaxChar,
      });
    },
    type() {
      return this.types[this.typeIndex];
    },
  },
  methods: {
    ...mapActions({
      abortNewSurveyHandler: 'dataModal/abortCreateData',
      abortReadSurveyHandler: 'dataModal/abortReadData',
      abortEditSurveyHandler: 'dataModal/abortEditData',

      editData: 'dataModal/editData',
    }),
    ...mapMutations({
      setSurveyDraft: 'dataModal/setSURVEYDraft',
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
    }),
    selectImg() {
      const imgInput = this.$refs['img-upload'];
      imgInput.click();
      // console.log('TODO: do something with', imgInput);
    },
    nextStepHandler() {
      this.setSurveyDraft(
        new Survey({
          name: this.name,
          description: this.description,
          tags: this.surveyTags,
          questions: [],
          surveyType: this.type,
          interventionSurveysId: this.interventionId,
        }),
      );
      this.incrementCompletionIndex();
    },
    prefillComponentDataFromSurveyDraft() {
      this.name = mutableI18nString({ languageTexts: this.surveyDraft?.name.languageTexts })
        ?? emptyMutableI18nString();
      this.description = mutableI18nString({ languageTexts: this.surveyDraft?.description.languageTexts })
        ?? emptyMutableI18nString();
      this.surveyTags = this.surveyDraft?.tags ?? [];
      this.interventionId = this.surveyDraft?.interventionSurveysId ?? null;

      this.descriptionTextBoxKey += 1;
      this.nameTextBoxKey -= 1;
    },
    exitHandler() {
      if (this.read) {
        this.abortReadSurveyHandler();
        return;
      }
      if (this.edit) {
        this.abortEditSurveyHandler({ dataId: this.dataIdInFocus, dataType: 'SURVEY' });
        return;
      }
      if (this.create) {
        this.abortNewSurveyHandler({ dataType: 'SURVEY' });
      }
    },
    editHandler() {
      this.editData({ dataId: this.dataIdInFocus, dataType: dataTypesDict.survey });
    },
    nameUpdatedHandler(res) {
      this.name = res;
    },
    descriptionUpdatedHandler(res) {
      this.description = res;
    },
  },
};
</script>

<style scoped>
.iv-edit-icon {
  position: absolute;
  top: 8px;
  right: 8px;
}
</style>
