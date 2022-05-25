import { createRouter, createWebHistory } from 'vue-router';

import DummyView1 from './views/DummyView1.vue';
import DummyView2 from './views/DummyView2.vue';
import Home from './views/Home.vue';
import Login from './views/Login.vue';
import Data from './views/data/Data.vue';
import Export from './views/data/DataExport.vue';
import DataEvaluation from './views/Data/DataEvaluation.vue';
import Questions from './views/Data/Questions.vue';
import Filter from './views/Data/Filter.vue';

import Dashboard from './views/Dashboard.vue'

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
      { path: 'dummy-view-1', component: DummyView1 },
      { path: 'dummy-view-2', component: DummyView2 },
      { path: 'export', component: Export },
      { path: 'filter', component: Filter },
      { 
        path: 'evaluation',
        component: DataEvaluation,
        children: [
          { path: 'questions', component: Questions },
        ]
      },
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
