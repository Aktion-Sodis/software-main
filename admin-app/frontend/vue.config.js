module.exports = {
  transpileDependencies: ['vuetify'],

  pluginOptions: {
    i18n: {
      locale: 'en',
      fallbackLocale: 'es',
      localeDir: 'locales',
      enableInSFC: true,
      enableBridge: false,
    },
  },

  devServer: {
    overlay: {
      warnings: true,
      errors: true,
    },
  },
};
