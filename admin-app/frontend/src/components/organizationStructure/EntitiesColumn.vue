<template>
  <div
    class="d-flex flex-column"
    style="width: 100%"
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
      style="position: relative"
    />

    <AddEntityButton />
  </div>
  <div class="d-flex flex-column mt-8 align-center" style="width: 100%" v-else>
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
    }),
  },
  methods: {
    ...mapActions({
      clickOnEntity: "entities/clickOnEntity",
    }),
  },
};
</script>
