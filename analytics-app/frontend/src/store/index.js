import { createStore } from 'vuex';
import VuexPersistence from 'vuex-persist';

// import modules
import persistedDummyModule from './persistedDummyModule';
import volatileDummyModule from './volatileDummyModule';

const vuexPersistence = new VuexPersistence({
  storage: localStorage,
  modules: ['persistedDummyModule'],
});

const store = createStore({
  state: {
    message: 'Hello world!',
  },
  getters: {
    getHelloWorld: ({ message }) => message,
    helloWorldWithoutSpace: (_, { getHelloWorld }) =>
      getHelloWorld.replaceAll(' ', ''),
  },
  mutations: {
    setMessage: (state, { newMessage }) => {
      state.message = newMessage;
    },
  },
  actions: {
    exampleButtonHandler: ({ commit, getters }) => {
      if (getters.getHelloWorld === 'Hello world!') {
        commit('setMessage', { newMessage: 'Hello Nisaba!' });
      } else {
        commit('setMessage', { newMessage: 'Hello world!' });
      }
    },
  },
  modules: {
    persistedDummyModule,
    volatileDummyModule,
  },
  plugins: [vuexPersistence.plugin],
});

export default store;
