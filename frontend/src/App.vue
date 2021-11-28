<template>
  <v-app>
    <SideBar v-if="isAuthenticated" :currentRouteName="currentRouteName" />

    <div class="search-bar-wrapper">
      <!-- Language switch is planned only for development -->
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
        v-if="currentRouteName !== 'Login'"
        :label="$t('general.search-box')"
        prepend-inner-icon="mdi-magnify"
        outlined
        dense
        background-color="grey"
        dark
      ></v-text-field>
    </div>

    <v-main :class="currentRouteName === 'Login' ? 'ml-0' : 'ml-16'">
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import SideBar from './components/commons/SideBar.vue'

export default {
  name: "App",
  components: { SideBar },
  data: () => ({
    langs: [{ name: 'English US', abbr: 'en-US' }, { name: 'Spanish Spain', abbr: 'es-ES' }]
  }),
  computed: {
    ...mapGetters({
      isAuthenticated: "auth/getIsAuthenticated",
    }),
    currentRouteName() {
      return this.$route.name;
    }
  },
};
</script>


<style scoped>
.search-bar-wrapper {
  position: absolute;
  top: 32px;
  right: 32px;
  z-index: 2;
  display: flex;
}

.lang-select {
  max-width: 10.5rem;
}
</style>