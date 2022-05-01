import { createRouter, createWebHistory } from 'vue-router'

import Home from './views/Home.vue'
import Surveys from './views/Surveys.vue'
import Questions from './views/Questions.vue'
import Login from './views/Login.vue'

export const routes = [
  {
    name: 'Home',
    path: '/',
    component: Home,
  },
  {
    name: 'Surveys',
    path: '/surveys',
    component: Surveys,
  },
  {
    name: 'Questions',
    path: '/questions',
    component: Questions,
  },
  {
    name: 'Login',
    path: '/login',
    component: Login,
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
