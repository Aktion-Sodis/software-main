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
  data() {
    return {
      langs: [
        { name: 'English US', abbr: 'en-US' },
        { name: 'Español España', abbr: 'es-ES' },
        { name: 'Türkçe Türkiye', abbr: 'tr-TR' },
      ],
    };
  },
};
</script>
