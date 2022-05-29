import { createApp } from 'vue';
import App from './App.vue';

import { router } from './router';
import store from './store';

import ElementPlus from 'element-plus';
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

import i18n from './i18n'
import VueApexCharts from "vue3-apexcharts";

import '@fortawesome/fontawesome-free/js/all';
import 'element-plus/dist/index.css';

const app = createApp(App);

app.use(router);
app.use(store);

app.use(i18n)
app.use(VueApexCharts)

app.use(ElementPlus);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.mount('#app');
