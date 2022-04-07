<template>
  <v-card style="height: 100%" class="pa-2" outlined tile @click="clickHandler">
    <ImgFromS3 :assumedSrc="deriveImgPath" dataType="intervention">
      <template v-slot:v-img="slotProps">
        <v-img height="200px" :src="slotProps.src"> </v-img>
      </template>
    </ImgFromS3>
    <v-card-title>
      {{ calculateUILocaleString({ languageTexts: interventionName.languageTexts }) }}
      <v-spacer></v-spacer>
      <!-- <v-chip v-for="tagId in interventionTagIds" :key="tagId" class="ml-2"
        >{{ tagById({ id: tagId }).text }}
      </v-chip> -->
    </v-card-title>
    <v-card-subtitle class="mt-0">
      {{ calculateUILocaleString({ languageTexts: interventionDescription.languageTexts }) }}
    </v-card-subtitle>
  </v-card>
</template>

<script>
// import { validate as uuidValidate } from 'uuid';
import { mapGetters, mapActions } from 'vuex';
import { dataTypesDict } from '../../store/constants';
import { deriveFilePath } from '../../store/utils';
import ImgFromS3 from '../commons/ImgFromS3.vue';

export default {
  components: { ImgFromS3 },
  name: 'Intervention',
  props: {
    id: {
      required: true,
      // validator: (e) => uuidValidate(e) || e === null,
    },
    interventionName: {
      type: Object,
      required: true,
    },
    interventionDescription: {
      type: Object,
      required: true,
    },
    // interventionTagIds: {
    //   type: Array,
    //   // validator: (a) => a.every((e) => uuidValidate(e)),
    // },
    interventionContent: {
      type: Array,
      // validator: (a) => a.every((e) => uuidValidate(e.id)),
    },
  },
  computed: {
    ...mapGetters({
      // tagById: 'INTERVENTION_Data/tagById',
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    deriveImgPath() {
      return deriveFilePath('interventionPicPath', { interventionID: this.id });
    },
  },
  methods: {
    clickHandler() {
      this.readData({ dataId: this.id, dataType: dataTypesDict.intervention });
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
