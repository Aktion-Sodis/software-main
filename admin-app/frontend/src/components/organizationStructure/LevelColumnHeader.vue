<template>
  <v-sheet class="headerSkeleton">
    <div style="width: 100%" class="d-flex flex-column align-center">
      <v-skeleton-loader v-if="getLoading" type="button"></v-skeleton-loader>
      <v-btn v-else plain rounded class="text-none black--text" @click="clickOnLevelHandler">
        <span class="text-h5">{{ name }}</span>
      </v-btn>
      <div style="width: 100%">
        <div
          style="width: 100%"
          v-if="interventionsOfLevel.length > 0"
          class="d-flex justify-space-around"
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
            v-for="(intervention, index) in interventionsOfLevel"
            :key="intervention.id"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-avatar v-if="index < 7" v-bind="attrs" v-on="on">
                <v-icon>mdi-hammer-wrench</v-icon>
              </v-avatar>
              <v-avatar v-if="index === 8" v-bind="attrs" v-on="on">
                <v-icon>mdi-dots-horizontal</v-icon>
              </v-avatar>
            </template>
            <span v-if="index < 7">
              {{ calculateUILocaleString({ languageTexts: intervention.name.languageTexts }) }}
            </span>
            <span v-if="index === 8">
              {{
                $t('organizationStructure.thereAreMoreInterventions', {
                  count: interventionsOfLevel.length - 8,
                })
              }}
            </span>
          </v-tooltip>
        </div>
        <div v-else style="height: 48px; overflow: hidden" class="d-flex justify-center">
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
import { dataTypesDict, vuexModulesDict } from '../../lib/constants';

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
      getLoading: `${vuexModulesDict.level}/getLoading`,
      INTERVENTIONById: `${vuexModulesDict.intervention}/INTERVENTIONById`,
      interventionsOfLevelById: `${vuexModulesDict.level}/interventionsOfLevelById`,
      calculateUILocaleString: 'calculateUILocaleString',
    }),
    interventionsOfLevel() {
      return this.interventionsOfLevelById({ levelId: this.id });
    },
  },
  methods: {
    ...mapActions({
      readData: `${vuexModulesDict.dataModal}/readData`,
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
