<template>
  <div>
    <div
      v-if="entityHasParent(upperEntityId) && index !== 0"
      class="entity-connection-left-line"
      :style="`width: ${60 - leftLineOfEntity.indentation * 12}px; left: ${
        -60 + leftLineOfEntity.indentation * 12
      }px; background-color: ${
        lineColors[leftLineOfEntity.indentation]
      }; top: ${64 + leftLineOfEntity.indentation * 6}px; z-index: ${
        leftLineOfEntity.indentation
      }`"
    ></div>
    <div
      v-if="hasDescendants(entityId)"
      class="entity-connection-right-line"
      :style="`width: ${
        72 + rightLineOfEntity.indentation * 12
      }px; left: calc(16rem - 26px + ${
        rightLineOfEntity.indentation * 4
      }px); background-color: ${
        lineColors[rightLineOfEntity.indentation]
      }; top: ${64 + rightLineOfEntity.indentation * 6}px; z-index: ${
        rightLineOfEntity.indentation
      }`"
    ></div>
    <v-hover v-slot="{ hover }">
      <v-sheet
        class="entity-sheet mx-auto grey lighten-5 rounded-lg pa-4 d-flex flex-column justify-center align-center"
        :class="hover ? 'lighten-4' : ''"
        elevation="4"
      >
        {{ entityName }} <br />
        <v-btn
          fab
          icon
          class="entity-icon"
          @click="clickOnEditEntity(entityId)"
        >
          <v-icon color="darken-2"> mdi-pencil-outline </v-icon>
        </v-btn>
      </v-sheet>
    </v-hover>
  </div>
</template>

<script>
import { validate as uuidValidate } from "uuid";

import { mapGetters, mapActions } from "vuex";

export default {
  entityName: "Entity",
  props: {
    entityId: {
      required: true,
      validator: (e) => uuidValidate(e) || e === null,
    },
    upperEntityId: {
      required: true,
      validator: (e) => uuidValidate(e) || e === null,
    },
    entityName: { type: String, required: true },
    index: { type: Number, required: true },
  },
  computed: {
    ...mapGetters({
      entityHasParent: "entities/getEntityHasParent",
      hasDescendants: "entities/getHasDescendants",
      lineColors: "getLineColors",
      lineOfEntity: "entities/getLineByEntityId",
    }),
    leftLineOfEntity() {
      return this.lineOfEntity(this.upperEntityId);
    },
    rightLineOfEntity() {
      return this.lineOfEntity(this.entityId);
    },
  },
  methods: {
    ...mapActions({
      clickOnEditEntity: "os/clickOnEditEntity",
    }),
  },
};
</script>

<style scoped>
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
