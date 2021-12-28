import Vue from "vue";
import Vuex from "vuex";
import VuexPersistence from "vuex-persist";

// import modules
import authModule from "./authModule";
import entitiesModule from "./entitiesModule";
import organizationStructureModule from "./organizationStructureModule";

// persist
import authModule from "./authModule";

const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
});

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    lineColors: ["green", "orange", "blue", "red", "yellow", "purple"],
  },
  getters: {
    getLineColors: (state) => state.lineColors,
  },
  state: {},
  mutations: {},
  actions: {},
  modules: {
    auth: authModule,
    entities: entitiesModule,
    os: organizationStructureModule,
  },
  plugins: [vuexLocal.plugin],
});
