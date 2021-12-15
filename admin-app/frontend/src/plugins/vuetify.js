import Vue from "vue";
import Vuetify from "vuetify/lib/framework";
import colors from "vuetify/lib/util/colors";

Vue.use(Vuetify);

/* Vuetify standard:
{
    primary: '#1976D2',
    secondary: '#424242',
    accent: '#82B1FF',
    error: '#FF5252',
    info: '#2196F3',
    success: '#4CAF50',
    warning: '#FFC107',
}
*/

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: colors.indigo,
        "primary-dark": colors.indigo.darken1,
        secondary: colors.red.lighten4,
        accent: colors.indigo.base,
      },
    },
  },
});
