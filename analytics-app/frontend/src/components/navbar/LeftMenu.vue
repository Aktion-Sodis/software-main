<template>
  <div class="left-menu">
    <div class="logo-wrapper">
      <el-image
        class="organization-icon"
        src="/src/static/aktionSodisSmall.png"
      />
      <div class="organization-name">Aktion Sodis</div>
    </div>
    <div class="left-menu-container">
      <div class="sidenav-item">
        <router-link
          class="link"
          :class="{ active: $route.path === '/' }"
          to="/"
        >
          <i class="nav-icon fas fa-home" />
          <a class="nav-text">Home</a>
        </router-link>
      </div>
      <div class="dropdwn-items">
        <div class="dropdwn-btn" @click="toggleDashboard">
          <i class="nav-icon fa-solid fa-database" />
          <a class="nav-text">Dashboards</a>
          <i class="drop-icon fa-solid fa-caret-down"></i>
        </div>
        <div class="dropdwn-content" v-if="!dashboardsCollapsed">
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/dummy-view-1' }"
            to="/data/dummy-view-1"
          >
            <a>Home</a>
          </router-link>
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/export' }"
            to="/data/export"
          >
            <a>Export </a>
          </router-link>
        </div>
      </div>
      <div class="dropdwn-items">
        <div class="dropdwn-btn" @click="toggleData">
          <i class="nav-icon fa-solid fa-database" />
          <a class="nav-text">Data</a>
          <i class="drop-icon fa-solid fa-caret-down"></i>
        </div>
        <div class="dropdwn-content" v-if="!dataCollapsed">
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/dummy-view-1' }"
            to="/data/dummy-view-1"
          >
            <a>Auswertung</a>
          </router-link>
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/export' }"
            to="/data/export"
          >
            <a>Export </a>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

const dashboardsCollapsed = ref(true);
const dataCollapsed = ref(true);

export default {
  setup() {
    return { dashboardsCollapsed, dataCollapsed };
  },
  methods: {
    toggleDashboard() {
      return (dashboardsCollapsed.value = !dashboardsCollapsed.value);
    },
    toggleData() {
      return (dataCollapsed.value = !dataCollapsed.value);
    },
  },
};
</script>

<style scoped>
.left-menu {
  width: var(--left-menu-width);
  background-color: var(--bg-color);
  float: left;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  bottom: 0;
}
.logo-wrapper {
  height: var(--navbar-height);
  display: flex;
  align-items: center;
}
.organization-icon {
  height: 30px;
  width: 30px;
  margin-left: 15px;
}
.organization-name {
  font-size: 25px;
  text-transform: uppercase;
  padding: 0 5px;
}
.left-menu-container {
  display: flex;
  flex-direction: column;
}
.dropdwn-items,
.sidenav-item {
  width: 100%;
  display: flex;
  flex-direction: column;
}

.dropdwn-content,
.dropdwn-btn,
.nav-link,
.link {
  text-decoration: none;
  position: relative;
  float: left;
  color: white;

  cursor: pointer;
  text-align: start;
}
.dropdwn-btn,
.link {
  margin-top: 10px;
  margin-left: 25px;
  margin-right: 15px;
}
.dropdwn-content {
  margin: 0px 57px;
  display: flex;
  flex-direction: column;
}
.dropdwn-item {
  margin: 5px 0;
}
.nav-icon {
  width: 16px;
}
.nav-text {
  font-size: 16px;
  margin-left: 15px;
}
.drop-icon {
  position: relative;
  float: right;
}
</style>
