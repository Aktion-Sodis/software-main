<template>
  <v-app>
    <div class="top-right-fixed">
      <LangSelect
        v-if="$vuetify.breakpoint.name !== 'xs'"
        :style="isInAuthView ? '' : 'margin-right: 1rem;'"
      />
      <!-- <SearchBox v-if="!isInAuthView" /> -->
    </div>

    <v-main :class="vMainClass">
      <router-view />
    </v-main>

    <DevPhaseSnackbar />

    <Feedback />

    <SideBar
      v-if="isAuthenticated && $vuetify.breakpoint.name !== 'xs'"
      class="d-none d-md-block"
    />
    <BottomNav v-if="isAuthenticated && $vuetify.breakpoint.name === 'xs'" />
  </v-app>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import BottomNav from './components/commons/BottomNav.vue';
import DevPhaseSnackbar from './components/commons/DevPhaseSnackbar.vue';
import Feedback from './components/commons/Feedback.vue';
import LangSelect from './components/commons/LangSelect.vue';
// import SearchBox from './components/commons/SearchBox.vue';
import SideBar from './components/commons/SideBar.vue';

export default {
  name: 'App',
  components: {
    SideBar,
    Feedback,
    BottomNav,
    LangSelect,
    // SearchBox,
    DevPhaseSnackbar,
  },
  data: () => ({
    langs: [
      { name: 'English US', abbr: 'en-US' },
      { name: 'Español Bolivia', abbr: 'es-BO' },
      { name: 'Türkçe Türkiye', abbr: 'tr-TR' },
    ],
  }),
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/getIsAuthenticated',
    }),
    isInAuthView() {
      return this.$route.name === 'Login' || this.$route.name === 'CompleteUserInfo';
    },
    vMainClass() {
      if (this.isInAuthView) return 'mt-0';
      return this.$vuetify.breakpoint.name === 'xs' ? 'ml-0 mt-8' : 'ml-16 mt-12';
    },
  },
  methods: {
    ...mapActions({
      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
    }),
  },
};
</script>

<style>
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

/* fix the white stripe at the right of the screen bug */
html {
  overflow-x: visible;
  overflow-y: visible;
}
</style>
