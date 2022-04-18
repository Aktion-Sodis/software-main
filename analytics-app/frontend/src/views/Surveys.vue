<template>
  <div class="main">
      <section class="surveys">
          <SurveyCard 
            v-for="survey in surveys"
            :key="survey.id"
            :survey="survey"
          />
      </section>
  </div>
</template>

<script>
import SurveyCard from '../components/surveys/SurveyCard.vue'
export default {
    props: {},
    components: { SurveyCard },
    data() {
        return {
            surveys: [
                {
                    survey_id: '1',
                    date: '18.04.2022',
                    title: 'Family 1',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 1 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '2',
                    date: '19.04.2022',
                    title: 'Family 2',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 2 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '20.04.2022',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '20.04.2022',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '20.04.2022',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '20.04.2022',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '20.04.2022',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
            ]
        }
    }
}
</script>

<style>

.main {
    margin-left: 20px;
}

.surveys {
    display: flex;
    flex-wrap: wrap;
}

</style>