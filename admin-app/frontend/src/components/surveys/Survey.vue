<template>
  <v-card style="height: 100%" class="pa-2" outlined tile @click="clickHandler">
    <ImgFromS3 :assumedSrc="deriveImgPath" dataType="survey">
      <template v-slot:v-img="slotProps">
        <v-img height="200px" :src="slotProps.src"> </v-img>
      </template>
    </ImgFromS3>
    <v-card-title>
      {{ calculateUILocaleString({ languageTexts: surveyName.languageTexts }) }}
      <v-spacer></v-spacer>
      <v-chip v-for="tagId in surveyTagIds" :key="tagId" class="ml-2"
        >{{ tagById({ id: tagId }).text }}
      </v-chip>
      <v-tooltip bottom v-if="interventionName">
        <template v-slot:activator="{ on, attrs }">
          <v-avatar v-bind="attrs" v-on="on">
            <v-icon>mdi-wrench-outline</v-icon>
          </v-avatar>
        </template>
        <span>
          {{ calculateUILocaleString({ languageTexts: interventionName.languageTexts }) }}
        </span>
      </v-tooltip>
    </v-card-title>
    <v-card-subtitle class="mt-0">
      {{ calculateUILocaleString({ languageTexts: surveyDescription.languageTexts }) }}
    </v-card-subtitle>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import { dataTypesDict, vuexModulesDict } from '../../lib/constants';
import { deriveFilePath } from '../../lib/utils';
import ImgFromS3 from '../commons/ImgFromS3.vue';

export default {
  components: { ImgFromS3 },
  name: 'Survey',
  props: {
    id: {
      type: String,
      required: true,
    },
    surveyName: {
      type: Object,
      required: true,
    },
    surveyDescription: {
      type: Object,
      required: true,
    },
    surveyTagIds: {
      type: Array,
    },
    surveyContent: {
      type: Array,
    },
    interventionName: {
      required: true,
    },
    interventionId: {
      required: true,
    },
  },
  computed: {
    ...mapGetters({
      tagById: `${vuexModulesDict.survey}/tagById`,
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    deriveImgPath() {
      return deriveFilePath('interventionSurveyPicPath', {
        interventionID: this.interventionId,
        surveyId: this.id,
      });
    },
  },
  methods: {
    clickHandler() {
      this.readData({ dataId: this.id, dataType: dataTypesDict.survey });
    },
    ...mapActions({
      readData: `${vuexModulesDict.dataModal}/readData`,
    }),
  },
};
</script>

<style scoped>
.iv-edit-icon {
  position: absolute;
  top: 8px;
  right: 8px;
}
</style>
