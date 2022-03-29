<template>
  <div>
    <div v-if="!getLoading">
      <div
        v-if="entityHasParent({ parentEntityID }) && index !== 0"
        class="entity-connection-left-line"
        :style="`width: ${60 - leftLineOfEntity.indentation * 12}px; left: ${
          -60 + leftLineOfEntity.indentation * 12
        }px; background-color: ${lineColors[leftLineOfEntity.indentation]}; top: ${
          64 + leftLineOfEntity.indentation * 6
        }px; z-index: ${leftLineOfEntity.indentation}`"
      ></div>
      <div
        v-if="hasDescendants({ id })"
        class="entity-connection-right-line"
        :style="`width: ${72 + rightLineOfEntity.indentation * 12}px; left: calc(12rem - 26px + ${
          rightLineOfEntity.indentation * 6
        }px); background-color: ${lineColors[rightLineOfEntity.indentation]}; top: ${
          64 + rightLineOfEntity.indentation * 6
        }px; z-index: ${rightLineOfEntity.indentation}`"
      ></div>
    </div>
    <v-hover v-slot="{ hover }">
      <v-sheet
        class="entity-sheet mx-auto grey lighten-5 rounded-lg pa-4 d-flex flex-column justify-center align-center"
        :class="[hover ? 'lighten-4' : '', getLoading ? 'nonClickable' : '']"
        elevation="4"
        @click="clickHandler"
      >
        <v-skeleton-loader
          v-if="getLoading"
          class="entitiySkeleton"
          type="list-item-two-line"
        ></v-skeleton-loader>
        <div v-else>{{ entityName }}</div>
      </v-sheet>
    </v-hover>
  </div>
</template>

<script>
// import { validate as uuidValidate } from 'uuid';

import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'Entity',
  props: {
    id: {
      required: true,
      // validator: (v) => uuidValidate(v) || v === null || v.slice(0, 11) === 'dummyEntity',
    },
    entityLevelId: {
      required: true,
      // validator: (v) => uuidValidate(v) || v === null || v.slice(0, 10) === 'dummyLevel',
    },
    parentEntityID: {
      required: true,
      // validator: (v) => uuidValidate(v) || v === null || v.slice(0, 11) === 'dummyEntity',
    },
    entityName: { type: String, required: true },
    entityDescription: { type: String, required: true },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      entityHasParent: 'ENTITY_Data/hasParentByUpperEntityId',
      hasDescendants: 'ENTITY_Data/hasDescendantsById',
      lineColors: 'getLineColors',
      lineByEntityId: 'ENTITY_Data/lineByEntityId',
      getLoading: 'LEVEL_Data/getLoading',
    }),
    leftLineOfEntity() {
      return this.lineByEntityId({ id: this.parentEntityID });
    },
    rightLineOfEntity() {
      return this.lineByEntityId({ id: this.id });
    },
  },
  methods: {
    ...mapActions({
      readData: 'dataModal/readData',
    }),
    clickHandler() {
      this.readData({ dataId: this.id, dataType: 'ENTITY' });
    },
  },
};
</script>

<style scoped>
.nonClickable {
  pointer-events: none;
}
.entitiySkeleton {
  width: 100%;
}

.entity-connection-left-line {
  position: absolute;
  height: 3px;
}

.entity-connection-right-line {
  position: relative;
  height: 3px;
}

.entity-icon {
  position: absolute;
  top: 0;
  right: 0;
}

.entity-sheet {
  width: 100%;
  height: 100%;
  cursor: pointer;
  position: relative !important;
}
</style>
