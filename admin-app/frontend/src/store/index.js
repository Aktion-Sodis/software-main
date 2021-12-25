import Vue from "vue";
import Vuex from "vuex";
import VuexPersistence from "vuex-persist";

// import modules
import authModule from "./authModule";
import entitiesModule from "./entitiesModule";

// persist
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
  mutations: {},
  actions: {},
  modules: {
    auth: authModule,
    entities: entitiesModule,
  },
  plugins: [vuexLocal.plugin],
});
