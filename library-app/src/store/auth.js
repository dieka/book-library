import axios from "../axios-main";
import config from "../config/api";
import router from "../router";

const moduleAuth = {
  state: {
    token: null,
    expiresIn: null,
    userInfo: null
  },
  mutations: {
    authUser(state, userData) {
      state.token = userData.token;
      axios.defaults.headers.common["Authorization"] =
        "Bearer " + userData.token;
    },
    storeUser(state, user) {
      state.userInfo = user;
    },
    clearAuth(state) {
      state.token = null;
      state.expiresIn = null;
      state.userInfo = null;
    }
  },
  getters: {
    isAuthenticated(state) {
      if (!state.token) return false;
      return true;
    },
    getUserInfo(state) {
      return state.userInfo;
    },
    getToken(state) {
      return state.token;
    }
  },
  actions: {
    setLogoutTimer({ dispatch }, expiresIn) {
      setTimeout(() => {
        dispatch("logout");
      }, expiresIn * 1000);
    },
    tryAutoLogin({ commit, dispatch }) {
      if (!localStorage.getItem("token")) {
        return false;
      }
      if (new Date() >= localStorage.getItem("expiresDate")) {
        return false;
      }

      commit("authUser", {
        token: localStorage.getItem("token")
      });
      return !!dispatch("fetchUser");
    },
    login({ commit, dispatch }, authData) {
      return axios
        .post(config.API_URL + "oauth/token", {
          username: authData.username,
          password: authData.password,
          grant_type: "password",
          scope: "*",
          client_id: "1",
          client_secret: "8iQsfEoFCIVxnr8UjXmd9zcEzu04B6B8FxmWp0bV"
        })
        .then(res => {
          commit("authUser", {
            token: res.data.access_token
          });
          localStorage.setItem("token", res.data.access_token);
          localStorage.setItem(
            "expiresDate",
            new Date(new Date().getTime() + res.data.expires_in * 1000)
          );
          dispatch("setLogoutTimer", res.data.expires_in);
          dispatch("fetchUser");
          return {
            status: true,
            message: ""
          };
        });
    },
    logout({ commit }) {
      commit("clearAuth");
      localStorage.removeItem("token");
      localStorage.removeItem("expiresDate");
      router.replace("/login");
    },
    fetchUser({ state }) {
      if (!state.token) return;
      return true;
      // return axios
      //   .get(config.API_URL + "users/userinfo", {
      //     headers: {
      //       Authorization: "Bearer " + state.token
      //     }
      //   })
      //   .then(res => {
      //     commit("storeUser", res.data.data);
      //     return true;
      //   })
      //   .catch(error => {
      //     console.log(error);
      //     return false;
      //   });
    }
  }
};

export default moduleAuth;
