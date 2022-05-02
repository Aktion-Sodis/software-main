<template>
  <div class="main">
    <div class="sub-title">
      <div class="icon-wrapper" @click="toggleQuestionList">
        <span class="collapse-icon" :class="{ 'rotate-180': collapsed }">
          <i class="fas fa-angle-double-left" />
        </span>
      </div>
      <h1>Fragebogen: Kochstellen</h1>
      <el-button class="compare" @click="showSurveyModal"
        >Mehrere vergleichen</el-button
      >
    </div>
    <div class="survey-content">
      <div class="question-list">
        <div class="questions" :class="{ collapsed: collapsed }">
          <div
            v-for="(question, index) in questions"
            :key="question.id"
            class="question"
            :class="{
              active: selectedID === question.question_id,
              collapsed: collapsed,
            }"
            @click="setActive(question)"
          >
            <div class="question-index-wrapper">
              {{ index + 1 }}
            </div>
            <div v-if="!collapsed" class="question-text-wrapper">
              {{ question.question_text }}
            </div>
          </div>
        </div>
      </div>
      <div class="content-wrapper" @click="closeQuestionList">
        <div class="question-wrapper">
          <div class="question-inner-wrapper">
            <div class="question-text-wrapper">
              <h3 style="text-align: left">
                {{ selectedQuestion.question_text }}
              </h3>
            </div>
          </div>
        </div>
        <component
          class="answer-wrapper"
          :is="componentsMap[selectedQuestion.question_type]"
          :selectedQuestion="selectedQuestion"
        />
      </div>
    </div>
    <SurveyModal v-show="isSurveyModalVisible" @close="closeSurveyModal" />
  </div>
</template>

<script>
import { ref } from "vue";
import { mapState } from "vuex";
import "element-plus/theme-chalk/display.css";
import initialComponent from "../components/evaluation/initialComponent.vue";
import textComponent from "../components/evaluation/textComponent.vue";
import imageComponent from "../components/evaluation/imageComponent.vue";
import chartComponent from "../components/evaluation/chartComponent.vue";

import SurveyModal from "../components/surveys/SurveyModal.vue";

const componentsMap = {
  initial: initialComponent,
  text: textComponent,
  image: imageComponent,
  chart: chartComponent,
};

const collapsed = ref(true);

export default {
  props: {},
  components: { SurveyModal },
  computed: {
    ...mapState({
      questions: (state) => state.questionData.questions,
    }),
    selectedQuestion() {
      return (
        this.questions.find((item) => item.question_id === this.selectedID) || 0
      );
    },
  },
  methods: {
    setActive(question) {
      const comp = componentsMap[question.question_type];
      return (
        (this.selectedID = question.question_id), comp, (collapsed.value = true)
      );
    },
    closeQuestionList() {
      return (collapsed.value = true);
    },
    toggleQuestionList() {
      return (collapsed.value = !collapsed.value);
    },
    showSurveyModal() {
      this.isSurveyModalVisible = true;
    },
    closeSurveyModal() {
      this.isSurveyModalVisible = false;
    },
  },
  setup() {
    return { componentsMap, collapsed };
  },
  data() {
    return {
      selectedID: 3,
      isSurveyModalVisible: false,
    };
  },
};
</script>

<style scoped>
.main {
  text-align: left;
  height: 100vh;
  overflow: hidden;
}
.title {
  margin-left: 5px;
  text-align: left;
  min-height: 1.5rem;
  margin-bottom: 0;
  height: 50px;
}
.sub-title {
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 50px;
}
.icon-wrapper {
  width: 36px;
  background-color: rgb(45, 145, 190, 0.2);
  color: white;
  border-radius: 5px;
  align-items: center;
  margin-left: 5px;
}
.compare {
  margin-right: 8px;
}
.collapse-icon {
  padding: 0.75em;
  color: #2d91be;
  transition: 0.2s linear;
  display: inline-block;
}
.rotate-180 {
  transform: rotate(180deg);
  transition: 0.2s linear;
}
.survey-content {
  width: 100%;
  display: flex;
}
.questions {
  width: 500px;
  border-right: solid 1px rgb(255, 255, 255);
  max-height: calc(100vh - 50px);
  overflow: scroll;

  transition: 0.5s;
  position: absolute;
  z-index: 1;
  background-color: rgb(255, 255, 255);
}
.questions.collapsed {
  width: 50px;
}
.question {
  width: 460px;
  min-height: 70px;
  margin-left: 5px;
  margin-right: 15px;
  margin-bottom: 10px;
  margin-top: 2px;
  padding: 0.5rem 1rem;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.25);
  border-radius: 5px;

  text-align: left;
  padding-left: 5px;

  display: flex;
  background-color: #2d91be;
  color: white;
}
.question.collapsed {
  width: 15px;
  text-align: center;
}
.question:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.25);
  background-color: #64aa73;
}
.question.active {
  background-color: #feaa3a;
  color: rgb(255, 255, 255);
}
.question-index-wrapper {
  min-width: 20px;
  margin: auto 0;
  text-align: center;
}
.question-text-wrapper {
  margin: auto 0;
  padding: 0 0.5rem;
}
.content-wrapper {
  width: 100%;
  margin-left: 3.5rem;
  margin-right: 8px;
  margin-top: 2px;
  z-index: 0;
}
.question-wrapper {
  background-color: rgb(255, 255, 255);
  z-index: 1;
  position: sticky;
  top: 0;
  padding-bottom: 10px;
}
.question-inner-wrapper {
  height: 86px;
  min-height: 1rem;
  padding: 8px 0.5rem;
  box-sizing: border-box;
  text-align: center;
  background-color: rgb(45, 145, 190, 0.3);
  border-radius: 5px;
  margin: auto 0;
  display: flex;
}
.answer-wrapper {
  box-sizing: border-box;
  height: calc(100vh - 50px - 106px);
  padding: 8px 0.5rem;
  overflow: scroll;
  background-color: rgb(45, 145, 190, 0.2);
  border-radius: 5px;
}
</style>