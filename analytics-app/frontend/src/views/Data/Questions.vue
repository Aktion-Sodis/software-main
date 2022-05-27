<template>
  <div class="container">
    <div class="return-wrapper">
      <el-button class="sodis return"
        ><i class="fa-solid fa-arrow-left"></i
      ></el-button>
    </div>
    <div class="header">Technologie - Fragebogen</div>
    <div class="button-wrapper">
      <el-button class="sodis download"
        ><i class="fa-solid fa-filter"></i
      ></el-button>
      <el-button class="sodis download"
        ><i class="fa-solid fa-download"></i
      ></el-button>
    </div>
    <div class="side">
      <div
        class="icon-wrapper"
        @click="toggleQuestionList"
        @mouseover="showInfo()"
        @mouseleave="hideInfo()"
      >
        <span class="collapse-icon" :class="{ 'rotate-180': collapsed }">
          <i class="fas fa-angle-double-left" />
        </span>
        <div>
          <span
            class="collapse-info"
            :class="{ collapseInfo: collapseInfo }"
            v-if="collapsed"
            >Press to show questions</span
          >
          <span
            class="collapse-info"
            :class="{ collapseInfo: collapseInfo }"
            v-else
            >Press to hide Questions</span
          >
        </div>
      </div>
      <div class="surveys">
        <div class="survey-wrapper" v-for="survey in surveys" :key="survey.id">
          <div class="survey-name-wrapper">
            <div class="survey-placeholder">
              <i class="sodis-icon fa-solid fa-bars-staggered"></i>
            </div>
            <div class="survey-name" :class="{ collapsed: collapsed }">
              {{ survey.survey_name }}
            </div>
          </div>
          <div class="questions">
            <div
              class="question"
              :class="{
                collapsed: collapsed,
                active: selectedID === question.question_id,
              }"
              v-for="(question, index) in survey.questions"
              :key="question.id"
              @click="setActive(question)"
            >
              <div class="index-wrapper">{{ index + 1 }}</div>
              <div class="question-wrapper" :class="{ collapsed: collapsed }">
                {{ question.question_text }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="content-header-wrapper">
      <div class="content-header">{{ selectedQuestion.question_text }}</div>
    </div>
    <div class="main">
      <ChartComponentPlotly></ChartComponentPlotly>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import "element-plus/theme-chalk/display.css";

import ChartComponentPlotly from "../../components/data/ChartComponentPlotly.vue";
import ImageComponent from "../../components/data/ImageComponent.vue";

var collapsed = ref(true);
var collapseInfo = ref(true);

export default {
  components: { ChartComponentPlotly, ImageComponent },
  setup() {
    return { collapsed, collapseInfo };
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
    showInfo() {
      return (collapseInfo.value = false);
    },
    hideInfo() {
      return (collapseInfo.value = true);
    },
  },
  data() {
    return {
      selectedID: 1,
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
      ],
      surveys: [
        {
          survey_id: 1,
          survey_name: "Umfrage 1",
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
        },
        {
          survey_id: 2,
          survey_name: "Umfrage 2",
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
        },
      ],
    };
  },
};
</script>

<style>
:root {
  --container-margin: 25px;
}
</style>

<style scoped>
.container {
  box-sizing: border-box;
  margin-left: var(--container-margin);
  margin-right: var(--container-margin);
  margin-bottom: var(--container-margin);
  height: calc(100vh - var(--navbar-height) - 1 * var(--container-margin));

  display: grid;
  grid-template-rows: 60px 50px calc(
      100vh - var(--navbar-height) - var(--container-margin) - 60px - 50px
    );
  grid-template-columns:
    60px calc(
      100vw - var(--left-menu-width) - var(--container-margin) * 2 - 60px -
        200px
    )
    200px;

  grid-template-areas:
    "return header buttons"
    "side question-text question-text"
    "side main main";
}

.return-wrapper {
  grid-area: return;
  justify-self: start;
  border: none;
  margin: auto 0;
}
.sodis {
  background-color: var(--bg-color);
  color: white;
}
.sodis-icon {
  color: var(--bg-color);
}
.return {
  width: 50px;
}
.header {
  grid-area: header;
  margin: auto 0;
  text-align: left;
  font-size: 20px;
}

.side {
  grid-area: side;
  background-color: white;
}

.main {
  grid-area: main;
  background-color: rgb(255, 255, 255);
  overflow-x: hidden;
  overflow-y: scroll;
}

.content-header-wrapper {
  grid-area: question-text;
  background-color: white;
  z-index: 0;
}

.button-wrapper {
  grid-area: buttons;
  justify-self: end;
  margin: auto 0;
}

.download {
  width: 50px;
}

/* Question Text */

.content-header {
  margin-top: 12px;
  text-align: left;
  font-size: 20px;
  z-index: 0;
}

/* Main */

/* Sidebar */

.icon-wrapper {
  display: flex;
  align-items: center;
  flex-direction: row;
  box-sizing: border-box;
  height: 50px;
  width: 20px;
  margin: auto;
}
.collapse-icon {
  color: var(--bg-color);
  transition: var(--transition-time);
  display: inline-block;
}
.rotate-180 {
  color: var(--bg-color);
  transform: rotate(180deg);
}
.collapse-info {
  display: block;
  float: right;
  width: 200px;

  background-color: white;
  border: 0.5px solid grey;
  border-radius: 5px;

  margin-left: 10px;
  z-index: 1;
  position: absolute;
}
.collapse-info.collapseInfo {
  display: none;
}
.surveys {
  border-right: 2px solid var(--bg-color);
  overflow-y: scroll;
  overflow-x: hidden;

  position: absolute;
  left: calc(var(--left-menu-width) + var(--container-margin));
  top: calc(var(--navbar-height) + 60px + 50px);
  bottom: var(--container-margin);
  z-index: 1;

  background-color: white;

  direction: rtl;
}
.survey-name-wrapper {
  height: 40px;
  display: flex;
  flex-direction: row;
  align-items: center;

  direction: ltr;
}

.survey-placeholder {
  padding-left: 20px;
}

.survey-name {
  text-align: left;
  padding-left: 13px;
}
.survey-name.collapsed {
  display: none;
}

.questions {
  box-sizing: border-box;
  overflow-y: scroll;
  overflow-x: hidden;

  transition: var(--transition-time);
}

.question {
  box-sizing: border-box;
  max-width: 450px;
  min-height: 80px;
  margin-left: 2px;
  margin-right: 2px;
  margin-bottom: 2px;
  margin-top: 2px;
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
