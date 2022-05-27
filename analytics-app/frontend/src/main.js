import { createApp } from 'vue';
import App from './App.vue';

import { router } from './router';
import store from './store';
import ElementPlus from 'element-plus';
import i18n from './i18n'
import VueApexCharts from "vue3-apexcharts";

import '@fortawesome/fontawesome-free/js/all';
import 'element-plus/dist/index.css';

const app = createApp(App);

app.use(router);
app.use(store);
app.use(ElementPlus);
app.use(i18n)
app.use(VueApexCharts)

app.mount('#app');
