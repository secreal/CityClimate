import Vue from "vue";
import Vuex from "vuex";
import BaseModule from "./modules/BaseModule";

Vue.use(Vuex);

const store = new Vuex.Store({
    modules: {
        base: BaseModule
    }
});

export default store;