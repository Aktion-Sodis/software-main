<template>
  <div class="main">
      <div class="content">
        <el-row class="title">
            <el-col>
            <h1 style="margin-left: 5px">Fragebögen: Kochstellen</h1>
            </el-col>
        </el-row>
        <el-row class="sub-title">
            <el-col :span="4">
                <h3 style="margin-left: 5px">Zeitraum wählen:</h3>
            </el-col>
            <el-col :span="20">
                <div class="survey-datepicker">
                    <el-date-picker
                        v-model="selectedDates"
                        type="daterange"
                        range-separator="To"
                        start-placeholder="Start date"
                        end-placeholder="End date"
                    />
                </div>
            </el-col>
        </el-row>
        <el-row class="survey-wrapper">
            <el-col>
            <div class="surveys">
                <SurveyCard 
                    v-for="survey in filteredSurveys"
                    :key="survey.id"
                    :survey="survey"
                />
            </div>
            </el-col>
        </el-row>
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
                    technology: 'Kitchen',
                    text: 'Hier kann eine Beschreibung zu Umfrage 1 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '2',
                    date: '2022-04-19',
                    title: 'Family 2',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 2 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-20',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-21',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-23',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-24',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-23',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-24',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-23',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-24',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-23',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-24',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
                {
                    survey_id: '3',
                    date: '2022-04-22',
                    title: 'Umfrage 3',
                    village: 'Micani',
                    technology: 'Toilet',
                    text: 'Hier kann eine Beschreibung zu Umfrage 3 stehen',
                    src: 'src/static/aktionSodisBig.png',
                },
            ]
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
.content {
    height: 100vh;
    overflow: scroll;
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
    position: sticky;
    top: 0;
    background-color: rgb(255, 255, 255);
    z-index: 1;
    padding-bottom: 0.5rem;
    padding-top: 0.5rem;
}
.datepicker-wrapper {
    display: flex;
    flex-wrap: wrap;
}
.survey-datepicker {
    margin-left: 1rem;
}

.surveys {
    display: flex;
    flex-wrap: wrap;
    margin-top: 1rem;
    height: auto;  
}
</style>