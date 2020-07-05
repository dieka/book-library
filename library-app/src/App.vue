<template>
  <div id="container-fluid">
    <Navbar></Navbar>
    <router-view />
  </div>
</template>

<script>
import Navbar from "./components/Navbar";
// @ is an alias to /src
export default {
  components: {
    Navbar
  }
};
</script>
