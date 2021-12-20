<template>
  <div style="overflow-x: scroll; width: 100%">
    <h1 class="ml-8">Organization Structure</h1>
    <div class="my-8 d-flex">
      <div
        v-for="(hierarchy, index) in hierarchialStructure"
        :key="hierarchy.hierarchyId"
        class="column d-flex flex-column align-center px-8"
        :class="hierarchy.upperHierarchy === null || 'dotted-left-border'"
      >
        <h4 style="width: 100%">{{ hierarchy.name }}</h4>
        <div class="d-flex flex-column" style="width: 100%">
          <div
            v-for="entity in allEntitiesOfHierarchy(hierarchy.hierarchyId)"
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
      </div>
      <div
        class="column dotted-left-border d-flex flex-column align-center justify-center"
      >
        <NewLevelModal />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import AddEntityButton from "../components/organizationStructure/AddEntityButton.vue";
import NewLevelModal from "../components/organizationStructure/NewLevelModal.vue";

export default {
  name: "OrganizationStructure",
  components: { AddEntityButton, NewLevelModal },
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      allEntitiesOfHierarchy: "entities/getAllEntitiesOfHierarchyByHid",
      hierarchialData: "entities/getHierarchialData",
      hierarchialStructure: "entities/getHierarchialStructure",
      hasSiblingsUnderIt: "entities/getEntityHasSiblingUnderIt",
      allDescendantsOfTreeRoot: "entities/getAllDescendantsOfTreeRoot",
      entityIsInTree: "entities/getEntityIsInTree",
      hasChildren: "entities/getHasChildren",
      treeRoot: "entities/getTreeRoot",
      verticalOrderByEntityId: "entities/getVerticalOrderByEntityId",
      getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy:
        "entities/getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy",
      parentInTreeRoot: "entities/getParentInTreeRoot",
      parentIsAboveEntity: "entities/getParentIsAboveEntity",
      getMinVerticalOrderOfTreeRootDescendantsInAHierarchy:
        "entities/getMinVerticalOrderOfTreeRootDescendantsInAHierarchy",
      getEntityShouldHaveVerticalLine:
        "entities/getEntityShouldHaveVerticalLine",
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
.column {
  min-width: 32rem;
}

.dotted-left-border {
  border-left: 4px rgb(0, 0, 0, 0.2) dotted;
}

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
