<template>
  <SurveyModalFirstCardRead v-if="completionIndex === 1 && read" />
  <SurveyModalFirstCardForm v-else-if="completionIndex === 1 && !read" />

  <SurveyModalQuestionRead v-else-if="completionIndex === 2 && read" />
  <SurveyModalQuestionForm v-else-if="completionIndex === 2 && !read" />

  <!-- This step is available only in create mode -->
  <SurveyModalFinalize v-else-if="completionIndex === 3" />
</template>

<script>
import { mapGetters } from 'vuex';
import { modalModesDict } from '../../../lib/constants';

import SurveyModalFirstCardRead from './firstCard/SurveyModalFirstCardRead.vue';
import SurveyModalFirstCardForm from './firstCard/SurveyModalFirstCardForm.vue';

import SurveyModalQuestionRead from './question/SurveyModalQuestionRead.vue';
import SurveyModalQuestionForm from './question/SurveyModalQuestionForm.vue';

import SurveyModalFinalize from './SurveyModalFinalize.vue';

export default {
  name: 'SurveyModal',
  components: {
    SurveyModalFirstCardRead,
    SurveyModalFirstCardForm,
    SurveyModalQuestionRead,
    SurveyModalQuestionForm,
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
