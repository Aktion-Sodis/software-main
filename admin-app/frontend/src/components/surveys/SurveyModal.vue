<template>
  <v-dialog
    @keydown.esc="escHandler"
    v-model="isSurveyModalDisplayed"
    max-width="1200px"
    persistent
  >
    <SurveyModalStepper v-if="create" />

    <SurveyModalFirstCard v-if="completionIndex === 1" />

    <SurveyModalQuestion v-if="completionIndex === 2" />
    <QuestionTabs v-if="completionIndex === 2" />

    <SurveyModalFinalize v-else-if="completionIndex === 3" />
  </v-dialog>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import { modalModesDict, dataTypesDict } from '../../store/constants';

import SurveyModalStepper from './surveyModalContent/SurveyModalStepper.vue';
import QuestionTabs from './surveyModalContent/QuestionTabs.vue';
import SurveyModalFirstCard from './surveyModalContent/SurveyModalFirstCard.vue';
import SurveyModalQuestion from './surveyModalContent/SurveyModalQuestion.vue';
import SurveyModalFinalize from './surveyModalContent/SurveyModalFinalize.vue';

export default {
  name: 'SurveyModal',
  components: {
    SurveyModalFirstCard,
    SurveyModalQuestion,
    SurveyModalFinalize,
    QuestionTabs,
    SurveyModalStepper,
  },
  computed: {
    ...mapGetters({
      surveyModalMode: 'dataModal/getMode',
      isDataModalDisplayed: 'dataModal/getIsDisplayed',
      dataType: 'dataModal/getDataType',
      dataIdInFocus: 'dataModal/getDataIdInFocus',
      completionIndex: 'getSurveyModalCompletionIndex',
    }),
    isSurveyModalDisplayed() {
      return this.isDataModalDisplayed && this.dataType === dataTypesDict.survey;
    },
    edit() {
      return this.surveyModalMode === modalModesDict.edit;
    },
    create() {
      return this.surveyModalMode === modalModesDict.create;
    },
    read() {
      return this.surveyModalMode === modalModesDict.read;
    },
  },
  methods: {
    ...mapActions({
      abortReadSurveyHandler: 'dataModal/abortReadData',
      abortNewSurveyHandler: 'dataModal/abortCreateData',
      abortEditSurveyHandler: 'dataModal/abortEditData',
    }),
    escHandler() {
      if (this.read) this.abortReadSurveyHandler();
      else if (this.edit) this.abortEditSurveyHandler({ dataId: this.dataIdInFocus, dataType: dataTypesDict.survey });
      else if (this.create) this.abortNewSurveyHandler({ dataType: dataTypesDict.survey });
    },
  },
};
</script>
