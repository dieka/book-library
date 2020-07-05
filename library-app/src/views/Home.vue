<template>
  <section class="hero is-primary  is-fullheight-with-navbar">
    <div class="hero-body">
      <div class="container">
        <h1 class="title">
          Book Collections
        </h1>
        <h2 class="subtitle">
          Our latest books..
        </h2>

        <transition-group name="fade" tag="div" class="columns">
          <div class="column" v-for="(item, index) in data" :key="item.id">
            <div class="card">
              <div class="card-content">
                <div style="font-weight: bold; text-align:center;">
                  {{ item.title }}
                </div>
                <hr />
                <div class="columns">
                  <div class="column">
                    <img :src="'images/cover' + (index + 1) + '.jpg'" />
                  </div>
                  <div class="column">
                    <div class="content">
                      {{ item.synopsis.substr(0, 90) }}
                      <br />
                      <div style="font-weight:500">{{ item.author }}</div>
                    </div>
                  </div>
                </div>
              </div>
              <footer class="card-footer">
                <a href="#" class="card-footer-item" @click="read">Read Book</a>
              </footer>
            </div>
          </div>
        </transition-group>
      </div>
    </div>
  </section>
</template>

<script>
import axios from "../axios-main";
// @ is an alias to /src
export default {
  name: "Home",
  data() {
    return {
      data: []
    };
  },
  mounted() {
    axios
      .get("book/latest", {
        params: {
          take: 4
        }
      })
      .then(value => {
        this.data = value.data.data;
      });
  },
  methods: {
    read() {
      this.$buefy.toast.open("Sorry, development in progress..");
    }
  }
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>
