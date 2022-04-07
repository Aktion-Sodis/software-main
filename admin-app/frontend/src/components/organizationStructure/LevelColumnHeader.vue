<template>
  <v-sheet class="headerSkeleton">
    <div style="width: 100%" class="d-flex flex-column align-center">
      <v-skeleton-loader v-if="getLoading" type="button"></v-skeleton-loader>
      <v-btn v-else plain rounded class="text-none black--text" @click="clickOnLevelHandler">
        <span class="text-h5">{{ name }}</span>
      </v-btn>
      <div style="width: 100%">
        <div
          class="d-flex justify-space-around"
          style="width: 100%"
          v-if="interventionsOfLevelById.length > 0"
        >
          <div v-if="getLoading">
            <div class="row mt-3">
              <v-skeleton-loader class="mr-3" type="avatar"></v-skeleton-loader>
              <v-skeleton-loader class="mr-3" type="avatar"></v-skeleton-loader>
              <v-skeleton-loader type="avatar"></v-skeleton-loader>
            </div>
          </div>
          <v-tooltip
            v-else
            top
            v-for="intervention in interventionsOfLevelById({ levelId: id })"
            :key="intervention.id"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-avatar v-bind="attrs" v-on="on">
                <v-icon>mdi-hammer-wrench</v-icon>
              </v-avatar>
            </template>
            <span>{{ intervention.name }}</span>
          </v-tooltip>
        </div>
        <div v-else style="height: 48px; overflow: hidden">
          <v-skeleton-loader v-if="getLoading" class="mt-3" type="text"></v-skeleton-loader>
          <p v-else class="caption">{{ $t('organizationStructure.hasNoInterventions') }}</p>
        </div>
      </div>
    </div>
  </v-sheet>
</template>

<script>
// import { validate as uuidValidate } from 'uuid';
import { mapActions, mapGetters } from 'vuex';
import { dataTypesDict } from '../../store/constants';

export default {
  name: 'LevelColumnHeader',
  props: {
    name: {
      type: String,
      required: true,
    },
    id: {
      type: String,
      required: true,
      // validator: (v) => uuidValidate(v) || v.slice(0, 10) === 'dummyLevel',
    },
  },
  computed: {
    ...mapGetters({
      getLoading: 'LEVEL_Data/getLoading',
      INTERVENTIONById: 'INTERVENTION_Data/INTERVENTIONById',
      interventionsOfLevelById: 'LEVEL_Data/interventionsOfLevelById',
    }),
  },
  methods: {
    ...mapActions({
      readData: 'dataModal/readData',
    }),
    clickOnLevelHandler() {
      this.readData({ dataId: this.id, dataType: dataTypesDict.level });
    },
  },
};
</script>

<style scoped>
.headerSkeleton {
  width: 100%;
  display: flex;
  justify-content: center;
}
</style>
