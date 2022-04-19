import { createRouter, createWebHistory } from 'vue-router';

import DummyView1 from './views/DummyView1.vue';
import DummyView2 from './views/DummyView2.vue';
import Home from './views/Home.vue';
import Surveys from './views/Surveys.vue';
import Questions from './views/Questions.vue';

export const routes = [
  {
    name: 'Home',
    path: '/',
    component: Home,
  },
  {
    name: 'DummyView1',
    path: '/dummy-view-1',
    component: DummyView1,
  },
  {
    name: 'DummyView2',
    path: '/dummy-view-2',
    component: DummyView2,
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
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
