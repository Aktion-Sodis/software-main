import { createI18n } from "vue-i18n";

import en from './en-US.json';
import de from './de-DE.json';

const i18n = createI18n({
  legacy: false,
  locale: 'en',
  globalInjection: true,
  messages: {
    en,
    de
  }
});

export default i18n;