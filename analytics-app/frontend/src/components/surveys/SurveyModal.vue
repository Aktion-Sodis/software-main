<template>
  <div class="modal-backdrop">
    <div class="modal">
      <header class="modal-header">
        <div class="modal-header-wrapper">
          <h3 class="title-wrapper">Fragebogen für Vergleich auswählen:</h3>
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
        </div>
        <button type="button" class="btn-close" @click="close">x</button>
      </header>

      <section class="modal-body">
        <div class="surveys">
          <SurveyCard
            v-for="survey in filteredSurveys"
            :key="survey.id"
            :survey="survey"
            :class="{
              selected: selectedID === survey.survey_id,
            }"
            @click="setActive(survey)"
          />
        </div>
      </section>

      <footer class="modal-footer">
        <div class="modal-footer-wrapper">
          <el-button type="default" @click="close">Cancel</el-button>
          <el-button type="primary">Compare</el-button>
        </div>
      </footer>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import SurveyCard from "./SurveyCard.vue";

export default {
  name: "Modal",
  component: { SurveyCard },
  methods: {
    close() {
      this.$emit("close");
    },
    setActive(survey) {
      this.selectedID = survey.survey_id;
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
.modal-backdrop {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 99;
}
.modal {
  height: 85%;
  width: 92%;
  background: #ffffff;
  box-shadow: 2px 2px 20px 1px;
  overflow-x: auto;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 5px;
  position: relative;
  z-index: 100;
}
.modal-header,
.modal-footer {
  padding: 15px;
}
.modal-header {
  position: relative;
  border-bottom: 1px solid #eeeeee;
  color: #000000;
  justify-content: space-between;
}
.modal-header-wrapper {
  display: flex;
}
.title-wrapper {
  margin-top: 0.1rem;
}
.survey-datepicker {
  margin-left: 1rem;
}
.modal-footer {
  border-top: 1px solid #eeeeee;
}
.modal-footer-wrapper {
  display: flex;
  justify-content: flex-end;
}
.modal-body {
  height: 90%;
  position: relative;
  padding: 20px 10px;
  overflow: scroll;
}

.btn-close {
  position: absolute;
  top: 3px;
  right: 3px;
  border: none;
  font-size: 20px;
  padding: 10px;
  cursor: pointer;
  font-weight: bold;
  color: #2d91be;
  background: transparent;
}
</style>