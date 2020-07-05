import Vue from "vue";
import Vuex from "vuex";
import moduleAuth from "./auth";
import moduleBook from "./books";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {},
  mutations: {},
  actions: {},
  modules: {
    moduleAuth: moduleAuth,
    moduleBooks: moduleBook
  }
});
