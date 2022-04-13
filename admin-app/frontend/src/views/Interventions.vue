<template>
  <div>
    <h1 class="ml-8">
      {{ $t('interventions.title') }}
    </h1>
    <v-container class="mt-8">
      <v-row>
        <v-col cols="12" sm="6" md="4" xl="3">
          <DataCreationButtonCard
            :dataType="dataType"
            subtitleI18nSelector="interventions.newIntervention"
          >
            <template v-slot:creation-button="slotProps">
              <v-btn fab x-large color="primary" @click="slotProps.clickHandler">
                <v-icon dark> mdi-wrench </v-icon>
              </v-btn>
            </template>
          </DataCreationButtonCard>
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
        <v-col v-for="index in ['s1', 's2', 's3']" :key="index" cols="12" sm="6" md="4" xl="3">
          <InterventionSkeleton v-if="loading" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import { dataTypesDict } from '../lib/constants';

import Intervention from '../components/interventions/Intervention.vue';
import InterventionSkeleton from '../components/interventions/InterventionSkeleton.vue';
import DataCreationButtonCard from '../components/commons/DataCreationButtonCard.vue';

export default {
  name: 'Interventions',
  components: {
    Intervention,
    DataCreationButtonCard,
    InterventionSkeleton,
  },
  data() {
    return {
      showInterventionModal: false,
    };
  },
  computed: {
    ...mapGetters({
      interventions: 'INTERVENTION_Data/getInterventions',
      loading: 'INTERVENTION_Data/getLoading',
      isInterventionModalDisplayed: 'dataModal/getIsDisplayed',
    }),
    dataType() {
      return dataTypesDict.intervention;
    },
  },
};
</script>

<style scoped></style>
