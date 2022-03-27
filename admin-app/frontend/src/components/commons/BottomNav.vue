<template>
  <v-bottom-navigation fixed app background-color="primary-dark" class="align-center" height="44">
    <v-btn
      v-for="route in routes"
      :key="route.name"
      :to="{ name: route.name }"
      :exact="route.name === 'Home'"
      large
      class="primary-dark"
      active-class="primary darken-2"
    >
      <v-icon color="white">{{ route.icon }}</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'BottomNav',
  data: () => ({
    routes: [
      { icon: 'mdi-home-outline', name: 'Home', i18nKey: 'home' },
      { icon: 'mdi-domain', name: 'BaseData', i18nKey: 'baseData' },
      {
        icon: 'mdi-clipboard-text-outline',
        name: 'OrganizationStructure',
        i18nKey: 'organizationStructure',
      },
      { icon: 'mdi-wrench-outline', name: 'Interventions', i18nKey: 'interventions' },
    ],
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

<style scoped></style>
