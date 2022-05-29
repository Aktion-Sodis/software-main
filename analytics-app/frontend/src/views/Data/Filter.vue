<template>
  <div class="container">
    <div class="return-wrapper">
      <el-button class="sodis return"
        ><i class="fa-solid fa-arrow-left"></i
      ></el-button>
    </div>
    <div class="header">Technologie - Fragebogen</div>
    <div class="continue-wrapper">
      <el-button-group class="ml-4">
        <el-button
          class="sodis"
          :disabled="!this.continue"
          @click="resetSelection"
        >
          Reset
        </el-button>
        <el-button class="sodis return" :disabled="!this.continue">
          <i class="fa-solid fa-arrow-right"></i
        ></el-button>
      </el-button-group>
    </div>

    <div class="filter">
      <div class="filter-wrapper">
        <div class="filter-description">Filtern nach:</div>
        <div
          class="tag"
          :class="{ selected: tag === selectedTag }"
          v-for="tag in uniqueInterventionTypes(interventions)"
          :key="tag"
          @click="setActive(tag)"
        >
          {{ tag }}
        </div>
      </div>
      <div class="intervention-wrapper">
        <div class="intervention-description" v-if="selectedTag">
          {{ selectedTag }} wählen:
        </div>
        <div
          class="intervention"
          :class="{
            selected: intervention.id === selectedIntervention.id,
          }"
          v-for="intervention in getEntitiesByTag(selectedTag, interventions)"
          :key="intervention.id"
          @click="setIntervention(intervention)"
        >
          {{ intervention.name }}
        </div>
      </div>
    </div>
    <div class="main">
      <div class="survey-wrapper">
        <SurveyCard
          v-for="survey in selectedIntervention.surveys"
          :key="survey.id"
          :survey="survey"
          :class="{ selected: surveySelected(survey) }"
          @click="selectSurvey(survey)"
        >
        </SurveyCard>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import "element-plus/theme-chalk/display.css";

import SurveyCard from "../../components/commons/SurveyCard.vue";

