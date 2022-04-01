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
        :model="res.languageTexts[calculateIndexByLocale({ locale: selectedLocale })]"
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
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
// import { I18nString } from '../../models';
// import { emptyI18nString } from '../../store/classes';

export default {
  props: {
    labelPrefixI18nSelector: {
      type: String,
      required: true,
    },
    initVal: {
      type: Object,
    },
  },
  data() {
    return {
      selectedLocales: [this.$i18n.fallbackLocale],
      res: {
        languageKeys: this.$i18n.availableLocales,
        languageTexts: this.initVal.languageTexts,
      } ?? {
        languageKeys: this.$i18n.availableLocales,
        languageTexts: Array(this.$i18n.availableLocales.length).fill(''),
      },
    };
  },
  computed: {
    avaliableLocales() {
      return this.$i18n.availableLocales;
    },
    isAddNewLocaleButtonShown() {
      return this.avaliableLocales.length > this.selectedLocales.length;
    },

    ...mapGetters({
      calculateIndexByLocale: 'calculateIndexByLocale',
    }),
  },
  methods: {
    removeSelectedLocale(locale) {
      const foundIndex = this.res.languageKeys.findIndex((k) => k === locale);
      const languageTexts = this.res.languageTexts.map((t, i) => (i === foundIndex ? '' : t));
      this.res = {
        languageKeys: this.res.languageKeys,
        languageTexts,
      };
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
      this.res.languageTexts[this.calculateIndexByLocale({ locale })] = value;
      this.res = {
        languageKeys: this.res.languageKeys,
        languageTexts,
      };
      this.$emit('res', this.res);
    },
  },
};
</script>
