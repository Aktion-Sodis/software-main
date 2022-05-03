<template>
  <div
    class="sidebar"
    :style="{ width: sidebarWidth, transition: sidebarTransition }"
    @mouseover="openSidebar"
    @mouseleave="closeSidebar"
  >
    <div class="sidebar-wrapper">
      <div class="link header">
        <el-image class="image" src="/src/static/aktionSodisSmall.png" />
        <span v-if="!collapsed"> AktionSodis </span>
      </div>
      <div class="content">
        <SidebarLink to="/" icon="fas fa-home">Home</SidebarLink>
        <SidebarLink to="/surveys" icon="fas fa-columns"
          >Fragebögen</SidebarLink
        >
        <SidebarLink to="/dashboard" icon="fas fa-chart-bar"
          >Dashboard</SidebarLink
        >
        <SidebarLink to="/hello-world" icon="fa-solid fa-gear"
          >Einstellungen</SidebarLink
        >
      </div>
      <div class="link authorization">
        <i class="icon fa-solid fa-right-to-bracket" />
        <span v-if="!collapsed"> Login </span>
      </div>
    </div>
  </div>
</template>

<script>
import SidebarLink from "./SidebarLink.vue";
import {
  collapsed,
  openSidebar,
  closeSidebar,
  sidebarWidth,
  sidebarTransition,
} from "./state";
export default {
  props: {},
  components: { SidebarLink },
  setup() {
    return {
      collapsed,
      openSidebar,
      closeSidebar,
      sidebarWidth,
      sidebarTransition,
    };
  },
};
</script>

<style>
:root {
  --sidebar-bg-color: #2d91be;
  --sidebar-item-hover: #64aa73;
  --sidebar-item-active: #feaa3a;
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
  display: flex;
  flex-direction: column;
}
.sidebar-wrapper {
  padding: 0.5em;
}
.sidebar h1 {
  height: 2.5em;
}

.link {
  display: flex;
  align-items: center;
  cursor: pointer;
  position: relative;
  font-weight: 400;
  user-select: none;
  margin: 0.1em 0;
  padding: 0.4em;
  border-radius: 0.2em;
  height: 1.5em;
  color: white;
  text-decoration: none;
}

.link .image {
  flex-shrink: 0;
  width: 25px;
  margin-right: 10px;
}

.link .icon {
  flex-shrink: 0;
  width: 25px;
  margin-right: 10px;
}

.authorization {
  position: absolute;
  bottom: 0;
}
</style>