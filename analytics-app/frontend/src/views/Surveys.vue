<template>
  <div class="main">
    <div class="title">
      <h1>Fragebögen: Kochstellen</h1>
      <div class="filter-wrapper">
        <span class="datepicker-description">Zeitraum wählen:</span>
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
        <el-button class="compare" @click="showSurveyModal"
          >Mehrere vergleichen</el-button
        >
      </div>
    </div>
    <div class="surveys">
      <SurveyCard
        v-for="survey in filteredSurveys"
        :key="survey.id"
        :survey="survey"
        @click="selectSurvey(survey)"
      />
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
}
.title {
  box-sizing: border-box;
  padding-top: 5px;
  padding-left: 5px;
  width: 95%;
  height: 50px;
  background-color: rgb(255, 255, 255);
  z-index: 1;
  position: sticky;
  top: 0;

  display: flex;
  justify-content: space-between;
}
.filter-wrapper {
  display: flex;
  padding-top: 5px;
}
.datepicker-description {
  padding-top: 4px;
  padding-right: 10px;
}
.surveys {
  display: flex;
  flex-wrap: wrap;
  height: auto;
  align-content: flex-start;
  justify-content: flex-start;
  overflow: scroll;
  margin-bottom: 10px;
}
.compare {
  margin-right: 8px;
  margin-left: 8px;
}
</style>