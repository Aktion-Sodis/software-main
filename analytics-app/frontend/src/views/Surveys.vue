<template>
  <div class="main">
    <div class="content">
      <el-row class="title">
        <el-col>
          <h1 style="margin-left: 5px">Fragebögen: Kochstellen</h1>
        </el-col>
      </el-row>
      <el-row class="datepicker-wrapper">
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
              value-format="YYYY-MM-DD"
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
              @click="selectSurvey(survey)"
            />
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { router } from "../router";
import SurveyCard from "../components/surveys/SurveyCard.vue";

export default {
  props: {},
  components: { SurveyCard },
  methods: {
    selectSurvey(survey) {
      this.selectedID = survey.survey_id;
      router.push({
        name: "Questions",
        params: { survey_id: survey.survey_id },
      });
      return;
    },
  },
  computed: {
    ...mapState({
      surveys: (state) => state.surveyData.surveys,
    }),
    filteredSurveys: function () {
      if (!this.selectedDates) return this.surveys;
      console.log(this.selectedDates);
      let startDate = new Date(this.selectedDates[0]).getTime();
      let endDate = new Date(this.selectedDates[1]).getTime();
      return this.surveys.filter(function (survey) {
        let surveyDate = new Date(survey.date).getTime();
        return startDate <= surveyDate && surveyDate <= endDate;
      });
    },
  },
  data() {
    return {
      selectedID: null,
      selectedDates: null,
    };
  },
};
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
  margin-bottom: 1rem;
  margin-top: 1rem;
}
.datepicker-wrapper {
  margin: 1rem 0;
  position: sticky;
  top: 0;
  background-color: rgb(255, 255, 255);
  z-index: 1;
  padding: 1rem 0;
}
.survey-datepicker {
  margin-left: 1rem;
}
.surveys {
  display: flex;
  flex-wrap: wrap;
  height: auto;
}
</style>