<template>
  <v-select
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
};
</script>