export default {
  components: { SurveyCard },
  methods: {
    uniqueInterventionTypes(interventions) {
      var uniqueTags = interventions
        .map((item) => item.tag)
        .filter((value, index, self) => self.indexOf(value) === index);
      return uniqueTags;
    },
    getEntitiesByTag(tag, interventions) {
      var entitiesByTag = interventions.filter((item) => {
        return item.tag === tag;
      });
      return entitiesByTag;
    },
    setActive(tag) {
      this.selectedTag = tag;
      this.selectedIntervention = "";
      return this.selectedTag, this.selectedIntervention;
    },
    setIntervention(intervention) {
      this.selectedIntervention = intervention;
      this.selectedSurveys = [];
      return this.selectedIntervention;
    },
    selectSurvey(survey) {
      //check if id is already in selected array
      if (this.selectedSurveys.includes(survey.id)) {
        console.log("DUPLIKAT: Noch nicht implementiert");
        return;
      }

      this.selectedSurveys.push(survey.id);
      console.log(this.selectedSurveys);
      this.continue = true;
      return;
    },
    surveySelected(survey) {
      if (this.selectedSurveys.includes(survey.id)) {
        return true;
      }
      return false;
    },
    resetSelection() {
      this.selectedSurveys = [];
      this.continue = false;
    },
  },
  data() {
    return {
      selectedTag: "",
      selectedIntervention: "",
      selectedSurveys: [],
      continue: false,
      interventions: [
        {
          id: 1,
          name: "Kitchen",
          tag: "Technology",
          src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
          surveys: [
            {
              id: 1,
              name: "Survey Kitchen 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 2,
              name: "Survey Kitchen 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 3,
              name: "Survey Kitchen 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 4,
              name: "Survey Kitchen 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
          ],
        },
        {
          id: 2,
          name: "Garden",
          tag: "Technology",
          src: "https://www.thespruce.com/thmb/YDnlBqJp9Z0F-dApUJW9ZgZmI2s=/4711x3141/filters:fill(auto,1)/how-to-start-a-garden-from-scratch-2132778-hero-5f6138784a034bad8bf9607ccb18dbed.jpg",
          surveys: [
            {
              id: 1,
              name: "Survey Garden 1",
              src: "https://www.thespruce.com/thmb/YDnlBqJp9Z0F-dApUJW9ZgZmI2s=/4711x3141/filters:fill(auto,1)/how-to-start-a-garden-from-scratch-2132778-hero-5f6138784a034bad8bf9607ccb18dbed.jpg",
            },
            {
              id: 2,
              name: "Survey Garden 2",
              src: "https://www.thespruce.com/thmb/YDnlBqJp9Z0F-dApUJW9ZgZmI2s=/4711x3141/filters:fill(auto,1)/how-to-start-a-garden-from-scratch-2132778-hero-5f6138784a034bad8bf9607ccb18dbed.jpg",
            },
            {
              id: 3,
              name: "Survey Garden 3",
              src: "https://www.thespruce.com/thmb/YDnlBqJp9Z0F-dApUJW9ZgZmI2s=/4711x3141/filters:fill(auto,1)/how-to-start-a-garden-from-scratch-2132778-hero-5f6138784a034bad8bf9607ccb18dbed.jpg",
            },
            {
              id: 4,
              name: "Survey Garden 4",
              src: "https://www.thespruce.com/thmb/YDnlBqJp9Z0F-dApUJW9ZgZmI2s=/4711x3141/filters:fill(auto,1)/how-to-start-a-garden-from-scratch-2132778-hero-5f6138784a034bad8bf9607ccb18dbed.jpg",
            },
          ],
        },
        {
          id: 3,
          name: "Baños",
          tag: "Technology",
          src: "https://blogs.iadb.org/agua/wp-content/uploads/sites/8/2021/02/WSA_BES_BLOG-2.jpg",
          surveys: [
            {
              id: 1,
              name: "Survey Baños 1",
              src: "https://blogs.iadb.org/agua/wp-content/uploads/sites/8/2021/02/WSA_BES_BLOG-2.jpg",
            },
            {
              id: 2,
              name: "Survey Baños 2",
              src: "https://blogs.iadb.org/agua/wp-content/uploads/sites/8/2021/02/WSA_BES_BLOG-2.jpg",
            },
            {
              id: 3,
              name: "Survey Baños 3",
              src: "https://blogs.iadb.org/agua/wp-content/uploads/sites/8/2021/02/WSA_BES_BLOG-2.jpg",
            },
            {
              id: 4,
              name: "Survey Baños 4",
              src: "https://blogs.iadb.org/agua/wp-content/uploads/sites/8/2021/02/WSA_BES_BLOG-2.jpg",
            },
          ],
        },
        {
          id: 4,
          name: "Irgendwas",
          tag: "Education",
          src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
          surveys: [
            {
              id: 1,
              name: "Survey Education 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 2,
              name: "Survey Education 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 3,
              name: "Survey Education 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 4,
              name: "Survey Education 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 5,
              name: "Survey Education 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 6,
              name: "Survey Education 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 7,
              name: "Survey Education 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 8,
              name: "Survey Education 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 9,
              name: "Survey Education 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 10,
              name: "Survey Education 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 11,
              name: "Survey Education 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 12,
              name: "Survey Education 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
          ],
        },
        {
          id: 4,
          name: "Irgendwas",
          tag: "Application",
          src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
          surveys: [
            {
              id: 1,
              name: "Survey Application 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 2,
              name: "Survey Application 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 3,
              name: "Survey Application 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 4,
              name: "Survey Application 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 5,
              name: "Survey Application 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 6,
              name: "Survey Application 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 7,
              name: "Survey Application 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 8,
              name: "Survey Application 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 9,
              name: "Survey Application 1",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 10,
              name: "Survey Application 2",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 11,
              name: "Survey Application 3",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
            {
              id: 12,
              name: "Survey Application 4",
              src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
            },
          ],
        },
      ],
    };
  },
};
</script>

<style>
:root {
  --container-margin: 25px;
}
</style>

<style scoped>
.container {
  box-sizing: border-box;
  margin-left: var(--container-margin);
  margin-right: var(--container-margin);
  margin-bottom: var(--container-margin);
  height: calc(100vh - var(--navbar-height) - 1 * var(--container-margin));

  display: grid;
  grid-template-rows: 60px 85px calc(
      100vh - var(--navbar-height) - var(--container-margin) - 60px - 85px
    );
  grid-template-columns:
    60px calc(
      100vw - var(--left-menu-width) - var(--container-margin) * 2 - 60px -
        200px
    )
    200px;

  grid-template-areas:
    "return header buttons"
    "filter filter filter"
    "main main main";
}

.return-wrapper {
  grid-area: return;
  justify-self: start;
  border: none;
  margin: auto 0;
}
.sodis {
  background-color: #2d91be;
  color: white;
}
.return {
  width: 50px;
}
.header {
  grid-area: header;
  margin: auto 0;
  text-align: left;
  font-size: 20px;
}

.main {
  grid-area: main;
  background-color: rgb(255, 255, 255);
  overflow-x: hidden;
  overflow-y: scroll;
}

.filter {
  padding-left: 20px;
  border-bottom: 1px solid var(--bg-color);
  grid-area: filter;
  background-color: rgb(255, 255, 255);
}

.continue-wrapper {
  grid-area: buttons;
  justify-self: end;
  margin: auto 0;
}
.continue {
  width: 50px;
}

/* Main */
.filter-wrapper,
.intervention-wrapper {
  display: flex;
  margin: 10px 0;
}
.filter-description,
.intervention-description {
  text-align: left;
  font-size: 20px;
}

.intervention,
.tag {
  font-size: 20px;
  min-width: 150px;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.5);
  border-radius: 10px;
  color: black;
  background-color: white;

  margin: 0 10px;
  transition: box-shadow 0.3s;
}

.intervention:hover,
.tag:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.5);
}
.intervention.selected,
.tag.selected {
  background-color: var(--bg-color);
  color: white;
}

.survey-wrapper {
  display: flex;
  flex-wrap: wrap;
  align-content: stretch;
  gap: 5px 5px;

  padding-left: 5px;
  padding-top: 10px;
  padding-bottom: 10px;
}

/* Designing for scroll-bar */
::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: rgb(255, 255, 255);
  border-radius: 0px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: var(--bg-color);
  border-radius: 1px;
}
</style>
