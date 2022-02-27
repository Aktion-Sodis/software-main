<template>
  <v-card style="height: 100%" class="pa-2" outlined tile @click="clickHandler">
    <v-img src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg" height="200px"> </v-img>
    <v-card-title>
      {{ interventionName }}
      <v-spacer></v-spacer>
      <v-chip v-for="tagId in interventionTagIds" :key="tagId" class="ml-2"
        >{{ tagById({ tagId: tagId }).name }}
      </v-chip>
    </v-card-title>
    <v-card-subtitle class="mt-0">
      {{ interventionDescription }}
    </v-card-subtitle>
  </v-card>
</template>

<script>
import { validate as uuidValidate } from 'uuid';
import { mapGetters, mapActions } from 'vuex';
import { dataTypesDict } from '../../store/constants';

export default {
  name: 'Intervention',
  props: {
    id: {
      required: true,
      validator: (e) => uuidValidate(e) || e === null,
    },
    interventionName: {
      type: String,
      required: true,
    },
    interventionDescription: {
      type: String,
      required: true,
    },
    interventionTagIds: {
      type: Array,
      validator: (a) => a.every((e) => uuidValidate(e)),
    },
    interventionContent: {
      type: Array,
      validator: (a) => a.every((e) => uuidValidate(e.id)),
    },
  },
  computed: {
    ...mapGetters({
      tagById: 'INTERVENTION_Data/tagById',
    }),
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
