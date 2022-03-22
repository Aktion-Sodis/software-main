<template>
  <div class="d-flex flex-column">
    <div
      v-for="selectedLocale in selectedLocales"
      :key="selectedLocale"
      class="d-flex align-center"
    >
      <slot
        :inputHandler="(e) => inputHandler(e, selectedLocale)"
        name="text-input"
        :label="`${$t(labelPrefixI18nSelector)} (${selectedLocale})`"
      ></slot>
      <div class="pb-7" v-if="selectedLocale !== $i18n.fallbackLocale">
        <v-btn
          color="primary"
          outlined
          icon
          class="ml-2"
          @click="removeSelectedLocale(selectedLocale)"
        >
          <v-icon> mdi-minus </v-icon>
        </v-btn>
      </div>
    </div>
    <div class="d-flex justify-center" v-if="isAddNewLocaleButtonShown">
      <v-btn color="primary" rounded x-large @click="addNewLocale">
        <v-icon class="mr-2"> mdi-plus </v-icon>
        <span class="overflow-hidden">
          {{ $t('general.form.addInNewLocale') }}
        </span>
      </v-btn>
    </div>
    {{ res }}
  </div>
</template>

<script>
import { I18nString } from '../../models';

export default {
  props: {
    labelPrefixI18nSelector: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      selectedLocales: [this.$i18n.fallbackLocale],
      res: new I18nString({
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(null),
      }),
    };
  },
  computed: {
    avaliableLocales() {
      return this.$i18n.availableLocales;
    },
    isAddNewLocaleButtonShown() {
      return this.avaliableLocales.length > this.selectedLocales.length;
    },
  },
  methods: {
    removeSelectedLocale(locale) {
      const foundIndex = this.res.languageKeys.findIndex((k) => k === locale);
      const languageTexts = this.res.languageTexts.map((t, i) => (i === foundIndex ? null : t));
      this.res = new I18nString({
        languageKeys: this.res.languageKeys,
        languageTexts,
      });
      this.selectedLocales = this.selectedLocales.filter((l) => l !== locale);
    },
    addNewLocale() {
      const availableLocales = this.avaliableLocales;
      const newLocale = availableLocales.find((l) => !this.selectedLocales.includes(l));
      this.selectedLocales.push(newLocale);
    },
    inputHandler(value, locale) {
      if (!value && value !== '') return;
      const foundIndex = this.res.languageKeys.findIndex((k) => k === locale);
      const languageTexts = this.res.languageTexts.map((t, i) => (i === foundIndex ? value : t));
      this.res = new I18nString({
        languageKeys: this.res.languageKeys,
        languageTexts,
      });

      this.$emit('res', this.res);
    },
  },
};
</script>
