<template>
  <div>
    <InterventionModal v-if="showInterventionModal" />
    <SurveyModal v-if="showSurveyModal" />
    <h1 class="ml-8">
      {{ $t('interventions.title') }}
    </h1>
    <v-container class="mt-8">
      <v-row class="">
        <v-col cols="12" sm="6" md="4" xl="3">
          <div style="height: 100%" class="pa-2">
            <div style="height: 100%" class="d-flex flex-column justify-space-around">
              <div class="d-flex flex-column align-center">
                <v-btn
                  fab
                  x-large
                  color="primary"
                  @click="newInterventionHandler({ dataType: 'INTERVENTION' })"
                >
                  <v-icon dark> mdi-wrench </v-icon>
                </v-btn>
                <h2 class="mt-2 mb-4">
                  {{ $t('interventions.newIntervention') }}
                </h2>
              </div>
              <div class="d-flex flex-column align-center">
                <v-btn fab small color="primary" @click="newSurveyHandler({ dataType: 'SURVEY' })">
                  <v-icon dark> mdi-crosshairs-question </v-icon>
                </v-btn>
                <h3 class="mt-2">{{ $t('interventions.newSurvey') }}</h3>
              </div>
            </div>
          </div>
        </v-col>
        <v-col
          v-for="intervention in interventions"
          :key="intervention.id"
          cols="12"
          sm="6"
          md="4"
          xl="3"
        >
          <Intervention
            :id="intervention.id"
            :interventionName="intervention.name"
            :interventionDescription="intervention.description"
            :interventionTagIds="intervention.tagIds"
            :interventionContent="intervention.content"
          />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

import Intervention from '../components/interventions/Intervention.vue';
import InterventionModal from '../components/interventions/InterventionModal.vue';
import SurveyModal from '../components/surveys/SurveyModal.vue';

export default {
  name: 'Interventions',
  components: { Intervention, InterventionModal, SurveyModal },
  data() {
    return {
      showInterventionModal: false,
      showSurveyModal: false,
    };
  },
  computed: {
    ...mapGetters({
      interventions: 'INTERVENTION_Data/getInterventions',
      isInterventionModalDisplayed: 'dataModal/getIsDisplayed',
      isSurveyModalDisplayed: 'dataModal/getIsDisplayed',
    }),
  },
  watch: {
    isInterventionModalDisplayed: 'destroyInterventionModalAfterDelay',
    isSurveyModalDisplayed: 'destroySurveyModalAfterDelay',
  },

  methods: {
    ...mapActions({
      newSurveyHandler: 'dataModal/createData',
      newInterventionHandler: 'dataModal/createData',
    }),
    // If closed, wait for 500, if still closed, destroy component instance
    async destroyInterventionModalAfterDelay(newValue) {
      if (newValue) {
        this.showInterventionModal = true;
        return;
      }
      await new Promise((resolve) => setTimeout(resolve, 500));
      if (!this.isInterventionModalDisplayed) this.showInterventionModal = false;
    },
    // If closed, wait for 500, if still closed, destroy component instance
    async destroySurveyModalAfterDelay(newValue) {
      if (newValue) {
        this.showSurveyModal = true;
        return;
      }
      await new Promise((resolve) => setTimeout(resolve, 500));
      if (!this.isInterventionModalDisplayed) this.showSurveyModal = false;
    },
  },
};
</script>

<style scoped></style>
