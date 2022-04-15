<template>
  <v-dialog
    v-model="isModalDisplayed"
    max-width="1200px"
    :persistent="!isRead"
    @keydown.esc="escHandler"
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
import { mapActions, mapGetters, mapMutations } from 'vuex';
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
    isModalDisplayed: {
      get() {
        return this.isDisplayed;
      },
      set(value) {
        this.setIsDisplayed({ newValue: value });
      },
    },
  },
  methods: {
    ...mapActions({
      abortCreateData: 'dataModal/abortCreateData',
      abortEditData: 'dataModal/abortEditData',
      abortReadData: 'dataModal/abortReadData',
    }),
    ...mapMutations({
      setIsDisplayed: 'dataModal/setIsDisplayed',
    }),
    escHandler() {
      if (this.mode === modalModesDict.edit) this.abortEditData();
      else if (this.isRead) this.abortCreateData();
      else this.abortReadData();
    },
  },
};
</script>
