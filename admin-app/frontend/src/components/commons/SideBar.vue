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
      </v-list>

      <v-list nav dense class="mt-12">
        <v-list-item
          v-for="route in routes"
          :to="{ name: route.name }"
          exact
          :class="currentRouteName === route.name ? 'primary darken-4' : ''"
          :key="route.name"
        >
          <v-list-item-icon>
            <v-icon color="white"> {{ route.icon }} </v-icon>
          </v-list-item-icon>
          <v-list-item-title class="white--text text-body-1">
            {{ $t(`general.routes.${route.name}`) }}
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
import { routes } from '../../router';

const societyName = process.env.VUE_APP_SOCIETY_VERBOSE_NAME;

export default {
  components: { SyncAction },
  name: 'SideBar',
  data: () => ({
    societyName,
    routes: routes
      .filter((r) => r.meta.onSideBar)
      .map((r) => ({
        name: r.name,
        onSideBar: r.meta.onSideBar,
        title: r.meta.title,
        icon: r.meta.icon,
      })),
  }),
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
