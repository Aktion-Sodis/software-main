<template>
  <div
    class="d-flex flex-column"
    style="width: 100%; position: relative"
    v-if="allEntitiesOfLevel(levelId).length > 0"
  >
    <Entity
      v-for="entity in allEntitiesOfLevel(levelId)"
      :key="entity.entityId"
      :entityId="entity.entityId"
      :upperEntityId="entity.upperEntityId"
      :entityName="entity.name"
      :index="index"
      class="d-flex flex-column align-center my-4"
      style="position: relative; height: 128px"
    />

    <AddEntityButton :levelId="levelId" />
    <div
      class="vertical-line"
      v-for="line in calculatedLinesByLevelId(levelId)"
      :key="line.entityId"
      :style="`background-color: ${lineColors[line.indentation]}; height: ${
        160 * (line.y1 - line.y0)
      }px; top: ${80 + line.y0 * 160 + line.indentation * 6}px; left: -${
        60 - line.indentation * 12
      }px;`"
    ></div>
  </div>
  <div v-else class="d-flex flex-column mt-8 align-center" style="width: 100%">
    <p>No entities for this level.</p>
    <AddEntityButton class="mt-4" :levelId="levelId" />
  </div>
</template>

<script>
import { validate as uuidValidate } from "uuid";

import { mapGetters, mapActions } from "vuex";

import AddEntityButton from "./AddEntityButton.vue";
import Entity from "./Entity.vue";

export default {
  name: "EntitiesColumn",
  components: { AddEntityButton, Entity },
  props: {
    levelId: {
      required: true,
      validator: (e) => uuidValidate(e) || e === null,
    },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      allEntitiesOfLevel: "entities/getAllEntitiesOfLevelByHid",
      lineColors: "getLineColors",
      calculatedLinesByLevelId: "entities/getCalculatedLinesByLevelId",
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
