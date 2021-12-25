<template>
  <div
    class="d-flex flex-column"
    style="width: 100%; position: relative"
    v-if="allEntitiesOfHierarchy(hierarchyId).length > 0"
  >
    <Entity
      v-for="entity in allEntitiesOfHierarchy(hierarchyId)"
      :key="entity.entityId"
      :entityId="entity.entityId"
      :upperEntityId="entity.upperEntityId"
      :entityName="entity.name"
      :index="index"
      class="d-flex flex-column align-center my-8"
      style="position: relative; height: 128px"
    />

    <AddEntityButton />
    <div
      class="vertical-line"
      v-for="line in calculatedLinesByHierarchyId(hierarchyId)"
      :key="line.entityId"
      :style="`background-color: ${lineColors[line.indentation]}; height: ${
        192 * (line.y1 - line.y0)
      }px; top: ${96 + line.y0 * 192}px; left: -${
        28 - line.indentation * 6
      }px;`"
    ></div>
  </div>
  <div v-else class="d-flex flex-column mt-8 align-center" style="width: 100%">
    <p>No entities for this level.</p>
    <AddEntityButton class="mt-4" />
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

import AddEntityButton from "./AddEntityButton.vue";
import Entity from "./Entity.vue";

export default {
  name: "EntitiesColumn",
  components: { AddEntityButton, Entity },
  props: {
    hierarchyId: { type: Number, required: true },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
      lineColors: "getLineColors",
      calculatedLinesByHierarchyId: "entities/getCalculatedLinesByHierarchyId",
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
.vertical-line {
  position: absolute;
  width: 3px;
}
</style>
