<template>
  <div>
    <SurveyModal v-if="showSurveyModal" />
    <h1 class="ml-8">
      {{ $t('surveys.title') }}
    </h1>
    <div>
      <div class="d-flex flex-column align-center justify-center py-4">
        <div class="subtitle-1">{{ $t('general.filters.title') }}</div>
        <v-sheet elevation="1" outlined rounded class="pa-2">
          <v-tooltip bottom v-for="filterKey in Object.keys(filters)" :key="filterKey">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                elevation="2"
                icon
                tile
                x-large
                v-bind="attrs"
                v-on="on"
                @click="setFilter({ filter: filterKey, newValue: !filters[filterKey] })"
              >
                <v-icon> {{ filterUIDict[filterKey].get(filters[filterKey]).icon }} </v-icon>
              </v-btn>
            </template>
            <span>
              {{ $t(filterUIDict[filterKey].get(filters[filterKey]).tooltipI18nSelector) }}
            </span>
          </v-tooltip>
        </v-sheet>
      </div>
      <v-divider></v-divider>
    </div>
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
import { mapGetters, mapMutations } from 'vuex';
import { waitForMilliseconds } from '../lib/utils';
import {
  dataTypesDict, filterUIDict, routeNamesDict, vuexModulesDict,
} from '../lib/constants';

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
    };
  },
  computed: {
    ...mapGetters({
      surveys: `${vuexModulesDict.survey}/getSurveys`,
      loading: `${vuexModulesDict.survey}/getLoading`,
      isSurveyModalDisplayed: `${vuexModulesDict.dataModal}/getIsDisplayed`,
      filters: `${vuexModulesDict.survey}/getFilters`,
    }),
    currentLocale() {
      return this.$i18n.locale;
    },
    dataTypesDict() {
      return dataTypesDict;
    },
    filterUIDict() {
      return filterUIDict;
    },
  },
  watch: {
    isInterventionModalDisplayed: 'destroyInterventionModalAfterDelay',
    isSurveyModalDisplayed: 'destroySurveyModalAfterDelay',
  },
  mounted() {
    console.log(this.filters);
  },
  methods: {
    ...mapMutations({
      setFilter: `${vuexModulesDict.survey}/setFilter`,
    }),

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
