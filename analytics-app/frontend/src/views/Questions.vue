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
                <Question 
                    v-for="question in questions"
                    :key="question.id"
                    :question="question"
                />
            </div>
        </div>
        <div class="answer-wrapper">
            <h2 style="text-align: left">
                Antwort:
            </h2>
            <h3 style="text-align: left">
                Ausgewählte Frage:
            </h3>
        </div>
      </div>
  </div>
</template>

<script>
import Question from '../components/surveys/Question.vue'
export default {
    props: {},
    components: { Question },
    data() {
        return {
            questions: [
                {
                    question_id: '1',
                    question_text: "Wie geht's?",
                    answer: 'gut',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
                {
                    question_id: '1',
                    question_text: "Trinkst du ausreichend Wasser?",
                    answer: 'Nein',
                },
            ]
        }
    }
}
</script>

<style>

.main {
    margin-left: 30px;
}

.question-list {
    display: flex;
    flex-direction: row;
}

.inner-question-list {
}

.questions {
    display: flex;
    flex-direction: column;
    margin-top: 20px;
    border-right-style: solid;
    overflow: auto;
    max-height: 75vh;
}

.answer-wrapper {
    margin-left: 50px;
}

.answer {
    margin-left: 20px;
}

</style>