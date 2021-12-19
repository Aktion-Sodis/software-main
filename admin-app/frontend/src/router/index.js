import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store";

import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import OrganizationStructure from "../views/OrganizationStructure.vue";
import BaseData from "../views/BaseData.vue";
import Technologies from "../views/Technologies.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
    meta: {
      requiresAuth: false,
    },
  },
  {
    path: "/organization-structure",
    name: "OrganizationStructure",
    component: OrganizationStructure,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: "/base-data",
    name: "BaseData",
    component: BaseData,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: "/technologies",
    name: "Technologies",
    component: Technologies,
    meta: {
      requiresAuth: true,
    },
  },
  {
    path: "/about",
    name: "About",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!store.getters["auth/getIsAuthenticated"]) {
      // redirect to login page if not authenticated
      store.dispatch("auth/deleteSession"); // delete state data for consistency
      next({ name: "Login" });
    } else {
      next();
    }
  } else {
    next(); // does not require auth, make sure to always call next()!
  }
});

export default router;
