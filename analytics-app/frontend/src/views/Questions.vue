<template>
  <div class="main">
      <div class="title">
        <h1 style="text-align: left; margin-left: 5px" >Fragebogen: Kochstellen</h1>
      </div>
      <div class="survey-content">
        <div class="question-list">
            <div class="questions" :class="{'collapsed': collapsed}" @mouseover="openQuestionList" @mouseleave="closeQuestionList">
                <div 
                    v-for="(question, index) in questions" 
                    :key="question.id" 
                    class="question"
                    :class="{ 'active': selectedID === question.question_id, 'collapsed': collapsed }"
                    @click="setActive(question) "> 
                    <div class="question-index-wrapper">
                        {{index+1}}
                    </div>
                    <div v-if="!collapsed" class="question-text-wrapper"> {{ question.question_text }} </div>
                </div>
            </div>
        </div>
        <div class="content-wrapper">
            <div class="question-wrapper">
                <h3 style="text-align: left">
                    {{ selectedQuestion.question_text }}
                </h3>
            </div>
        <component class="answer-wrapper" :is='componentsMap[selectedQuestion.question_type]' :selectedQuestion="selectedQuestion" />
        </div>
      </div>
    </div>
</template>

<script>
import { ref } from 'vue'
import 'element-plus/theme-chalk/display.css'
import initialComponent from '../components/evaluation/initialComponent.vue'
import textComponent from '../components/evaluation/textComponent.vue'
import imageComponent from '../components/evaluation/imageComponent.vue'

const componentsMap = {
  "initial": initialComponent,
  "text": textComponent, 
  "image": imageComponent,
}

const collapsed = ref(false)

export default {
    props: {},
    components: {},
    computed: {
        selectedQuestion() {
            return this.questions.find(item => item.question_id === this.selectedID) || 0
        },
    },
    methods: {
        setActive(question) {
            const comp = componentsMap[question.question_type]
            return this.selectedID = question.question_id, comp
        },
        openQuestionList() {
            return collapsed.value = false
        },
        closeQuestionList() {
            return collapsed.value = true
        }
    },
    setup() {
        return { componentsMap, collapsed }
    },
    data() {
        return {
            selectedID: 0,
            questions: [
                {
                    question_id: 1,
                    question_text: "Wie geht's?",
                    question_answer: 'gut',
                    question_type: 'image',
                },
                {
                    question_id: "2abs",
                    question_text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis p",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 3,
                    question_text: "Machst du viel Sport?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 4,
                    question_text: "Kannst du schwimmen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 5,
                    question_text: "Kannst du kochen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 6,
                    question_text: "Wie geht's?",
                    question_answer: 'gut',
                    question_type: 'text',
                },
                {
                    question_id: "2abs",
                    question_text: "Trinkst du ausreichend Wasser?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 7,
                    question_text: "Machst du viel Sport?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 8,
                    question_text: "Kannst du schwimmen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 9,
                    question_text: "Kannst du kochen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 10,
                    question_text: "Wie geht's?",
                    question_answer: 'gut',
                    question_type: 'text',
                },
                {
                    question_id: "11",
                    question_text: "Trinkst du ausreichend Wasser?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 12,
                    question_text: "Machst du viel Sport?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 13,
                    question_text: "Kannst du schwimmen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
                {
                    question_id: 14,
                    question_text: "Kannst du kochen?",
                    question_answer: 'Nein',
                    question_type: 'text',
                },
            ],
        }
    }
}
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
    min-height: 1.5rem;
    margin-bottom: 1rem;
    margin-top: 1rem;
}
.survey-content {
    height: 100%;
    width: 100%;
    display: flex;
}
.questions {
    width: 500px;
    border-right-style: solid;
    height: 90vh;
    overflow: scroll;

    transition: 0.5s;
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
  background-color: #2D91BE;
  color: white;
}
.question.collapsed {
  width: 15px;
  text-align: center;
}
.question:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.25); 
  background-color: #64AA73;
}
.question.active {
  background-color: #FEAA3A;
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
    margin: 0 1rem;
    overflow: scroll;
    height: 90vh;
    margin-top: 2px;
}
.question-wrapper {
    margin-bottom: 1rem;
    min-height: 1rem;
    padding: 1rem 1rem;
    border: 3px solid #2D91BE;
    border-radius: 5px;
    background-color: rgb(255, 255, 255);
    z-index: 1;
    position: sticky;
    top: 0;
}
.answer-wrapper {
    margin-top: 1rem;
    min-height: 40px;
    padding: 1rem;
    border: 3px solid #2D91BE;
    border-radius: 5px;
}
</style>