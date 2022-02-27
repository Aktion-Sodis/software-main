import { v4 as uuidv4 } from 'uuid';

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
    getIsAuthenticated: ({ isAuthenticated }) => isAuthenticated,
    getToken: ({ token }) => token,
    getUserId: ({ userId }) => userId,
    getEmail: ({ email }) => email,
    getUsername: ({ username }) => username,
    getFirstname: ({ firstname }) => firstname,
    getLastname: ({ lastname }) => lastname,

    credentials: (_, {
      getUserId, getEmail, getUsername, getFirstname, getLastname,
    }) => ({
      userId: getUserId,
      email: getEmail,
      username: getUsername,
      firstname: getFirstname,
      lastname: getLastname,
    }),
  },
  mutations: {
    setIsAuthenticated(state, { newValue }) {
      state.isAuthenticated = newValue;
    },
    setCredentials(state, { newCredentials }) {
      state.userId = newCredentials.userId;
      state.email = newCredentials.email;
      state.username = newCredentials.username;
      state.firstname = newCredentials.firstname;
      state.lastname = newCredentials.lastname;
    },
    setToken(state, { newToken }) {
      state.token = newToken;
    },
  },
  actions: {
    signIn({ commit }, { credentials }) {
      // TODO: Here an API call to fetch user information & authentication
      // const password = payload.password;
      // const persistSession = payload.rememberMe;

      commit('setCredentials', {
        newCredentials: {
          userId: uuidv4(),
          email: 'dummy@mail.com',
          username: credentials.username,
          firstname: 'Ahmet',
          lastname: 'Polat',
        },
      });
      commit('setToken', { newToken: uuidv4() });
      commit('setIsAuthenticated', { newValue: true });
    },
    deleteSession({ commit }) {
      // TODO: Here an API call to fetch user information & authentication
      // const password = payload.password;
      // const persistSession = payload.rememberMe;

      commit('setCredentials', {
        newCredentials: {
          userId: null,
          email: null,
          username: null,
          firstname: null,
          lastname: null,
        },
      });
      commit('setToken', { newToken: null });
      commit('setIsAuthenticated', { newValue: false });
    },
  },
};

export default authModule;
