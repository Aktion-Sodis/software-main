<template>
  <div class="main">
      <section class="header">
          <el-row>
              <el-col>
                  <h1 style="text-align: left">
                      Fragebögen: Kochstellen
                  </h1>
              </el-col>
          </el-row>
          <el-row>
            <el-col :span="4">
                <h3 style="text-align: left; margin: 0; position: absolute; top: 50%;">
                    Zeitraum wählen:
                </h3>
            </el-col>
            <el-col :span="12">
                <div class="survey-datepicker" style="margin: 0; position: absolute; top: 50%;">
                    <el-date-picker
                        v-model="value1"
                        type="daterange"
                        range-separator="To"
                        start-placeholder="Start date"
                        end-placeholder="End date"
                    />
                </div>
            </el-col>
          </el-row>
      </section>
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
    overflow: hidden;
}

.header {
    height: 20vh;
}

.surveys {
    display: flex;
    flex-wrap: wrap;
    margin-top: 5px;
}

</style>