<template>
  <div
    class="d-flex flex-column"
    style="min-width: 640px; position: relative"
    v-if="allEntitiesOfLevel({ entityLevelId }).length > 0"
  >
    <Entity
      v-for="entity in allEntitiesOfLevel({ entityLevelId })"
      :key="entity.id"
      :id="entity.id"
      :parentEntityID="entity.parentEntityID"
      :entityLevelId="entityLevelId"
      :entityName="calculateUILocaleString({ languageTexts: entity.name.languageTexts })"
      :entityDescription="
        calculateUILocaleString({ languageTexts: entity.description.languageTexts })
      "
      :index="index"
      class="d-flex flex-column align-center my-4"
      style="position: relative; height: 128px; width: 256px; left: 192px"
    />

    <AddEntityButton class="mt-4" :entityLevelId="entityLevelId" />
    <div v-if="!getLoading">
      <div
        class="vertical-line"
        v-for="line in calculatedLinesByLevelId({ entityLevelId })"
        :key="line.entityId"
        :style="`background-color: ${lineColors[line.indentation]}; height: ${
          160 * (line.y1 - line.y0)
        }px; top: ${32 + line.y0 * 160 + line.indentation * 3}px; left: ${
          -192 + line.indentation * 6
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
import { vuexModulesDict } from '../../lib/constants';

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
      allEntitiesOfLevel: `${vuexModulesDict.entity}/allEntitiesByLevelId`,
      getLoading: `${vuexModulesDict.level}/getLoading`,
      lineColors: 'getLineColors',
      calculatedLinesByLevelId: `${vuexModulesDict.entity}/calculatedLinesByLevelId`,
      calculateUILocaleString: 'calculateUILocaleString',
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
