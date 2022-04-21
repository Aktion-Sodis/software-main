<template>
  <div class="main">
      <div class="title">
        <h1 @click="print(selectedDates)">
            Fragebögen: Kochstellen
        </h1>
        <div class="datepicker-wrapper">
            <h3>
                Zeitraum wählen:
            </h3>
            <div class="survey-datepicker">
                <el-date-picker
                    v-model="selectedDates"
                    type="daterange"
                    range-separator="To"
                    start-placeholder="Start date"
                    end-placeholder="End date"
                />
            </div>
        </div>
      </div>
      <div class="surveys">
          <SurveyCard 
            v-for="survey in filteredSurveys"
            :key="survey.id"
            :survey="survey"
          />
      </div>
  </div>
</template>

<script>
import SurveyCard from '../components/surveys/SurveyCard.vue'
export default {
    props: {},
    components: { SurveyCard },
    methods: {
        adjustDate(date) {
            let timezoneOffset = date.getTimezoneOffset();
            let adjustedDate = date.getTime() + timezoneOffset * 60000
            return adjustedDate
        },
    },
    computed: {
        filteredSurveys: function() {
            console.log(this.selectedDates)
            if (this.selectedDates) {
                let selectedDate0 = this.selectedDates[0]?.getTime()
                let selectedDate1 = this.selectedDates[1]?.getTime()
                return this.surveys.filter(function (survey) {
                    let surveyDate = new Date(survey.date)
                    let timezoneOffset = surveyDate.getTimezoneOffset();
                    let adjustedDate = surveyDate.getTime() + timezoneOffset * 60000
                    return selectedDate0 <= adjustedDate && adjustedDate <= selectedDate1;
                });
            } else {
                return this.surveys
            }
        }
    },
    data() {
        return {
            selectedDates: '',
            surveys: [
                {
                    survey_id: '1',
                    date: '2022-04-18',
                    title: 'Family 1',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 1 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '2',
                    date: '2022-04-19',
                    title: 'Family 2',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 2 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-20',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-21',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-23',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-24',
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
    margin-left: 30px;
    text-align: left;
}

.title {
    margin-left: 5px;
}

.datepicker-wrapper {
    display: flex;
    flex-wrap: wrap;
}

.survey-datepicker {
    margin-left: 10px;
    margin-top: 16px;
}

.surveys {
    display: flex;
    flex-wrap: wrap;
    margin-top: 20px;
    height: auto;  
}

</style>