<template>
  <v-menu v-if="$vuetify.breakpoint.name === 'xs'" rounded="lg" offset-y>
    <template v-slot:activator="{ attrs, on }">
      <v-btn fab color="primary" v-bind="attrs" v-on="on">
        <v-icon class="mx-auto">mdi-web</v-icon>
      </v-btn>
    </template>
    <v-list>
      <v-list-item v-for="lang in langs" :key="lang.abbr" link @click="updateLocale(lang.abbr)">
        <v-list-item-title>{{ lang.name }}</v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
  <v-select
    v-else
    v-model="$root.$i18n.locale"
    :items="langs"
    item-text="name"
    item-value="abbr"
    outlined
    dense
    background-color="grey"
    style="max-width: 10.5rem"
    dark
  ></v-select>
</template>

<script>
export default {
  name: 'LangSelect',
  computed: {
    langs() {
      return this.$i18n.availableLocales.map((l) => ({
        name: this.$t('reflectiveData.localeVerboseName', l),
        abbr: l,
      }));
    },
  },
  methods: {
    updateLocale(locale) {
      this.$i18n.locale = locale;
    },
  },
};
</script>
