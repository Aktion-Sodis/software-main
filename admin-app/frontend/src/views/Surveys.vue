<template>
  <div>
    <SurveyModal v-if="showSurveyModal" />
    <h1 class="ml-8">
      {{ $t('surveys.title') }}
    </h1>
    <v-container class="mt-8">
      <v-row>
        <v-col cols="12" sm="6" md="4" xl="3">
          <DataCreationButtonCard
            :dataType="dataTypesDict.survey"
            subtitleI18nSelector="surveys.newSurvey"
          >
            <template v-slot:creation-button="slotProps">
              <v-btn fab x-large color="primary" @click="slotProps.clickHandler">
                <v-icon dark> mdi-crosshairs-question </v-icon>
              </v-btn>
            </template>
          </DataCreationButtonCard>
        </v-col>
        <v-col v-for="survey in surveys" :key="survey.id" cols="12" sm="6" md="4" xl="3">
          <Survey
            :id="survey.id"
            :surveyName="survey.name"
            :surveyDescription="survey.description"
            :surveyTagIds="survey.tags"
            :surveyContent="survey.content"
            :interventionName="survey.intervention ? survey.intervention.name : null"
            :interventionId="survey.intervention ? survey.intervention.id : null"
          />
        </v-col>
        <v-col v-for="index in ['s1', 's2', 's3']" :key="index" cols="12" sm="6" md="4" xl="3">
          <InterventionSkeleton v-if="loading" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import { waitForMilliseconds } from '../lib/utils';
import { dataTypesDict, routeNamesDict } from '../lib/constants';

import SurveyModal from '../components/surveys/SurveyModal.vue';
import InterventionSkeleton from '../components/interventions/InterventionSkeleton.vue';
import DataCreationButtonCard from '../components/commons/DataCreationButtonCard.vue';
import Survey from '../components/surveys/Survey.vue';

export default {
  name: routeNamesDict.Surveys,
  components: {
    SurveyModal,
    DataCreationButtonCard,
    InterventionSkeleton,
    Survey,
  },
  data() {
    return {
      showSurveyModal: false,
      dataTypesDict,
    };
  },
  computed: {
    ...mapGetters({
      surveys: 'SURVEY_Data/getSurveys',
      loading: 'SURVEY_Data/getLoading',
      isSurveyModalDisplayed: 'dataModal/getIsDisplayed',
    }),
    currentLocale() {
      return this.$i18n.locale;
    },
  },
  watch: {
    isInterventionModalDisplayed: 'destroyInterventionModalAfterDelay',
    isSurveyModalDisplayed: 'destroySurveyModalAfterDelay',
  },
  methods: {
    // If closed, wait for 500, if still closed, destroy component instance
    async destroySurveyModalAfterDelay(newValue) {
      if (newValue) {
        this.showSurveyModal = true;
        return;
      }
      await waitForMilliseconds(500);
      if (!this.isInterventionModalDisplayed) this.showSurveyModal = false;
    },
  },
};
</script>

<style scoped></style>
