<template>
  <div class="d-flex flex-column" style="width: 100%">
    <div
      v-for="entity in allEntitiesOfHierarchy(hierarchyId)"
      :key="entity.entityId"
      class="d-flex flex-column align-center my-8"
      style="position: relative"
    >
      <div>
        <div
          v-if="entityIsInTree(entity.entityId) && index !== 0"
          class="entity-connection-left-line"
        ></div>
        <div
          v-if="
            getEntityShouldHaveVerticalLine(
              entity.entityId,
              entity.upperEntityId,
              index
            )
          "
          class="entity-connection-vertical-line"
        ></div>
      </div>
      <div
        v-if="
          hasChildren(entity.entityId) &&
          (entityIsInTree(entity.entityId) ||
            entity.entityId === treeRoot.entityId)
        "
        class="entity-connection-right-line"
      ></div>
      <v-hover v-slot="{ hover }">
        <v-sheet
          class="mx-auto transition-swing grey lighten-5 rounded-lg pa-4 d-flex flex-column justify-center align-center"
          :class="hover ? 'lighten-2' : ''"
          elevation="4"
          style="
            width: 100%;
            height: 128px;
            cursor: pointer;
            position: relative !important;
          "
          @click="clickOnEntity(entity)"
        >
          {{ entity.name }}
          <v-btn fab icon class="entity-icon">
            <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
          </v-btn>
        </v-sheet>
      </v-hover>
    </div>
    <AddEntityButton />
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

import AddEntityButton from "./AddEntityButton.vue";

export default {
  name: "EntitiesColumn",
  components: { AddEntityButton },
  props: {
    hierarchyId: { type: Number, required: true },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
      entityIsInTree: "entities/getEntityIsInTree",
      hierarchialData: "entities/getHierarchialData",
      getEntityShouldHaveVerticalLine:
        "entities/getEntityShouldHaveVerticalLine",
      hasChildren: "entities/getHasChildren",
      treeRoot: "entities/getTreeRoot",
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
.entity-connection-left-line {
  position: absolute;
  height: 3px;
  background-color: orange;
  width: 16px;
  left: -16px;
  top: 64px;
}

.entity-connection-right-line {
  position: relative;
  height: 3px;
  background-color: orange;
  width: 52px;
  left: calc(16rem - 6px);
  top: 64px;
}

.entity-connection-vertical-line {
  position: absolute;
  height: 195px;
  background-color: orange;
  width: 3px;
  left: -16px;
  top: 64px;
}

.entity-icon {
  position: absolute;
  top: 0;
  right: 0;
}
</style>
