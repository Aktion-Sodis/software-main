<template>
  <v-list-item class="px-2">
    <v-list-item-avatar class="my-0">
      <v-btn icon color="grey" large v-if="isSynchronizing">
        <v-icon> mdi-cloud </v-icon>
        <v-progress-circular
          style="position: absolute"
          indeterminate
          color="primary"
          size="12"
          width="2.5"
        ></v-progress-circular>
      </v-btn>
      <v-btn icon color="grey" large v-else-if="isInSync" @click="refresh">
        <v-icon> mdi-cloud-refresh </v-icon>
      </v-btn>
      <v-btn large color="grey" icon v-else>
        <v-icon> mdi-cloud-check </v-icon>
      </v-btn>
    </v-list-item-avatar>
    <v-list-item-title class="white--text text-subtitle-2 font-italic ml-3">
      {{ $t(`general.api.${syncStatus}`) }}
    </v-list-item-title>
  </v-list-item>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import { syncStatusDict, vuexModulesDict } from '../../../lib/constants';

export default {
  name: 'SyncAction',
  computed: {
    ...mapGetters({
      syncStatus: `${vuexModulesDict.sync}/getStatus`,
    }),
    isSynchronizing() {
      return this.syncStatus === syncStatusDict.synchronizing;
    },
    isInSync() {
      return this.syncStatus === syncStatusDict.inSync;
    },
  },
  methods: {
    ...mapActions({
      refresh: `${vuexModulesDict.sync}/refreshHandler`,
    }),
  },
};
</script>

<style scoped></style>
