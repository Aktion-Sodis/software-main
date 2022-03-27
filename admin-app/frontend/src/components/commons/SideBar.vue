<template>
  <v-navigation-drawer permanent expand-on-hover class="primary-dark" width="17rem" fixed>
    <div class="side-bar-inner-wrapper overflow-hidden">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar class="my-0">
            <v-img src="../../static/aktionSodisSmall.png"></v-img>
          </v-list-item-avatar>
          <v-list-item-title class="white--text text-body-1 ml-3">
            {{ societyName }}
          </v-list-item-title>
        </v-list-item>
        <SyncAction />
        <!-- <v-btn @click="CreateDummyLevels">Create dummy levels</v-btn> -->
        <!-- <v-btn @click="CreateDummyEntities">Create dummy entities</v-btn> -->
      </v-list>

      <v-list nav dense class="mt-12">
        <v-list-item
          :to="{ name: 'Home' }"
          exact
          :class="currentRouteName === 'Home' ? 'primary darken-4' : ''"
          @click="showToBeImplementedFeedback"
        >
          <v-list-item-icon>
            <v-icon color="white">mdi-home-outline</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="white--text text-body-1">
            {{ $t('general.routes.home') }}
          </v-list-item-title>
        </v-list-item>
        <v-list-item
          :to="{ name: 'BaseData' }"
          :class="currentRouteName === 'BaseData' ? 'primary darken-4' : ''"
          @click="showToBeImplementedFeedback"
        >
          <v-list-item-icon>
            <v-icon color="white">mdi-domain</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="white--text text-body-1">
            {{ $t('general.routes.baseData') }}
          </v-list-item-title>
        </v-list-item>
        <v-list-item
          :to="{ name: 'OrganizationStructure' }"
          :class="currentRouteName === 'OrganizationStructure' ? 'primary darken-4' : ''"
        >
          <v-list-item-icon>
            <v-icon color="white">mdi-clipboard-text-outline</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="white--text text-body-1">
            {{ $t('general.routes.organizationStructure') }}
          </v-list-item-title>
        </v-list-item>
        <v-list-item
          :to="{ name: 'Interventions' }"
          :class="currentRouteName === 'Interventions' ? 'primary darken-4' : ''"
        >
          <v-list-item-icon>
            <v-icon color="white">mdi-wrench-outline</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="white--text text-body-1">
            {{ $t('general.routes.interventions') }}
          </v-list-item-title>
        </v-list-item>
      </v-list>

      <v-list dense>
        <v-list-item link @click="showToBeImplementedFeedback">
          <v-list-item-icon>
            <v-icon color="white">mdi-cog-outline</v-icon>
          </v-list-item-icon>
        </v-list-item>
        <v-list-item class="px-2">
          <v-list-item-avatar>
            <v-img src="https://randomuser.me/api/portraits/women/75.jpg"></v-img>
          </v-list-item-avatar>
          <div class="next-to-avatar">
            <v-list-item-content>
              <v-list-item-title class="text-h6 white--text" style="white-space: initial"
                >{{ credentials.firstName }} {{ credentials.lastName }}</v-list-item-title
              >
              <v-list-item-subtitle class="white--text" style="white-space: initial">
                {{ credentials.email }}
              </v-list-item-subtitle>
            </v-list-item-content>
            <v-btn @click="logout" class="mx-2" fab elevation="0" small color="primary">
              <v-icon color="white">mdi-exit-to-app</v-icon>
            </v-btn>
          </div>
        </v-list-item>
      </v-list>
    </div>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import SyncAction from './SyncAction.vue';

const societyName = process.env.VUE_APP_SOCIETY_VERBOSE_NAME;

export default {
  components: { SyncAction },
  name: 'SideBar',
  data: () => ({ societyName }),
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/getIsAuthenticated',
      credentials: 'auth/credentials',
    }),
    currentRouteName() {
      return this.$route.name;
    },
  },
  methods: {
    ...mapActions({
      deleteSession: 'auth/deleteSession',
      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
      CreateDummyLevels: 'LEVEL_Data/CreateDummyLevels',
      CreateDummyEntities: 'ENTITY_Data/CreateDummyEntities',
    }),
    logout() {
      this.deleteSession();
      this.$router.push({ name: 'Login' });
    },
  },
};
</script>

<style scoped>
.side-bar-inner-wrapper {
  height: 100vh;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
}

.next-to-avatar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-direction: row;
}
</style>
