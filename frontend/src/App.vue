<template>
  <v-app>
    <SideBar v-if="isAuthenticated" />

    <div class="search-bar-wrapper">
      <!-- Language switch is planned only for development -->
      <v-select
        v-model="$root.$i18n.locale"
        :items="langs"
        item-text="name"
        item-value="abbr"
        label="Change lang"
        outlined
        dense
        class="lang-select"
        style="margin-right: 1rem;"
      ></v-select>
      <v-text-field
        :label="$t('general.search-box')"
        prepend-inner-icon="mdi-magnify"
        outlined
        dense
        background-color="grey"
        dark
      ></v-text-field>
    </div>

    <v-main class="ml-16">
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
    })
  },
};
</script>


<style scoped>
.search-bar-wrapper {
  position: absolute;
  top: 32px;
  right: 32px;
  z-index: 1;
  display: flex;
}

.lang-select {
  max-width: 11rem;
}
</style>