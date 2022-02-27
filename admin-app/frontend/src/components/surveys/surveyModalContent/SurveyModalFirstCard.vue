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
              <h2 v-if="read">
                {{ surveyName }}
              </h2>
              <v-text-field
                v-else
                autofocus
                v-model="surveyName"
                :label="$t('interventions.surveyModal.firstCard.form.name')"
                outlined
                dense
              ></v-text-field>

              <h3 v-if="read" class="py-12">
                {{ surveyDescription }}
              </h3>
              <v-textarea
                v-else
                v-model="surveyDescription"
                :counter="surveyDescription.length > surveyDescriptionMaxChar - 20"
                :rules="[rules.maxChar]"
                :label="$t('interventions.surveyModal.firstCard.form.description')"
                outlined
                dense
                class="mt-4"
              ></v-textarea>
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

const surveyDescriptionMaxChar = Math.max(
  parseInt(process.env.VUE_APP_SURVEY_DESCRIPTION_MAX_CHAR, 10),
  0,
);

export default {
  name: 'SurveyModalFirstCard',
  data() {
    return {
      surveyDescriptionMaxChar,
      rules: {
        maxChar: (value) => value.length <= surveyDescriptionMaxChar || this.maxCharExceededi18n,
      },
      surveyName: '',
      surveyDescription: '',
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
      return this.read || this.surveyName !== '';
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
        name: this.surveyName,
        description: this.surveyDescription,
        tags: this.surveyTags,
      });
      this.incrementCompletionIndex();
    },
    prefillComponentDataFromSurveyDraft() {
      this.surveyName = this.surveyDraft?.name ?? '';
      this.surveyDescription = this.surveyDraft?.description ?? '';
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
