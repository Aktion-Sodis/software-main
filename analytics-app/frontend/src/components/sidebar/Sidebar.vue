<template>
  <div @mouseover="openSidebar" @mouseleave="closeSidebar" class="sidebar" :style="{ width: sidebarWidth, transition: sidebarTransition }">
    <h1>
      <span v-if="collapsed">
        <div>V</div>
        <div>S</div>
      </span>
      <span v-else>Vue Sidebar</span>
    </h1>
    <SidebarLink to="/" icon="fas fa-home">Home</SidebarLink>
    <SidebarLink to="/dummy-view-2" icon="fas fa-columns">Fragebögen</SidebarLink>
    <SidebarLink to="/dashboards" icon="fas fa-chart-bar">Dashboards</SidebarLink>
    <SidebarLink to="/hello-world" icon="fa-solid fa-gear">Einstellungen</SidebarLink>
  </div>
</template>

<script>
import SidebarLink from "./SidebarLink.vue"
import { collapsed, openSidebar, closeSidebar, sidebarWidth, sidebarTransition } from './state'
export default {
  props: {},
  components: { SidebarLink },
  setup() {
    return { collapsed, openSidebar, closeSidebar, sidebarWidth, sidebarTransition }
  }
}
</script>

<style>
:root {
  --sidebar-bg-color: #2f855a;
  --sidebar-item-hover: #38a169;
  --sidebar-item-active: #276749;
}
</style>

<style scoped>
.sidebar {
  color: white;
  background-color: var(--sidebar-bg-color);
  float: left;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  bottom: 0;
  padding: 0.5em;
  transition: 0.3s ease;
  display: flex;
  flex-direction: column;
}
.sidebar h1 {
  height: 2.5em;
}

</style>