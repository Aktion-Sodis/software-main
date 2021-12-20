<template>
  <div>
    <div
      v-if="entityIsInTree(entityId) && index !== 0"
      class="entity-connection-left-line"
    ></div>
    <div
      v-if="getEntityShouldHaveVerticalLine(entityId, upperEntityId, index)"
      class="entity-connection-vertical-line"
    ></div>
    <div
      v-if="
        hasChildren(entityId) &&
        (entityIsInTree(entityId) || entityId === treeRoot.entityId)
      "
      class="entity-connection-right-line"
    ></div>
    <v-hover v-slot="{ hover }">
      <v-sheet
        class="entity-sheet mx-auto grey lighten-5 rounded-lg pa-4 d-flex flex-column justify-center align-center"
        :class="hover ? 'lighten-2' : ''"
        elevation="4"
        @click="clickOnEntity(entity)"
      >
        {{ entityName }}
        <v-btn fab icon class="entity-icon">
          <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
        </v-btn>
      </v-sheet>
    </v-hover>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

export default {
  entityName: "Entity",
  props: {
    entityId: { type: Number, required: true },
    upperEntityId: {
      required: true,
      validator: (e) => typeof e === "number" || e === null,
    },
    entityName: { type: String, required: true },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      entityIsInTree: "entities/getEntityIsInTree",
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

.entity-sheet {
  width: 100%;
  height: 128px;
  cursor: pointer;
  position: relative !important;
}
</style>
