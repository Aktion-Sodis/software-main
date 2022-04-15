<template>
  <SurveyModalFirstCardRead v-if="completionIndex === 1 && read" />
  <SurveyModalFirstCardAsForm v-else-if="completionIndex === 1 && !read" />

  <SurveyModalQuestionRead v-else-if="completionIndex === 2 && read" />
  <SurveyModalQuestionAsForm v-else-if="completionIndex === 2 && !read" />

  <!-- This step is available only in create mode -->
  <SurveyModalFinalize v-else-if="completionIndex === 3" />
</template>

<script>
import { mapGetters } from 'vuex';
import { modalModesDict } from '../../../lib/constants';

import SurveyModalFirstCardRead from './firstCard/SurveyModalFirstCardRead.vue';
import SurveyModalFirstCardAsForm from './firstCard/SurveyModalFirstCardAsForm.vue';

import SurveyModalQuestionRead from './question/SurveyModalQuestionRead.vue';
import SurveyModalQuestionAsForm from './question/SurveyModalQuestionAsForm.vue';

import SurveyModalFinalize from './SurveyModalFinalize.vue';

export default {
  name: 'SurveyModal',
  components: {
    SurveyModalFirstCardRead,
    SurveyModalFirstCardAsForm,
    SurveyModalQuestionRead,
    SurveyModalQuestionAsForm,
    SurveyModalFinalize,
  },
  computed: {
    ...mapGetters({
      surveyModalMode: 'dataModal/getMode',
      dataType: 'dataModal/getDataType',
      completionIndex: 'getSurveyModalCompletionIndex',
    }),
    create() {
      return this.surveyModalMode === modalModesDict.create;
    },
    read() {
      return this.surveyModalMode === modalModesDict.read;
    },
  },
};
</script>
