import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from "./router";
import mixin from "./mixin";
import store from "./store";

Vue.config.productionTip = false


//// mixin
Vue.mixin(mixin);

new Vue({
  router,
  vuetify,
  store,
  render: (h) => h(App),
}).$mount('#app')
