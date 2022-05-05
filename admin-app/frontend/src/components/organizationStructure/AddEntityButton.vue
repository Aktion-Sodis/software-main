<template>
  <div class="d-flex justify-center">
    <transition name="horizontal-grow" mode="out-in">
      <v-btn
        v-if="isHovered"
        color="primary"
        rounded
        :disabled="getLoading"
        x-large
        @mouseleave="setIsHovered(false)"
        key="hovered"
        class="overflow-hidden"
        @click="clickHandler"
      >
        <v-icon class="mr-2">mdi-plus</v-icon>
        <span class="overflow-hidden">{{ $t('organizationStructure.addNewEntity') }}</span>
      </v-btn>
      <v-btn
        v-else
        fab
        color="primary"
        @mouseover="setIsHovered(true)"
        :disabled="getLoading"
        key="notHovered"
        @click="clickHandler"
      >
        <v-icon class="mx-auto">mdi-plus</v-icon>
      </v-btn>
    </transition>
  </div>
</template>

<script>
// import { validate as uuidValidate } from 'uuid';

import { mapGetters, mapActions, mapMutations } from 'vuex';
import { dataTypesDict, vuexModulesDict } from '../../lib/constants';

export default {
  name: 'AddEntityButton',
  data: () => ({ isHovered: false }),
  props: {
    entityLevelId: {
      required: true,
      // validator: (v) => uuidValidate(v) || v === null || v.slice(0, 10) === 'dummyLevel',
    },
  },
  computed: {
    ...mapGetters({
      getLoading: `${vuexModulesDict.level}/getLoading`,
    }),
  },
  methods: {
    setIsHovered(payload) {
      this.isHovered = payload;
    },
    ...mapActions({
      createData: `${vuexModulesDict.dataModal}/createData`,
    }),
    ...mapMutations({
      setCreatingEntityInLevelId: 'setCreatingEntityInLevelId',
    }),
    clickHandler() {
      this.setCreatingEntityInLevelId({ id: this.entityLevelId });
      this.createData({ dataType: dataTypesDict.entity });
    },
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
