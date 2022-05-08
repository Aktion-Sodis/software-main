<template>
  <div>
    <Navbar />
    <router-view> </router-view>
  </div>
</template>

<script>
import Navbar from "./components/navbar/Navbar.vue";

export default {
  components: { Navbar },
};
</script>

<style>
* {
  padding: 0px;
  margin: 0px;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
