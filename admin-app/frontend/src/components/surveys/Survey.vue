<template>
  <v-card style="height: 100%" class="pa-2" outlined tile @click="clickHandler">
    <v-img src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg" height="200px"> </v-img>
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
import { dataTypesDict } from '../../store/constants';

export default {
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
  },
  computed: {
    ...mapGetters({
      tagById: 'SURVEY_Data/tagById',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
  },
  methods: {
    clickHandler() {
      this.readData({ dataId: this.id, dataType: dataTypesDict.survey });
    },
    ...mapActions({
      readData: 'dataModal/readData',
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
