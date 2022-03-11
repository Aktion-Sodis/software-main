const persistedDummyModule = {
  namespaced: true,
  state: () => ({
    randomNumber: Math.random() * 100,
    message:
      'This following number, however, comes from the module "persistedDummyModule", which is saved in the localStorage of the browser. So once a state variable acquires a value, it is remembered and remains after refresh. Make sure that you clicked on the Example Button in Home at least once for the persistence to work.',
  }),
  getters: {
    getRandomNumber: ({ randomNumber }) => randomNumber,
    getMessage: ({ message }) => message,
  },
  mutations: {
    setMessage: (state, { newMessage }) => {
      state.message = newMessage;
    },
  },
  actions: {},
};

export default persistedDummyModule;
