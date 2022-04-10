<template>
  <v-app>
    <div class="top-right-fixed">
      <LangSelect :style="isInAuthView ? '' : 'margin-right: 1rem;'" />
      <!-- <SearchBox v-if="!isInAuthView" /> -->
    </div>

    <v-main :class="vMainClass">
      <router-view />
    </v-main>

    <DevPhaseSnackbar />

    <Feedback />

    <NavBar v-if="isAuthenticated" />
  </v-app>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import DevPhaseSnackbar from './components/commons/DevPhaseSnackbar.vue';
import Feedback from './components/commons/Feedback.vue';
import LangSelect from './components/commons/LangSelect.vue';
// import SearchBox from './components/commons/SearchBox.vue';
import NavBar from './components/commons/NavBar.vue';

export default {
  name: 'App',
  components: {
    NavBar,
    Feedback,
    LangSelect,
    // SearchBox,
    DevPhaseSnackbar,
  },
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

<style scoped>
.top-right-fixed {
  position: fixed;
  top: 24px;
  right: 24px;
  z-index: 2;
  display: flex;
}
</style>
