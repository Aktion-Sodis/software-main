import Vue from 'vue';
import VueRouter from 'vue-router';
import store from '../store';
import i18n from '../i18n';

import Home from '../views/Home.vue';
import OrganizationStructure from '../views/OrganizationStructure.vue';
import BaseData from '../views/BaseData.vue';
import Interventions from '../views/Interventions.vue';
import Auth from '../views/Auth.vue';
import { syncStatusDict } from '../store/constants';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: {
      requiresAuth: true,
      shouldBeSynced: false,
      title: i18n.t('general.routes.home'),
    },
  },
  {
    path: '/login',
    name: 'Login',
    component: Auth,
    meta: {
      requiresAuth: false,
      shouldBeSynced: false,
      title: i18n.t('general.routes.login'),
    },
  },
  {
    path: '/complete-user-info',
    name: 'CompleteUserInfo',
    component: Auth,
    meta: {
      requiresAuth: false,
      shouldBeSynced: false,
      title: i18n.t('general.routes.completeUserInfo'),
    },
  },
  {
    path: '/change-password',
    name: 'ChangePassword',
    component: Auth,
    meta: {
      requiresAuth: false,
      shouldBeSynced: false,
      title: i18n.t('general.routes.changePassword'),
    },
  },
  {
    path: '/forgot-password',
    name: 'ForgotPassword',
    component: Auth,
    meta: {
      requiresAuth: false,
      shouldBeSynced: false,
      title: i18n.t('general.routes.forgotPassword'),
    },
  },
  {
    path: '/organization-structure',
    name: 'OrganizationStructure',
    component: OrganizationStructure,
    meta: {
      requiresAuth: true,
      shouldBeSynced: true,
      title: i18n.t('general.routes.organizationStructure'),
    },
  },
  {
    path: '/base-data',
    name: 'BaseData',
    component: BaseData,
    meta: {
      requiresAuth: true,
      shouldBeSynced: true,
      title: i18n.t('general.routes.baseData'),
    },
  },
  {
    path: '/interventions',
    name: 'Interventions',
    component: Interventions,
    meta: {
      requiresAuth: true,
      shouldBeSynced: true,
      title: i18n.t('general.routes.interventions'),
    },
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    meta: {
      requiresAuth: false,
      shouldBeSynced: false,
      title: i18n.t('general.routes.about'),
    },
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

router.beforeEach(async (to, from, next) => {
  store.commit('auth/updateRouteActivity', { root: true });
  await Vue.nextTick();
  if (
    (!from.name || from.meta.requiresAuth)
    && store.getters['auth/lastRouteActivityDiffTooLarge']
    && store.getters['auth/getIsAuthenticated']
    && !store.getters['auth/getRememberSession']
  ) {
    store.dispatch('auth/deleteSession', { root: true });
    next({ name: 'Login' });
    store.dispatch(
      'FEEDBACK_UI/showFeedbackForDuration',
      {
        type: 'warning',
        text: i18n.t('general.warningCodes.sessionExpired'),
      },
      { root: true },
    );
  }
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!store.getters['auth/getIsAuthenticated']) {
      // redirect to login page if not authenticated
      store.dispatch('auth/deleteSession'); // delete state data for consistency
      next({ name: 'Login' });
    } else {
      if (to.meta.shouldBeSynced) {
        store.dispatch('SYNC_UI/refreshHandler', { routeName: to.name }, { root: true });
      } else {
        store.commit('SYNC_UI/setStatus', { newStatus: syncStatusDict.synched }, { root: true });
      }
      next();
    }
  } else {
    if (to.meta.shouldBeSynced) {
      store.dispatch('SYNC_UI/refreshHandler', { routeName: to.name }, { root: true });
    } else {
      store.commit('SYNC_UI/setStatus', { newStatus: syncStatusDict.synched }, { root: true });
    }
    next(); // does not require auth, make sure to always call next()!
  }
});

const DEFAULT_TITLE = 'Admin-App';
router.afterEach((to) => {
  // Use next tick to handle router history correctly
  // see: https://github.com/vuejs/vue-router/issues/914#issuecomment-384477609
  Vue.nextTick(() => {
    document.title = `${to.meta.title} · Admin-App` || DEFAULT_TITLE;
  });
});

export default router;
