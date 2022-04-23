<template>
  <div class="main">
      <el-row class="title">
          <el-col>
            <h1 style="text-align: left; margin-left: 5px" >Fragebogen: Kochstellen</h1>
          </el-col>
      </el-row>
      <el-row class="sub-title">
          <el-col :span="6" >
            <h2 style="text-align: left; margin-left: 5px">Fragen:</h2>
          </el-col>
          <el-col :span="18">
            <h2 style="text-align: left">Antwort:</h2>
          </el-col>
      </el-row>
      <el-row class="survey-content">
          <el-col :span="6" class="question-list">
            <div class="questions">
                <div 
                    v-for="question in questions" 
                    :key="question.id" 
                    class="question"
                    :class="{ 'active': selectedID === question.question_id }"
                    @click="setActive(question)"> 
                        {{ question.question_text }}
                </div>
            </div>
          </el-col>
          <el-col :span="18">
            <div class="answer-wrapper">
                <h3 style="text-align: left">
                    Ausgewählte Frage: {{ selectedQuestion.question_text }}
                </h3>
                <h3 style="text-align: left">
                    Antwort: {{ selectedQuestion.answer }}
                </h3>
            </div>
          </el-col>
      </el-row>
    </div>
</template>

<script>
import 'element-plus/theme-chalk/display.css'
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
            return this.selectedID = question.question_id
        },
    },
    data() {
        return {
            selectedID: 0,
            questions: [
                {
                    question_id: 1,
                    question_text: "Wie geht's?",
                    answer: 'gut',
                },
                {
                    question_id: "2abs",
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: 3,
                    question_text: "Machst du viel Sport?",
                    answer: 'Nein',
                },
                {
                    question_id: 4,
                    question_text: "Kannst du schwimmen?",
                    answer: 'Nein',
                },
                {
                    question_id: 5,
                    question_text: "Kannst du kochen?",
                    answer: 'Nein',
                },
                {
                    question_id: 6,
                    question_text: "Wie geht's?",
                    answer: 'gut',
                },
                {
                    question_id: "2abs",
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: 7,
                    question_text: "Machst du viel Sport?",
                    answer: 'Nein',
                },
                {
                    question_id: 8,
                    question_text: "Kannst du schwimmen?",
                    answer: 'Nein',
                },
                {
                    question_id: 9,
                    question_text: "Kannst du kochen?",
                    answer: 'Nein',
                },
                {
                    question_id: 10,
                    question_text: "Wie geht's?",
                    answer: 'gut',
                },
                {
                    question_id: "11",
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: 12,
                    question_text: "Machst du viel Sport?",
                    answer: 'Nein',
                },
                {
                    question_id: 13,
                    question_text: "Kannst du schwimmen?",
                    answer: 'Nein',
                },
                {
                    question_id: 14,
                    question_text: "Kannst du kochen?",
                    answer: 'Nein',
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
.question-list {
    display: flex;
    flex-direction: row;
}
.questions {
    border-right-style: solid;
    height: 75vh;
    overflow: scroll;
}
.question {
  width: 200px;
  margin-left: 5px;
  margin-right: 15px;
  margin-bottom: 10px;
  margin-top: 2px;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.25); 

  text-align: left;
  padding-left: 5px;
}
.question:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.25); 
}
.question.active {
  background-color: rgb(215, 215, 215);
}
</style>