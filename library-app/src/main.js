import Vue from "vue";
import Vuelidate from "vuelidate";
import VueLodash from "vue-lodash";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Buefy from "buefy";
import "buefy/dist/buefy.css";
import lodash from "lodash";

Vue.config.productionTip = false;

Vue.use(Buefy);
Vue.use(Vuelidate);
Vue.use(VueLodash, { name: "custom", lodash: lodash });

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
