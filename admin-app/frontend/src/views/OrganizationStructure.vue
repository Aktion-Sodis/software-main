<template>
  <div style="overflow-x: scroll; width: 100%">
    <h1 class="ml-8">{{ $t('organizationStructure.title') }}</h1>
    <div class="my-8 d-flex">
      <div
        v-for="(level, index) in levels"
        :key="level.id"
        class="px-24"
        :class="level.parentLevelID === null || 'dotted-left-border'"
      >
        <LevelColumnHeader
          :id="level.id"
          :name="calculateUILocaleString({ languageTexts: level.name.languageTexts })"
        />
        <EntitiesColumn :entityLevelId="level.id" :index="index" />
      </div>
      <div class="dotted-left-border d-flex align-center justify-center">
        <v-btn :disabled="getLoading" rounded x-large color="primary" @click="clickOnAddNewLevel">
          <v-icon class="mr-2">mdi-plus</v-icon>
          <v-skeleton-loader
            v-if="getLoading"
            width="196"
            class="mt-2"
            type="text"
          ></v-skeleton-loader>
          <span v-else>
            {{ $t('organizationStructure.addNewLevel') }}
          </span>
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

import EntitiesColumn from '../components/organizationStructure/EntitiesColumn.vue';
import LevelColumnHeader from '../components/organizationStructure/LevelColumnHeader.vue';
import { dataTypesDict, routeNamesDict, vuexModulesDict } from '../lib/constants';

export default {
  name: routeNamesDict.OrganizationStructure,
  components: {
    EntitiesColumn,
    LevelColumnHeader,
  },
  computed: {
    ...mapGetters({
      getLoading: `${vuexModulesDict.level}/getLoading`,
      levels: `${vuexModulesDict.level}/sortedLevels`,
      isModalDisplayed: `${vuexModulesDict.dataModal}/getIsDisplayed`,
      dataType: `${vuexModulesDict.dataModal}/getDataType`,

      calculateUILocaleString: 'calculateUILocaleString',
    }),
  },
  methods: {
    ...mapActions({
      createData: `${vuexModulesDict.dataModal}/createData`,
    }),
    clickOnAddNewLevel() {
      this.createData({ dataType: dataTypesDict.level });
    },
  },
};
</script>

<style scoped>
.dotted-left-border {
  border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}

.edit-level-icon {
  transform: translate(4px, -8px);
}
</style>
