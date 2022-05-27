import { createRouter, createWebHistory } from 'vue-router';

import Home from './views/home/Home.vue';

import Login from './views/login/Login.vue';

import Dashboard from './views/dashboards/Dashboard.vue'

import Data from './views/data/data.vue';
import Export from './views/data/dataExport.vue';
import Questions from './views/data/Questions.vue';
import Filter from './views/data/Filter.vue';



export const routes = [
  {
    name: 'Home',
    path: '/',
    component: Home,
  },
  {
    name: 'Login',
    path: '/login',
    component: Login,
    meta: {
      hideNavbar: true,
    }
  },
  { 
    name: 'Data',
    path: '/data',
    component: Data,
    children: [
      { path: 'export', component: Export },
      { path: 'filter', component: Filter },
      { path: 'questions', component: Questions },
    ],
  },
  {
    name: 'Dashboard',
    path: '/dashboard',
    component: Dashboard,
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
