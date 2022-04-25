<template>
  <v-bottom-navigation
    v-if="$vuetify.breakpoint.name === 'xs'"
    fixed
    app
    background-color="primary-dark"
    class="align-center"
    height="44"
  >
    <v-btn
      v-for="route in routes"
      :key="route.name"
      :to="{ name: route.name }"
      large
      class="primary-dark"
      active-class="primary darken-2"
    >
      <v-icon color="white">{{ route.icon }}</v-icon>
    </v-btn>
    <template>
      <div class="text-center">
        <v-menu
          v-model="menu"
          :close-on-content-click="false"
          :nudge-width="100"
          offset-x
        >
          <template v-slot:activator="{ on, attrs }">
            <v-btn  v-bind="attrs" v-on="on">
              <v-icon color="white">mdi-cog-outline</v-icon>
            </v-btn>
          </template>

          <v-card >
            <v-list>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title>Settings</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
            <v-divider></v-divider>
            <v-list>
              <v-list-item>
                <lang-select />
              </v-list-item>
              <v-list-item>
                <v-layout  align-center justify-center>
                    <v-btn @click="logout" class="mx-2" small color="primary" large block>
                      <v-icon color="white">mdi-exit-to-app</v-icon>
                      Logout
                    </v-btn>
                </v-layout>
              </v-list-item>
            </v-list>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                text
                @click="menu = false"
              >
                Close
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-menu>
      </div>
    </template>
  </v-bottom-navigation>

  <v-navigation-drawer v-else permanent expand-on-hover class="primary-dark" width="17rem" fixed>
    <div class="side-bar-inner-wrapper overflow-hidden">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar class="my-0">
            <v-img src="../../../static/aktionSodisSmall.png"></v-img>
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
            <v-img
              alt="a randomized profile of a lego toy."
              :src="`https://randomuser.me/api/portraits/lego/${Math.floor(Math.random() * 8)}.jpg`"
            ></v-img>
          </v-list-item-avatar>
          <div class="next-to-avatar">
            <v-list-item-content>
              <v-list-item-title class="text-h6 white--text" style="white-space: initial">
                {{ credentials.firstName }} {{ credentials.lastName }}
              </v-list-item-title>
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
import { routes } from '../../../router';
import { routeNamesDict, vuexModulesDict } from '../../../lib/constants';
import LangSelect from '../floating/LangSelect.vue';

const societyName = process.env.VUE_APP_SOCIETY_VERBOSE_NAME;

export default {
  components: { SyncAction, LangSelect },
  name: 'NavBar',
  data: () => ({
    fav: true,
    menu: false,
    message: false,
    hints: true,
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
      isAuthenticated: `${vuexModulesDict.auth}/getIsAuthenticated`,
      credentials: `${vuexModulesDict.auth}/credentials`,
    }),
    currentRouteName() {
      return this.$route.name;
    },
    societyName() {
      return societyName;
    },
  },
  methods: {
    ...mapActions({
      deleteSession: `${vuexModulesDict.auth}/deleteSession`,
      showToBeImplementedFeedback: `${vuexModulesDict.feedback}/showToBeImplementedFeedback`,
    }),
    async logout() {
      await this.deleteSession();
      this.$router.push({ name: routeNamesDict.Login });
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
