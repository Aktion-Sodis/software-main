const volatileDummyModule = {
    namespaced: true,
    state: () => ({
        randomNumber: Math.random() * 100,
        message: 'Following random number is from the "volatileDummyModule". It is "volatile" because it is not persisted in the localStorage of the browser. If you refresh the page, you will see a different number.'
    }),
    getters: {
        getRandomNumber: ({ randomNumber }) => randomNumber,
        getMessage: ({ message }) => message
    },
    mutations: {
        setMessage: (state, { newMessage }) => {
            state.message = newMessage
        }
    },
    actions: {}
}

export default volatileDummyModule;
