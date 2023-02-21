const AuthModule = {
    namespaced: true,

    state: {
        identity: null,
    },

    getters: {
        identity: (state) => state.identity,
    },

    mutations: {
        identity: (state, payload) => state.identity = payload,
    },
};

export default AuthModule;