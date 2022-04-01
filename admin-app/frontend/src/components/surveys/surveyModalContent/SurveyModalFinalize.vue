<template>
  <v-card class="px-4 pt-4">
    <v-card-title>
      <h2>
        {{
          calculateUILocaleString({
            languageTexts: surveyDraft.name.languageTexts,
          })
        }}
      </h2>
      <v-spacer></v-spacer>
      <v-btn x-large text class="text-none" @click="handlePublishSurvey" :disabled="false">
        {{ $t('surveys.modal.finalizeCard.publishSurvey') }}
        <v-icon large class="ml-2"> mdi-bullhorn-outline </v-icon>
      </v-btn>
    </v-card-title>

    <v-card-text></v-card-text>

    <v-card-actions> </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from 'vuex';

export default {
  name: 'Finalize',
  watch: {},
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      surveyDraft: 'dataModal/getDataDraft',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
  },
  methods: {
    ...mapActions({
      publishSurveyHandler: 'SURVEY_Data/APIpost',
    }),
    ...mapMutations({
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
      decrementCompletionIndex: 'decrementSurveyModalCompletionIndex',
    }),
    handlePublishSurvey() {
      this.publishSurveyHandler();
    },
  },
};
</script>
