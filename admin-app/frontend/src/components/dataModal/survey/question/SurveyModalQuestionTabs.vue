<template>
  <v-tabs background-color="grey lighten-3" show-arrows centered center-active v-model="iQ">
    <draggable
      v-model="questions"
      @start="drag = true"
      @end="drag = false"
      class="d-flex"
      :move="handleDrag"
    >
      <v-tab v-for="(q, i) in questions" :key="i" :value="i">
        <v-icon v-if="i === nQuestions - 1 && !read" large> mdi-plus </v-icon>
        <v-badge v-else :content="i + 1" bottom overlap>
          <div>
            <div v-if="q.type === QuestionType.MULTIPLECHOICE">
              <v-icon> mdi-checkbox-outline </v-icon>
              <v-icon> mdi-checkbox-outline </v-icon>
              <v-icon> mdi-checkbox-blank-outline </v-icon>
            </div>
            <div v-else-if="q.type === QuestionType.SINGLECHOICE">
              <v-icon> mdi-radiobox-marked </v-icon>
              <v-icon> mdi-radiobox-blank </v-icon>
              <v-icon> mdi-radiobox-blank </v-icon>
            </div>
            <div v-else-if="q.type === QuestionType.RATING">
               <v-icon> mdi-star </v-icon>
               <v-icon> mdi-star </v-icon>
               <v-icon> mdi-star-half-full </v-icon>
             </div>
            <v-icon v-else large>
              {{ questionTypesIconDict[q.type] }}
            </v-icon>
          </div>
        </v-badge>
      </v-tab>
    </draggable>
  </v-tabs>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex';
import draggable from 'vuedraggable';
import { modalModesDict, questionTypesIconDict, vuexModulesDict } from '../../../../lib/constants';
import { QuestionType } from '../../../../models';

export default {
  name: 'SurveyModalQuestionTabs',
  components: { draggable },
  data() {
    return {
      iQ: 0,
      questionTypesIconDict,
      drag: [],
      QuestionType,
    };
  },
  mounted() {
    this.iQ = this.iQuestions;
  },
  watch: {
    iQ(newVal) {
      // update the index in state only if it is caused by iQ
      if (newVal !== this.iQuestions) this.setIQuestions({ payload: newVal });
    },
    iQuestions(newVal) {
      this.iQ = newVal;
    },
  },
  computed: {
    ...mapGetters({
      questions: `${vuexModulesDict.question}/questionWithOptionDrafts`,
      iQuestions: `${vuexModulesDict.question}/getIQuestions`,
      nQuestions: `${vuexModulesDict.question}/nQuestions`,

      surveyModalMode: `${vuexModulesDict.dataModal}/getMode`,
      dataIdInFocus: `${vuexModulesDict.dataModal}/getDataIdInFocus`,

      SURVEYById: `${vuexModulesDict.survey}/SURVEYById`,
    }),
    questions: {
      get() {
        return this.read
          ? this.surveyInFocus.questions
          : this.$store.getters[`${vuexModulesDict.question}/questionWithOptionDrafts`];
      },
      set(value) {
        this.$store.commit(
          `${vuexModulesDict.question}/setQuestions`,
          { payload: value },
          { root: true },
        );
        this.$store.commit(
          `${vuexModulesDict.question}/setOptions`,
          { payload: value.map((q) => q.optionDrafts) },
          { root: true },
        );
      },
    },
    read() {
      return this.surveyModalMode === modalModesDict.read;
    },
    surveyInFocus() {
      return this.SURVEYById({ id: this.dataIdInFocus });
    },
  },
  methods: {
    ...mapMutations({
      setIQuestions: `${vuexModulesDict.question}/setIQuestions`,
    }),
    handleDrag(evt) {
      return (
        !evt.draggedContext.element?.isEmptyQuestion && !evt.relatedContext.element?.isEmptyQuestion
      );
    },
  },
};
</script>
