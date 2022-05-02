<template>
  <div class="main">
    <div class="title">
      <h1 style="text-align: left; margin-left: 5px">
        Fragebogen: Kochstellen
      </h1>
    </div>
    <div class="sub-title">
      <div @click="toggleQuestionList">
        <span class="collapse-icon" :class="{ 'rotate-180': collapsed }">
          <i class="fas fa-angle-double-left" />
        </span>
      </div>
      <el-button class="compare">Mehrere vergleichen</el-button>
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
            <h3 style="text-align: left">
              {{ selectedQuestion.question_text }}
            </h3>
          </div>
        </div>
        <component
          class="answer-wrapper"
          :is="componentsMap[selectedQuestion.question_type]"
          :selectedQuestion="selectedQuestion"
        />
      </div>
    </div>
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

const componentsMap = {
  initial: initialComponent,
  text: textComponent,
  image: imageComponent,
  chart: chartComponent,
};

const collapsed = ref(true);

export default {
  props: {},
  components: {},
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
  },
  setup() {
    return { componentsMap, collapsed };
  },
  data() {
    return {
      selectedID: 3,
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
  min-height: 1.5rem;
  margin-bottom: 1rem;
  margin-top: 1rem;
}
.sub-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.compare {
  margin-right: 0.5rem;
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
  height: 100%;
  width: 100%;
  display: flex;
  position: relative;
}
.questions {
  width: 500px;
  border-right: solid 1px rgb(255, 255, 255);
  height: 90vh;
  overflow: scroll;

  transition: 0.5s;
  position: fixed;
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
  height: 90vh;
  margin-left: 3.5rem;
  margin-right: 0.5rem;
  margin-top: 2px;
  z-index: 0;
}
.question-wrapper {
  background-color: rgb(255, 255, 255);
  z-index: 1;
  position: sticky;
  top: 0;
  padding-bottom: 1rem;
}
.question-inner-wrapper {
  min-height: 1rem;
  padding: 1rem 1rem;
  border: 3px solid #2d91be;
  border-radius: 5px;
}
.answer-wrapper {
  height: 70vh;
  padding: 1rem;
  border: 3px solid #2d91be;
  border-radius: 5px;
  overflow: scroll;
}
</style>