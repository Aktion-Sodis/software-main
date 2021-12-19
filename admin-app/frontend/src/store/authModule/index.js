import { v4 as uuidv4 } from "uuid";

const authModule = {
  namespaced: true,
  state: () => ({
    isAuthenticated: false,
    token: null,
    userId: null,
    email: null,
    username: null,
    firstname: null,
    lastname: null,
  }),
  getters: {
    getIsAuthenticated: (state) => state.isAuthenticated,
    getCredentials: (state) => ({
      userId: state.userId,
      email: state.email,
      firstname: state.firstname,
      lastname: state.lastname,
    }),
  },
  mutations: {
    setIsAuthenticated(state, payload) {
      state.isAuthenticated = payload;
    },
    setCredentials(state, payload) {
      state.userId = payload.userId;
      state.email = payload.email;
      state.username = payload.username;
      state.firstname = payload.firstname;
      state.lastname = payload.lastname;
    },
    setToken(state, payload) {
      state.token = payload;
    },
  },
  actions: {
    signIn({ commit }, payload) {
      // Here an axios call to fetch user information & authentication
      // const password = payload.password;
      // const persistSession = payload.rememberMe;

      commit("setCredentials", {
        userId: uuidv4(),
        email: "dummy@mail.com",
        username: payload.username,
        firstname: "Ahmet",
        lastname: "Polat",
      });
      commit("setToken", uuidv4());
      commit("setIsAuthenticated", true);
      return true;
    },
    deleteSession({ commit }) {
      // Here an axios call to fetch user information & authentication
      // const password = payload.password;
      // const persistSession = payload.rememberMe;

      commit("setCredentials", {
        userId: null,
        email: null,
        username: null,
        firstname: null,
        lastname: null,
      });
      commit("setToken", null);
      commit("setIsAuthenticated", false);
      return true;
    },
  },
};

export default authModule;
