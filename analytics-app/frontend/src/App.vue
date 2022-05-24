<template>
  <div class="app">
    <div class="navbar">
      <Navbar2 v-if="!$route.meta.hideNavbar" />
    </div>
    <div class="main-wrapper">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Navbar2 from "./components/navbar/Navbar2.vue";

export default {
  components: { Navbar2 },
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
.main-wrapper {
  background-color: rgb(236, 245, 254);
  margin-left: var(--left-menu-width);
  margin-top: var(--navbar-height);
  height: calc(100vh - var(--navbar-height));
  width: calc(100vw - var(--left-menu-width));
}
</style>
