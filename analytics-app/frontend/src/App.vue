<template>
  <div>
    <div class="navbar">
      <Navbar v-if="!$route.meta.hideNavbar" />
    </div>
    <router-view class="main"> </router-view>
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
:root {
  --bg-color: #2d91be;
  --item-hover: #64aa73;
  --item-active: #feaa3a;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
.navbar {
  z-index: 1;
  position: sticky;
  top: 0;
}
.main {
  text-align: left;
  height: calc(100vh - var(--navbar-height));
}
</style>
