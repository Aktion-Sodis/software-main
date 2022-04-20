<template>
  <v-dialog
    v-model="isDisplayed"
    max-width="1200px"
    :persistent="!isRead"
    @keydown.esc="escHandler"
    v-if="isDisplayedAsData"
  >
    <v-card class="pa-0">
      <InterventionModalRead v-if="isRead && isIntervention" />
      <InterventionModalAsForm v-else-if="!isRead && isIntervention" />

      <EntityModalRead v-else-if="isRead && isEntity" />
      <EntityModalAsForm v-else-if="!isRead && isEntity" />

      <LevelModalRead v-else-if="isRead && isLevel" />
      <LevelModalAsForm v-else-if="!isRead && isLevel" />

      <SurveyModalStepper v-else-if="isSurvey && isCreate" />
      <SurveyModal v-if="isSurvey" />
      <SurveyModalQuestionTabs v-if="isSurvey && completionIndex === 2" />
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import { dataTypesDict, modalModesDict } from '../../lib/constants';

import InterventionModalAsForm from './intervention/InterventionModalAsForm.vue';
import InterventionModalRead from './intervention/InterventionModalRead.vue';

import EntityModalAsForm from './entity/EntityModalAsForm.vue';
import EntityModalRead from './entity/EntityModalRead.vue';

import LevelModalAsForm from './level/LevelModalAsForm.vue';
import LevelModalRead from './level/LevelModalRead.vue';

import SurveyModalStepper from './survey/SurveyModalStepper.vue';
import SurveyModal from './survey/SurveyModal.vue';
import SurveyModalQuestionTabs from './survey/question/SurveyModalQuestionTabs.vue';
import { waitForMilliseconds } from '../../lib/utils';

export default {
  name: 'DataModal',
  components: {
    InterventionModalAsForm,
    InterventionModalRead,
    EntityModalAsForm,
    EntityModalRead,
    LevelModalAsForm,
    LevelModalRead,
    SurveyModalStepper,
    SurveyModal,
    SurveyModalQuestionTabs,
  },
  data: () => ({
    isDisplayedAsData: false,
  }),
  watch: {
    isDisplayed: 'destroyModalAfterDelay',
  },
  computed: {
    ...mapGetters({
      mode: 'dataModal/getMode',
      isDisplayed: 'dataModal/getIsDisplayed',
      dataType: 'dataModal/getDataType',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      completionIndex: 'getSurveyModalCompletionIndex',
    }),
    isRead() {
      return this.mode === modalModesDict.read;
    },
    isCreate() {
      return this.mode === modalModesDict.create;
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
  methods: {
    ...mapActions({
      abortCreateData: 'dataModal/abortCreateData',
      abortEditData: 'dataModal/abortEditData',
      abortReadData: 'dataModal/abortReadData',
    }),
    escHandler() {
      if (this.mode === modalModesDict.edit) this.abortEditData();
      else if (this.isRead) this.abortReadData();
      else this.abortCreateData();
    },
    async destroyModalAfterDelay(newValue) {
      // If closed, wait for 500, if still closed, destroy component instance
      if (newValue) {
        this.isDisplayedAsData = true;
        return;
      }
      await waitForMilliseconds(500);
      if (!this.isDisplayed) this.isDisplayedAsData = false;
    },
  },
};
</script>
