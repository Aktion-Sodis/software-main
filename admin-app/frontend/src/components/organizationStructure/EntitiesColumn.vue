<template>
  <div
    class="d-flex flex-column"
    style="width: 100%; position: relative"
    v-if="allEntitiesOfLevel({ levelId }).length > 0"
  >
    <Entity
      v-for="entity in allEntitiesOfLevel({ levelId })"
      :key="entity.id"
      :id="entity.id"
      :upperEntityId="entity.upperEntityId"
      :levelId="levelId"
      :entityName="entity.name"
      :entityDescription="entity.description"
      :index="index"
      class="d-flex flex-column align-center my-4"
      style="position: relative; height: 128px"
    />

    <AddEntityButton class="mt-4" :levelId="levelId" />
    <div v-show="!getLoading">
      <div
        class="vertical-line"
        v-for="line in calculatedLinesByLevelId({ levelId })"
        :key="line.entityId"
        :style="`background-color: ${lineColors[line.indentation]}; height: ${
        160 * (line.y1 - line.y0)
      }px; top: ${80 + line.y0 * 160 + line.indentation * 6}px; left: -${
        60 - line.indentation * 12
      }px;`"
      ></div>
    </div>
  </div>
  <div v-else class="d-flex flex-column mt-8 align-center" style="width: 100%">
    <p>No entities for this level.</p>
    <AddEntityButton class="mt-4" :levelId="levelId" />
  </div>
</template>

<script>
import { validate as uuidValidate } from 'uuid';

import { mapGetters } from 'vuex';

import AddEntityButton from './AddEntityButton.vue';
import Entity from './Entity.vue';

export default {
  name: 'EntitiesColumn',
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
      allEntitiesOfLevel: 'ENTITY_Data/allEntitiesByLevelId',
      getLoading: 'LEVEL_Data/getLoading',
      lineColors: 'getLineColors',
      calculatedLinesByLevelId: 'ENTITY_Data/calculatedLinesByLevelId',
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
