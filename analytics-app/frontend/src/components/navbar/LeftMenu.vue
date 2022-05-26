<template>
  <div class="left-menu" :class="{ collapsed: SideBarCollapsed }">
    <div class="logo-wrapper" @click="printSBC">
      <el-image
        class="organization-icon"
        src="/src/static/aktionSodisSmall.png"
      />
      <div class="organization-name" :class="{ collapsed: SideBarCollapsed }">
        Aktion Sodis
      </div>
    </div>
    <div class="left-menu-container">
      <div class="sidenav-item">
        <router-link
          class="link"
          :class="{ active: $route.path === '/' }"
          to="/"
        >
          <i class="nav-icon fas fa-home" />
          <a class="nav-text" :class="{ collapsed: SideBarCollapsed }">{{
            $t("navbar.home")
          }}</a>
        </router-link>
      </div>
      <div class="dropdwn-items">
        <div class="dropdwn-btn" @click="toggleDashboard">
          <i class="nav-icon fa-solid fa-database" />
          <a class="nav-text" :class="{ collapsed: SideBarCollapsed }">{{
            $t("navbar.dashboards")
          }}</a>
          <div class="drop-icon" :class="{ collapsed: SideBarCollapsed }">
            <i class="fa-solid fa-caret-down"></i>
          </div>
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
          <a class="nav-text" :class="{ collapsed: SideBarCollapsed }">{{
            $t("navbar.data")
          }}</a>
          <div class="drop-icon" :class="{ collapsed: SideBarCollapsed }">
            <i class="fa-solid fa-caret-down"></i>
          </div>
        </div>
        <div class="dropdwn-content" v-if="!dataCollapsed">
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/evaluation' }"
            to="/data/evaluation"
          >
            <a>{{ $t("navbar.evaluation") }}</a>
          </router-link>
          <router-link
            class="nav-link"
            :class="{ active: $route.path === '/data/export' }"
            to="/data/export"
          >
            <a>{{ $t("navbar.export") }} </a>
          </router-link>
        </div>
      </div>
      <NavbarDropdown></NavbarDropdown>
      <NavbarItem></NavbarItem>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { mapState } from "vuex";

import NavbarItem from "./NavbarItem.vue";
import NavbarDropdown from "./NavbarDropdown.vue";

const dashboardsCollapsed = ref(true);
const dataCollapsed = ref(true);

export default {
  components: { NavbarItem, NavbarDropdown },
  setup() {
    return { dashboardsCollapsed, dataCollapsed };
  },
  computed: {
    ...mapState({
      SideBarCollapsed: (state) => state.NavbarAtributes.SideBarCollapsed,
    }),
  },
  methods: {
    toggleDashboard() {
      return (dashboardsCollapsed.value = !dashboardsCollapsed.value);
    },
    toggleData() {
      return (dataCollapsed.value = !dataCollapsed.value);
    },
    printSBC() {
      console.log(this.SideBarCollapsed);
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
.left-menu.collapsed {
  width: var(--left-menu-width-collapsed);
}

.logo-wrapper {
  height: var(--navbar-height);
  display: flex;
  margin-top: 20px;
  margin-left: 5px;
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
.organization-name.collapsed {
  display: none;
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
  padding: 15px 15px 15px 25px;
}
.dropdwn-btn:hover,
.link:hover,
.nav-link:hover {
  background-color: var(--item-hover);
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
.nav-text.collapsed {
  display: none;
}
.drop-icon {
  position: relative;
  float: right;
}
.drop-icon.collapsed {
  visibility: hidden;
  display: none;
}
</style>
