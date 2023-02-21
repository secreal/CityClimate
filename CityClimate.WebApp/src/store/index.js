import Vue from "vue";
import Vuex from "vuex";
import AuthModule from "./modules/AuthModule";
import FilterModule from "./modules/FilterModule";

Vue.use(Vuex);

const store = new Vuex.Store({
    modules: {
        auth: AuthModule,
        filter: FilterModule
    }
});

export default store;