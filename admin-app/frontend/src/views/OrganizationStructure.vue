<template>
  <div style="overflow-x: scroll; width: 100%">
    <h1 class="ml-8">Organization Structure</h1>
    <div class="my-8 d-flex">
      <div
        v-for="(hierarchy, index) in hierarchialStructure"
        :key="hierarchy.hierarchyId"
        class="column-wrapper d-flex flex-column align-center px-8"
        :style="
          hierarchy.upperHierarchy === null ||
          'border-left: 4px rgb(0, 0, 0, 0.2) dotted;'
        "
      >
        <h4 style="width: 100%">{{ hierarchy.name }}</h4>
        <EntitiesColumn :hierarchyId="hierarchy.hierarchyId" :index="index" />
      </div>
      <div class="column-wrapper d-flex align-center justify-center">
        <NewLevelModal />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

import NewLevelModal from "../components/organizationStructure/NewLevelModal.vue";
import EntitiesColumn from "../components/organizationStructure/EntitiesColumn.vue";

export default {
  name: "OrganizationStructure",
  components: { NewLevelModal, EntitiesColumn },
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      hierarchialStructure: "entities/getHierarchialStructure",
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
</style>
