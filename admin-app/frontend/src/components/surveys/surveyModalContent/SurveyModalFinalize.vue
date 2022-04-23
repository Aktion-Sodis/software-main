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
import { dataTypesDict, vuexModulesDict } from '../../../lib/constants';

export default {
  name: 'Finalize',
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      surveyDraft: `${vuexModulesDict.dataModal}/getDataDraft`,
      calculateUILocaleString: 'calculateUILocaleString',
      dataIdInFocus: `${vuexModulesDict.dataModal}/getDataIdInFocus`,
      SURVEYById: `${vuexModulesDict.survey}/SURVEYById`,
    }),
  },
  methods: {
    ...mapActions({
      saveData: `${vuexModulesDict.dataModal}/saveData`,
    }),
    ...mapMutations({
      incrementCompletionIndex: 'incrementSurveyModalCompletionIndex',
      decrementCompletionIndex: 'decrementSurveyModalCompletionIndex',
    }),
    handlePublishSurvey() {
      this.saveData({
        dataType: dataTypesDict.survey,
        originalVersion: this.edit ? this.SURVEYById({ id: this.dataIdInFocus })._version : null,
      });
    },
  },
};
</script>
