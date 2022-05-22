<template>
  <div class="wrapper" @click="printQuestions">
    <div class="content">
      <div class="question-menu">
        <div class="icon-wrapper" @click="toggleQuestionList">
          <span class="collapse-icon" :class="{ 'rotate-180': collapsed }">
            <i class="fas fa-angle-double-left" />
          </span>
        </div>
        <div class="questions">
          <div
            class="question"
            :class="{
              collapsed: collapsed,
              active: selectedID === question.question_id,
            }"
            v-for="(question, index) in questions"
            :key="question.id"
            @click="setActive(question)"
          >
            <div class="index-wrapper">{{ index }}</div>
            <div class="question-wrapper" :class="{ collapsed: collapsed }">
              {{ question.question_text }}
            </div>
          </div>
        </div>
      </div>

      <div class="content-wrapper">
        <div class="description-wrapper">
          Technologie - Fragebogen -
          {{ selectedQuestion.question_text }}
        </div>
        <div class="content-container">Test</div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import "element-plus/theme-chalk/display.css";
import ChartComponent from "../../components/data/ChartComponent.vue";

const collapsed = ref(true);

export default {
  props: {},
  components: { ChartComponent },
  setup() {
    return { collapsed };
  },
  computed: {
    selectedQuestion() {
      return (
        this.questions.find((item) => item.question_id === this.selectedID) || 0
      );
    },
  },
  methods: {
    setActive(question) {
      return (this.selectedID = question.question_id), (collapsed.value = true);
    },
    toggleQuestionList() {
      console.log("collapsed");
      console.log(collapsed);
      return (collapsed.value = !collapsed.value);
    },
  },
  data() {
    return {
      selectedID: 3,
      isSurveyModalVisible: false,
      questions: [
        {
          question_id: 1,
          question_text: "Wie geht's?",
          question_answer: "gut",
          question_type: "image",
        },
        {
          question_id: "2abs",
          question_text:
            "natoque penatibus et magnis dis p natoque penatibus et magnis dis",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 3,
          question_text: "Machst du viel Sport?",
          question_answer: "Nein",
          question_type: "chart",
        },
        {
          question_id: 4,
          question_text: "Kannst du schwimmen?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 5,
          question_text: "Kannst du kochen?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 6,
          question_text: "Wie geht's?",
          question_answer: "gut",
          question_type: "text",
        },
        {
          question_id: "2abs",
          question_text: "Trinkst du ausreichend Wasser?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 7,
          question_text: "Machst du viel Sport?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 8,
          question_text: "Kannst du schwimmen?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 9,
          question_text: "Kannst du kochen?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 10,
          question_text: "Wie geht's?",
          question_answer: "gut",
          question_type: "text",
        },
        {
          question_id: "11",
          question_text: "Trinkst du ausreichend Wasser?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 12,
          question_text: "Machst du viel Sport?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 13,
          question_text: "Kannst du schwimmen?",
          question_answer: "Nein",
          question_type: "text",
        },
        {
          question_id: 14,
          question_text: "Kannst du kochen?",
          question_answer: "Nein",
          question_type: "text",
        },
      ],
    };
  },
};
</script>

<style>
:root {
  --transition-time: 0.3s;
  --bg-color-content: rgb(255, 255, 255);
}
</style>

<style scoped>
.wrapper {
  height: 500px;
  background-color: var(--bg-color-content);
  height: calc(100vh - 90px);
}
.content {
  display: flex;
}

.icon-wrapper {
  width: 20px;
}
.question-menu {
  display: flex;
  flex-direction: column;
}
.title {
  background-color: var(--bg-color-content);
  padding: 0 10px;
  margin-left: 5px;
  height: 40px;
  display: flex;
  align-items: center;
}
.questions {
  box-sizing: border-box;
  margin-top: 30px;
  width: fit-content;
  overflow-y: scroll;
  overflow-x: hidden;
  height: calc(100vh - 120px);

  transition: var(--transition-time);

  z-index: 1;
  position: absolute;

  background-color: var(--bg-color-content);

  direction: rtl;
}
.question {
  box-sizing: border-box;
  max-width: 450px;
  min-height: 80px;
  margin-left: 5px;
  margin-right: 0;
  margin-bottom: 5px;
  margin-top: 0;
  padding: 0.5rem 1rem;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.25);
  border-radius: 5px;

  text-align: left;
  padding-left: 5px;

  display: flex;
  background-color: #2d91be;
  color: white;
  transition: var(--transition-time);

  direction: ltr;
}
.question.active {
  background-color: #feaa3a;
  color: rgb(255, 255, 255);
}
.question.collapsed {
  width: 40px;
}
.index-wrapper {
  min-width: 20px;
  margin: auto 5px;
  text-align: center;
}
.question-wrapper {
  margin: auto 0;
  padding: 0 0.5rem;
  transition: 0s linear var(--transition-time);
  opacity: 1;
}
.question-wrapper.collapsed {
  opacity: 0;
  transition: 0s;
  display: none;
}
.collapse-icon {
  color: var(--bg-color);
  transition: var(--transition-time);
  display: inline-block;
  margin-left: 24px;
  margin-top: 5px;
  box-sizing: border-box;
}
.rotate-180 {
  color: var(--bg-color);
  transform: rotate(180deg);
}
.content-wrapper {
  margin-top: 3px;
  background-color: var(--bg-color-content);
  margin-left: 50px;
  width: 100%;
}
.description-wrapper {
  font-size: 20px;
  text-align: left;
}
.content-container {
  width: calc(100vw - var(--left-menu-width) - 100px);
  height: calc(100vh - var(--navbar-height) - 60px);
}

/* Designing for scroll-bar */
::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: rgb(255, 255, 255);
  border-radius: 0px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: var(--bg-color);
  border-radius: 1px;
}
</style>
