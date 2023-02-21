const BaseModule = {
    namespaced: true,

    state: {
        listCountry: null,
        listCity: null,
        climate: null,
    },

    getters: {
        listCountry: (state) => state.listCountry,
        listCity: (state) => state.listCity,
        climate: (state) => state.climate,
    },

    mutations: {
        listCountry: (state, payload) => state.listCountry = payload,
        listCity: (state, payload) => state.listCity = payload,
        climate: (state, payload) => state.climate = payload,
    },
};

export default BaseModule;