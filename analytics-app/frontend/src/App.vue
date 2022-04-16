<template>
  <div>
    <Sidebar />
    <div :style="{ 'margin-left': sidebarWidth, transition: sidebarTransition}">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Sidebar from './components/sidebar/Sidebar.vue'
import { sidebarWidth, sidebarTransition } from './components/sidebar/state.js'
export default {
  components: { Sidebar },
  setup() {
    return { sidebarWidth, sidebarTransition }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
