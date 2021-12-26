<template>
  <div style="overflow-x: scroll; width: 100%">
    <h1 class="ml-8">Organization Structure</h1>
    <div class="my-8 d-flex">
      <div
        v-for="(level, index) in levels"
        :key="level.levelId"
        class="column-wrapper d-flex flex-column align-center px-8"
        :class="level.upperLevelId === null || 'dotted-left-border'"
      >
        <h4 style="width: 100%">{{ level.name }}</h4>
        <div style="width: 100%">
          <div
            class="d-flex justify-space-around"
            style="width: 100%"
            v-if="level.allowedTechnologies.length > 0"
          >
            <v-tooltip
              top
              v-for="technologyId in level.allowedTechnologies"
              :key="technologyId"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-avatar v-bind="attrs" v-on="on">
                  <v-icon color="white">mdi-cog-outline</v-icon>
                </v-avatar>
              </template>
              <span>{{ getTechnologyById(technologyId).name }}</span>
            </v-tooltip>
          </div>
          <div v-else style="height: 48px; overflow: hidden">
            <p>No technologies for this level.</p>
          </div>
        </div>
        <EntitiesColumn :levelId="level.levelId" :index="index" />
      </div>
      <div
        class="column-wrapper dotted-left-border d-flex align-center justify-center"
      >
        <LevelModal />
        <EntityModal />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

import LevelModal from "../components/organizationStructure/LevelModal.vue";
import EntityModal from "../components/organizationStructure/EntityModal.vue";
import EntitiesColumn from "../components/organizationStructure/EntitiesColumn.vue";

export default {
  name: "OrganizationStructure",
  components: { LevelModal, EntityModal, EntitiesColumn },
  computed: {
    ...mapGetters({
      levels: "entities/getlevels",
      getTechnologyById: "entities/getTechnologyById",
    }),
  },
  methods: {
    ...mapActions({
      clickOnEntity: "entities/clickOnEntity",
    }),
  },
};
</script>

<style scoped>
.column-wrapper {
  min-width: 32rem;
}

.dotted-left-border {
  border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}
</style>
