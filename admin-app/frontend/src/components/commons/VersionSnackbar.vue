<template>
  <a href="https://github.com/Aktion-Sodis/software-main" class="d-none d-md-block" target="_blank">
    <v-alert
      class="version-wrapper white--text"
      :outlined="!isInAuthView"
      color="primary"
      border="left"
      style="z-index: 3"
    >
      The Admin-App v1.0 🔗
    </v-alert>
  </a>
</template>

<script>
export default {
  name: 'DevPhaseSnackbar',
  computed: {
    isInAuthView() {
      return this.$route.name === 'Login' || this.$route.name === 'CompleteUserInfo';
    },
  },
};
</script>

<style scoped>
.version-wrapper {
  position: fixed;
  right: 1rem;
  bottom: 0;
}
</style>
