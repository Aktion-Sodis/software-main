<template>
  <div
    class="d-flex flex-column"
    style="width: 100%; position: relative"
    v-if="allEntitiesOfLevel({ entityLevelId }).length > 0"
  >
    <Entity
      v-for="entity in allEntitiesOfLevel({ entityLevelId })"
      :key="entity.id"
      :id="entity.id"
      :parentEntityID="entity.parentEntityID"
      :entityLevelId="entityLevelId"
      :entityName="entity.name.languageTexts[$store.getters.fallbackLocaleIndex]"
      :entityDescription="entity.description.languageTexts[$store.getters.fallbackLocaleIndex]"
      :index="index"
      class="d-flex flex-column align-center my-4"
      style="position: relative; height: 128px"
    />

    <AddEntityButton class="mt-4" :entityLevelId="entityLevelId" />
    <div v-if="!getLoading">
      <div
        class="vertical-line"
        v-for="line in calculatedLinesByLevelId({ entityLevelId })"
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
    <p>{{ $t('organizationStructure.hasNoEntities') }}</p>
    <AddEntityButton class="mt-4" :entityLevelId="entityLevelId" />
  </div>
</template>

<script>
// import { validate as uuidValidate } from 'uuid';
import { mapGetters } from 'vuex';

import AddEntityButton from './AddEntityButton.vue';
import Entity from './Entity.vue';

export default {
  name: 'EntitiesColumn',
  components: { AddEntityButton, Entity },
  props: {
    entityLevelId: {
      required: true,
      // validator: (v) => uuidValidate(v) || v.slice(0, 10) === 'dummyLevel' || v === null,
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
