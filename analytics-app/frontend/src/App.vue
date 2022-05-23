<template>
  <div class="app">
    <div class="navbar">
      <Navbar2 v-if="!$route.meta.hideNavbar" />
    </div>
    <div class="main-wrapper">
      <router-view class="main"> </router-view>
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
.app {
  background-color: rgba(255, 255, 255, 0.283);
}
.navbar {
  z-index: 1;
  position: sticky;
  top: 0;
}
.main-wrapper {
  background-color: rgb(219, 219, 219);
  margin-left: var(--left-menu-width);
  margin-top: var(--navbar-height);
  height: calc(100vh - var(--navbar-height));
  display: flow-root;
}
.main {
  box-sizing: border-box;
  margin: 5px 5px 5px 5px;
  height: calc(100vh - var(--navbar-height) - 20px);
  background-color: rgb(255, 255, 255);
}
</style>
