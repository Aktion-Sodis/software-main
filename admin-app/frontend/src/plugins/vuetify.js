import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';
import colors from 'vuetify/lib/util/colors';

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
        primary: '#723D46',
        'primary-dark': '#472D30',
        secondary: '#E26D5C',
        accent: colors.indigo.base,
        warning: colors.red.darken4,
      },
    },
  },
});
