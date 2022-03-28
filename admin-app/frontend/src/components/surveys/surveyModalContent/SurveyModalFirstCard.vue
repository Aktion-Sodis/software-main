<template>
  <v-card class="px-0 pt-0 px-md-4 pt-md-4">
    <v-form lazy-validation>
      <v-card-title>
        <h2 v-if="edit">
          {{ $t('interventions.surveyModal.firstCard.title.edit') }}
          <i>{{ surveyInFocus.name }}</i>
        </h2>
        <h2 v-else-if="create">
          {{ $t('interventions.surveyModal.firstCard.title.create') }}
        </h2>
        <h2 v-else-if="read">{{ surveyInFocus.name }}</h2>
        <v-spacer></v-spacer>
        <v-btn x-large text class="text-none" @click="nextStepHandler" :disabled="!canAdvance">
          {{
            $vuetify.breakpoint.name === 'xs'
              ? ''
              : read
              ? $t('interventions.surveyModal.firstCard.questions')
              : $t(`interventions.surveyModal.firstCard.next-step`)
          }}
          <v-icon large> mdi-chevron-right </v-icon>
        </v-btn>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12" sm="6" class="pb-0 px-0 px-md-3">
              <v-card-title class="pt-0 pt-sm-2">
                {{ $t('interventions.surveyModal.firstCard.form.name') }}
              </v-card-title>
              <h2 v-if="read">
                {{
                  calculateUILocaleString({
                    languageTexts: name.languageTexts,
                  })
                }}
              </h2>
              <LocaleTextBox
                v-else
                labelPrefixI18nSelector="interventions.surveyModal.firstCard.form.name"
                @res="nameUpdatedHandler"
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
                {{ $t('interventions.surveyModal.firstCard.form.description') }}
              </v-card-title>
              <div v-if="read" class="d-flex flex-column justify-center" style="min-height: 10rem">
                <h3>
                  {{
                    calculateUILocaleString({
                      languageTexts: description.languageTexts,
                    })
                  }}
                </h3>
              </div>
              <LocaleTextBox
                v-else
                labelPrefixI18nSelector="interventions.surveyModal.firstCard.form.description"
                @res="descriptionUpdatedHandler"
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

              <div v-if="read">
                <h2>
                  {{ $t('interventions.surveyModal.firstCard.form.tags') }}
                </h2>
                <v-chip v-for="tag in tagsInFocus" :key="tag.tagId">
                  {{ tag }}
                </v-chip>
              </div>
              <v-select
                v-else
                v-model="surveyTags"
                :items="allSurveyTags"
                item-value="tagId"
                item-text="name"
                deletable-chips
                chips
                dense
                :label="$t('interventions.surveyModal.firstCard.form.tags')"
                multiple
                outlined
                class="mt-8"
              ></v-select>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-card-actions>
        <v-btn color="warning" text @click="exitHandler">
          {{ read ? 'Close' : $t('general.cancel') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';
import { modalModesDict } from '../../../store/constants';
import LocaleTextBox from '../../global/LocaleTextBox.vue';
import { I18nString } from '../../../models';

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
      name: new I18nString({
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(null),
      }),
      description: new I18nString({
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(null),
      }),
      surveyTags: [],
    };
  },
  mounted() {
    this.prefillComponentDataFromSurveyDraft();
  },
  computed: {
    ...mapGetters({
      surveyModalMode: 'dataModal/getMode',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      surveyDraft: 'dataModal/getDataDraft',
      SURVEYById: 'SURVEY_Data/SURVEYById',
      allSurveyTags: 'SURVEY_Data/getSurveyTags',
      tagById: 'SURVEY_Data/tagById',

      fallbackLocaleIndex: 'fallbackLocaleIndex',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    surveyInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
    },
    tagsInFocus() {
      return this.surveyInFocus.tagIds.map((t) => this.tagById(t));
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
      console.log(this.name);
      return this.read || this.name.languageTexts[this.fallbackLocaleIndex] !== '';
    },
    maxCharExceededi18n() {
      return this.$t('general.form.maxCharExceeded', {
        maxChar: surveyDescriptionMaxChar,
      });
    },
  },
  methods: {
    ...mapActions({
      abortNewSurveyHandler: 'dataModal/abortCreateData',
      abortReadSurveyHandler: 'dataModal/abortReadData',
      abortEditSurveyHandler: 'dataModal/abortEditData',
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
      this.setSurveyDraft({
        name: this.name,
        description: this.description,
        tags: this.surveyTags,
      });
      this.incrementCompletionIndex();
    },
    prefillComponentDataFromSurveyDraft() {
      this.name = this.surveyDraft?.name ?? '';
      this.description = this.surveyDraft?.description ?? '';
      this.surveyTags = this.surveyDraft?.tags ?? [];
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
