<template>
  <v-dialog v-model="isDisplayed" max-width="1200px" persistent @keydown.esc="escHandler">
    <v-card class="px-0 pt-0 px-md-4 pt-md-4">
      <InterventionModalRead v-if="isRead && isIntervention" />
      <InterventionModalForm v-else-if="!isRead && isIntervention" />

      <EntityModalRead v-else-if="isRead && isEntity" />
      <EntityModalForm v-else-if="!isRead && isEntity" />

      <LevelModalRead v-else-if="isRead && isLevel" />
      <LevelModalForm v-else-if="!isRead && isLevel" />

      <SurveyModalRead v-else-if="isRead && isSurvey" />
      <SurveyModalForm v-else-if="!isRead && isSurvey" />
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters } from 'vuex';
import { dataTypesDict, modalModesDict } from '../../lib/constants';
import InterventionModalForm from './intervention/InterventionModalForm.vue';
import InterventionModalRead from './intervention/InterventionModalRead.vue';

export default {
  name: 'DataModal',
  components: {
    InterventionModalForm,
    InterventionModalRead,
  },
  computed: {
    ...mapGetters({
      mode: 'dataModal/getMode',
      isDisplayed: 'dataModal/getIsDisplayed',
      dataType: 'dataModal/getDataType',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
    }),
    isRead() {
      return this.mode === modalModesDict.read;
    },
    isIntervention() {
      return this.dataType === dataTypesDict.intervention;
    },
    isEntity() {
      return this.dataType === dataTypesDict.entity;
    },
    isLevel() {
      return this.dataType === dataTypesDict.level;
    },
    isSurvey() {
      return this.dataType === dataTypesDict.survey;
    },
  },
};
</script>
