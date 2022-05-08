import { createRouter, createWebHistory } from 'vue-router';

import DummyView1 from './views/DummyView1.vue';
import DummyView2 from './views/DummyView2.vue';
import Home from './views/Home.vue';
import Login from './views/Login.vue'

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
    name: 'Login',
    path: '/login',
    component: Login,
    meta: {
      hideNavbar: true,
    }
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
