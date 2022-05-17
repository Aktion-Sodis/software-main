<template>
  <div class="navbar-wrapper">
    <div class="organization-wrapper">
      <el-image
        class="organization-icon"
        src="/src/static/aktionSodisSmall.png"
      />
      <div class="organization-name">Aktion Sodis</div>
    </div>
    <div class="navbar" :class="{ collapsed: navbarCollapsed }">
      <router-link
        class="link"
        :class="{ active: $route.path === '/' }"
        to="/"
        @click="toggleNavbar"
      >
        <i class="icon fas fa-home" />
        Home
      </router-link>
      <router-link
        class="link"
        :class="{ active: $route.path === '/dashboard' }"
        to="/dashboard"
        @click="toggleNavbar"
      >
        <i class="icon fas fa-chart-bar" />
        Dashboard
      </router-link>
      <div
        class="dropdown"
        @mouseleave="hideContent"
        @mouseover="showContent"
        @click="toggleContent"
      >
        <div
          class="dropbtn"
          :class="{
            active: $route.path.split('/')[1] === 'data',
            open: !dropdownCollapsed,
          }"
        >
          <i class="icon fa-solid fa-database" />
          Data
          <i class="icon fa-solid fa-caret-down"></i>
        </div>
        <div class="dropdown-content" v-show="!dropdownCollapsed">
          <router-link
            class="link"
            :class="{ active: $route.path === '/data/dummy-view-1' }"
            to="/data/dummy-view-1"
            @click="toggleNavbar"
          >
            <i class="icon fa-solid fa-database" />
            Home1
          </router-link>
          <router-link
            class="link"
            :class="{ active: $route.path === '/data/dummy-view-2' }"
            to="/data/dummy-view-2"
            @click="toggleNavbar"
          >
            <i class="icon fa-solid fa-download"></i>
            Auswertung
          </router-link>
          <router-link
            class="link"
            :class="{ active: $route.path === '/data/export' }"
            to="/data/export"
            @click="toggleNavbar"
          >
            <i class="icon fa-solid fa-download"></i>
            Export
          </router-link>
        </div>
      </div>
    </div>
    <div class="settings">
      <router-link class="link" to="/login">
        <i class="icon fa-solid fa-arrow-right-to-bracket" />
        Login
      </router-link>
      <div class="burger" @click="toggleNavbar">
        <i class="burger-icon fa-solid fa-bars" />
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

const navbarCollapsed = ref(true);
const dropdownCollapsed = ref(true);

export default {
  setup() {
    return { dropdownCollapsed, navbarCollapsed };
  },
  methods: {
    showContent() {
      dropdownCollapsed.value = false;
      console.log(dropdownCollapsed.value);
      console.log(this.$route.path.split("/")[1]);
      return dropdownCollapsed.value;
    },
    hideContent() {
      dropdownCollapsed.value = true;
      console.log(dropdownCollapsed.value);
      return dropdownCollapsed.value;
    },
    toggleContent() {
      dropdownCollapsed.value = !dropdownCollapsed.value;
      return dropdownCollapsed.value;
    },
    toggleNavbar() {
      navbarCollapsed.value = !navbarCollapsed.value;
      return navbarCollapsed.value;
    },
  },
};
</script>

<style>
:root {
  --navbar-height: 50px;
  --link-height: 35px;
}
</style>

<style scoped>
.navbar-wrapper {
  height: var(--navbar-height);
  display: flex;
  justify-content: space-between;
  background-color: var(--bg-color);
}
.organization-wrapper {
  display: flex;
  align-items: center;
}
.organization-icon {
  width: 30px;
  height: 30px;
  margin: 0 0 0 10px;
}
.organization-name {
  color: white;
  font-size: 20px;
  margin: 0 10px 0 10px;
}
.navbar,
.settings {
  display: flex;
}
.settings {
  margin: auto 0px;
}
.dropdown {
  min-width: 140px;
}
.link,
.dropbtn {
  display: block;
  text-decoration: none;
  color: white;
  margin: 0 5px;
  padding: 0 10px;
  box-sizing: border-box;
  height: var(--navbar-height);
  line-height: var(--navbar-height);
  background-color: var(--bg-color);
  min-width: 60px;

  cursor: pointer;
  text-align: start;
}

.link:hover {
  border-bottom: 4px solid var(--item-hover);
}
.link.active,
.dropbtn.active {
  border-bottom: 4px solid var(--item-active);
}
.dropbtn.open {
  border-bottom: 0px solid var(--item-active);
}
.dropdown-content {
  filter: brightness(110%);
}
.icon {
  width: 16px;
}
.burger {
  display: none;
}
.burger-icon {
  height: 30px;
}
.user-icon {
  height: 25px;
  color: white;
}

@media screen and (max-width: 820px) {
  .navbar-wrapper {
    align-items: center;
  }
  .navbar {
    display: flex;
    flex-direction: column;
    position: absolute;
    left: 0px;
    top: var(--navbar-height);
    min-width: 100%;

    border-top: 1px solid white;
  }
  .link,
  .dropbtn {
    margin: 0;
  }
  .navbar.collapsed {
    display: none;
  }
  .burger {
    display: block;
    color: white;
    margin: auto 10px;
  }
}
</style>
