<template>
  <div class="main">
      <div class="title">
        <h1 style="text-align: left" >
            Fragebogen: Kochstellen
        </h1>
      </div>
      <div class = "question-list">
        <div class="inner-question-list">
            <h2 style="text-align: left; margin-left: 5px">
                Fragen:
            </h2>
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
        </div>
        <div class="answer-wrapper">
            <h2 style="text-align: left">
                Antwort:
            </h2>
            <h3 style="text-align: left">
                Ausgewählte Frage: {{ selectedQuestion.question_text }}
            </h3>
            <h3 style="text-align: left">
                Antwort: {{ selectedQuestion.answer }}
            </h3>
        </div>
      </div>
  </div>
</template>

<script>
import internal from 'stream';
import { ref, reactive } from 'vue'

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
            ],
        }
    }
}
</script>

<style scoped>

.main {
    text-align: left;
}

.title {
    margin-left: 5px;
}

.question-list {
    display: flex;
    flex-direction: row;
}

.questions {
    display: flex;
    flex-direction: column;
    margin-top: 20px;
    border-right-style: solid;
    overflow: auto;
    max-height: 75vh;
}

.question {
  width: 200px;
  margin-left: 5px;
  margin-right: 15px;
  margin-bottom: 10px;
  margin-top: 10px;
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

.answer-wrapper {
    margin-left: 50px;
}

.answer {
    margin-left: 20px;
}

</style>