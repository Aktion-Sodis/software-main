<template>
  <v-stepper alt-labels v-model="completionIndex">
    <v-stepper-header>
      <v-stepper-step step="1" :complete="completionIndex > 1">
        {{ $t('surveys.modal.stepper.details') }}
      </v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="2" :complete="completionIndex > 2">
        {{ $t('surveys.modal.stepper.questions') }}
      </v-stepper-step>
      <v-divider></v-divider>
      <v-stepper-step step="3">
        {{ $t('surveys.modal.stepper.finalize') }}
      </v-stepper-step>
    </v-stepper-header>
  </v-stepper>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'SurveyModalStepper',
  computed: {
    ...mapGetters({
      completionIndex: 'getSurveyModalCompletionIndex',
    }),
  },
};
</script>
