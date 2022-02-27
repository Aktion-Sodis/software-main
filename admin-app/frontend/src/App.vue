<template>
  <v-app>
    <div class="top-right-fixed" v-if="$vuetify.breakpoint.name !== 'xs'">
      <v-select
        v-model="$root.$i18n.locale"
        :items="langs"
        item-text="name"
        item-value="abbr"
        outlined
        dense
        background-color="grey"
        class="lang-select"
        :style="currentRouteName === 'Login' ? '' : 'margin-right: 1rem;'"
        dark
      ></v-select>
      <v-text-field
        v-if="currentRouteName !== 'Login' && $vuetify.breakpoint.name !== 'xs'"
        :label="$t('general.searchBox')"
        prepend-inner-icon="mdi-magnify"
        outlined
        dense
        background-color="grey"
        dark
        @focus="showToBeImplementedFeedback"
      ></v-text-field>
    </div>

    <v-main
      :class="
        currentRouteName === 'Login'
          ? 'mt-0'
          : $vuetify.breakpoint.name === 'xs'
          ? 'ml-0 mt-8'
          : 'ml-16 mt-12'
      "
    >
      <router-view />
    </v-main>

    <a
      href="https://github.com/Aktion-Sodis/software-main"
      class="d-none d-md-block"
      target="_blank"
    >
      <v-alert
        class="version-wrapper"
        :outlined="currentRouteName !== 'Login'"
        color="primary"
        icon="🚧"
        border="left"
      >
        The Admin-App v0.1, development phase 🔗
      </v-alert>
    </a>

    <Feedback />
    <div
      class="bottom-right-fixed"
      v-if="$vuetify.breakpoint.name === 'xs' && currentRouteName !== 'Login'"
    >
      <v-btn fab dark small color="primary" @click="showToBeImplementedFeedback">
        <v-icon dark> mdi-magnify </v-icon>
      </v-btn>
    </div>
    <SideBar
      v-if="isAuthenticated && $vuetify.breakpoint.name !== 'xs'"
      :currentRouteName="currentRouteName"
      class="d-none d-md-block"
    />
    <BottomNav
      v-if="isAuthenticated && $vuetify.breakpoint.name === 'xs'"
      :currentRouteName="currentRouteName"
    />
  </v-app>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import BottomNav from './components/commons/BottomNav.vue';
import Feedback from './components/commons/Feedback.vue';
import SideBar from './components/commons/SideBar.vue';

export default {
  name: 'App',
  components: { SideBar, Feedback, BottomNav },
  data: () => ({
    langs: [
      { name: 'English US', abbr: 'en-US' },
      { name: 'Español España', abbr: 'es-ES' },
      { name: 'Türkçe Türkiye', abbr: 'tr-TR' },
    ],
  }),
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/getIsAuthenticated',
    }),
    currentRouteName() {
      return this.$route.name;
    },
  },
  methods: {
    ...mapActions({
      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
    }),
  },
};
</script>

<style scoped>
.top-right-fixed {
  position: fixed;
  top: 24px;
  right: 24px;
  z-index: 2;
  display: flex;
}

.bottom-right-fixed {
  position: fixed;
  bottom: 68px;
  right: 24px;
  z-index: 2;
  display: flex;
}

.lang-select {
  max-width: 10.5rem;
}

.version-wrapper {
  position: fixed;
  right: 1rem;
  bottom: 0;
}
</style>
