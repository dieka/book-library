<template>
  <b-navbar :fixed-top="true">
    <template slot="brand">
      <b-navbar-item tag="router-link" :to="{ path: '/' }">
        <h1 style="font-weight: bold; color: #714DD2; font-size:18px;">
          B-Lib
        </h1>
      </b-navbar-item>
    </template>
    <template slot="start">
      <b-navbar-item tag="router-link" :to="{ path: '/' }">
        Home
      </b-navbar-item>
      <b-navbar-item tag="router-link" :to="{ path: '/about' }">
        About
      </b-navbar-item>
      <b-navbar-dropdown label="Book">
        <b-navbar-item tag="router-link" :to="{ path: '/book' }">
          Data Listing
        </b-navbar-item>
        <b-navbar-item tag="router-link" :to="{ path: '/book/create' }">
          Create a new Book
        </b-navbar-item>
      </b-navbar-dropdown>
    </template>

    <template slot="end">
      <b-navbar-item tag="div">
        <div class="buttons">
          <a class="button is-primary" v-if="isAuthenticated" @click="logout">
            <strong>Logout</strong>
          </a>
          <router-link
            class="button is-primary"
            :to="{ path: '/login' }"
            v-if="!isAuthenticated"
          >
            <strong>Log in</strong>
          </router-link>
        </div>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>

<script>
export default {
  name: "Navbar",
  computed: {
    isAuthenticated() {
      return this.$store.getters.isAuthenticated;
    }
  },
  methods: {
    logout() {
      this.$store.dispatch("logout").then(() => {
        this.$buefy.toast.open("Account logged out!");
      });
    }
  }
};
</script>

<style></style>
