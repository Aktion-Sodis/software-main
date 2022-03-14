<template>
  <div style="height: 100%" class="pa-2">
    <div style="height: 100%" class="d-flex flex-column justify-space-around">
      <div class="d-flex flex-column align-center">
        <v-btn fab x-large color="primary" @click="newInterventionHandler">
          <v-icon dark> mdi-wrench </v-icon>
        </v-btn>
        <h2 class="mt-2 mb-4">
          {{ $t('interventions.newIntervention') }}
        </h2>
      </div>
      <div class="d-flex flex-column align-center">
        <v-btn fab small color="primary" @click="newSurveyHandler">
          <v-icon dark> mdi-crosshairs-question </v-icon>
        </v-btn>
        <h3 class="mt-2">{{ $t('interventions.newSurvey') }}</h3>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import { dataTypesDict } from '../../store/constants';

export default {
  name: 'InterventionCreationButtonsCard',
  methods: {
    ...mapActions({
      newSurveyAction: 'dataModal/createData',
      newInterventionAction: 'dataModal/createData',
    }),
    newSurveyHandler() {
      this.newSurveyAction({ dataType: dataTypesDict.survey });
    },
    newInterventionHandler() {
      this.newInterventionAction({ dataType: dataTypesDict.intervention });
    },
  },
};
</script>
