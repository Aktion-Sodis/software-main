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
        <div v-if="compare" class="compare">
          <el-button-group class="ml-4">
            <el-button type="primary">Vergleichen</el-button>
            <el-button type="primary" @click="resetSelectedIDs"
              >Zurücksetzen</el-button
            >
            <el-button type="danger" @click="stopCompare">
              <i class="fa-solid fa-xmark"></i
            ></el-button>
          </el-button-group>
        </div>
        <div v-else class="compare">
          <el-button @click="startCompare">Mehrere vergleichen</el-button>
        </div>
      </div>
    </div>
    <div class="surveys">
      <SurveyCard
        v-for="survey in filteredSurveys"
        :key="survey.id"
        :survey="survey"
        :class="{
          selected:
            selectedID0 === survey.survey_id ||
            selectedID1 === survey.survey_id,
        }"
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
      if (!this.compare) {
        router.push({
          name: "Questions",
          params: { survey_id: survey.survey_id },
        });
        return;
      }
      //check if id is already in selected array
      if (this.selectedIDs.includes(survey.survey_id)) {
        console.log("DUPLIKAT: Noch nicht implementiert");
        return;
      }
      //check if there are already two ids in selected, ids
      if (this.selectedIDs.length > 1) {
        console.log("LÄNGE: Noch nicht implementiert");
        return;
      }
      this.selectedIDs.push(survey.survey_id);
      console.log(this.selectedIDs);
      this.selectedID0 = this.selectedIDs[0] || null;
      this.selectedID1 = this.selectedIDs[1] || null;
      console.log(this.selectedID0);
      console.log(this.selectedID1);
      return;
    },
    resetSelectedIDs() {
      this.selectedIDs = [];
      this.selectedID0 = null;
      this.selectedID1 = null;
    },
    stopCompare() {
      this.resetSelectedIDs();
      return (this.compare = false);
    },
    startCompare() {
      return (this.compare = true);
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
      selectedIDs: [],
      selectedDates: null,
      compare: false,
      selectedID0: null,
      selectedID1: null,
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
  padding-left: 3px;
  width: 100%;
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