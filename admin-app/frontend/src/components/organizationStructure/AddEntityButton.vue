<template>
  <div class="d-flex justify-center">
    <transition name="horizontal-grow" mode="out-in">
      <v-btn
        v-if="isHovered"
        color="primary"
        rounded
        x-large
        @mouseleave="setIsHovered(false)"
        key="hovered"
        class="overflow-hidden"
        @click="clickOnAddNewEntity(levelId)"
      >
        <v-icon class="mr-2"> mdi-plus </v-icon>
        <span class="overflow-hidden">
          {{ $t("organizationStructure.addNewEntity") }}
        </span>
      </v-btn>
      <v-btn
        v-else
        fab
        color="primary"
        @mouseover="setIsHovered(true)"
        key="notHovered"
        @click="clickOnAddNewEntity(levelId)"
      >
        <v-icon class="mx-auto"> mdi-plus </v-icon>
      </v-btn>
    </transition>
  </div>
</template>

<script>
import { validate as uuidValidate } from "uuid";

import { mapActions } from "vuex";

export default {
  name: "AddEntityButton",
  data: () => ({ isHovered: false }),
  props: {
    levelId: {
      required: true,
      validator: (e) => uuidValidate(e) || e === null,
    },
  },
  methods: {
    setIsHovered: function (payload) {
      this.isHovered = payload;
    },
    ...mapActions({
      clickOnAddNewEntity: "os/clickOnAddNewEntity",
    }),
  },
};
</script>

<style scoped>
.horizontal-grow-enter-active,
.horizontal-grow-leave-active {
  transition-property: max-width;
  transition-duration: 0.3s;
  transition-timing-function: ease;
}
.horizontal-grow-enter,
.horizontal-grow-leave-to {
  max-width: 64px;
}

.horizontal-grow-enter-to,
.horizontal-grow-leave {
  max-width: 30rem;
}
</style>
