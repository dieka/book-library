import axios from "../axios-main";
import config from "../config/api";

const moduleBook = {
  state: {
    searchedText: "",
    perPage: 10,
    currentPage: 1,
    lastPage: 10,
    totalData: 0,
    data: []
  },
  mutations: {
    setData(state, data) {
      state.data = data.data;
      state.currentPage = data.current_page;
      state.lastPage = data.last_page;
      state.totalData = data.total;
      state.searchedText = data.searchedText;
    },
    setPage(state, value) {
      state.currentPage = value;
    }
  },
  actions: {
    fetchData({ commit, state }, data) {
      return axios
        .get(config.API_URL + "book", {
          params: {
            search: data.searchedText ?? state.searchedText,
            take: data.perPage ?? state.perPage,
            page: data.currentPage ?? state.currentPage
          }
        })
        .then(value => {
          var result = {
            data: value.data.data.data,
            current_page: value.data.data.current_page,
            last_page: value.data.data.last_page,
            total_data: value.data.datatotal_data,
            searchedText: value.searchedText
          };
          commit("setData", result);
          return true;
        })
        .catch(value => {
          console.log(value.message);
          return false;
        });
    },
    nextPage({ dispatch, state }) {
      return dispatch("fetchData", {
        searchedText: state.searchedText,
        perPage: state.perPage,
        currentPage: state.currentPage + 1
      });
    },
    previousPage({ dispatch, state }) {
      return dispatch("fetchData", {
        searchedText: state.searchedText,
        perPage: state.perPage,
        currentPage: state.currentPage - 1
      });
    },
    updatePage({ dispatch, state }, page) {
      return dispatch("fetchData", {
        searchedText: state.searchedText,
        perPage: state.perPage,
        currentPage: page
      });
    },
    create({ state }, data) {
      console.log(state);
      return axios.post(config.API_URL + "book", data);
    },
    update({ state }, data) {
      console.log(state);
      return axios.post(config.API_URL + "book/" + data.id, data);
    },
    delete({ dispatch }, id) {
      return axios.delete(config.API_URL + "book/" + id).then(() => {
        dispatch("fetchData", {
          searchedText: null,
          perPage: null,
          currentPage: null
        });
      });
    },
    get({ state }, id) {
      console.log(state);
      return axios.get(config.API_URL + "book/" + id);
    }
  }
};

export default moduleBook;
