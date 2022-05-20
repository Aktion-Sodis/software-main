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
      <div class="language-selector-wrapper" @click="toggleLangguageSelector">
        <div class="language-dropbtn">
          <i class="language-icon fa-solid fa-globe"></i>
          <div class="language-wrapper">Englisch</div>
          <i class="language-icon fa-solid fa-caret-down"></i>
        </div>
        <div class="language-dropdown-content" v-show="!langdropdownCollapsed">
          <div class="language-content">Englisch</div>
          <div class="language-content">Deutsch</div>
          <div class="language-content">Deutsch</div>
        </div>
      </div>
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
const langdropdownCollapsed = ref(true);

export default {
  setup() {
    return { dropdownCollapsed, navbarCollapsed, langdropdownCollapsed };
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
    toggleLangguageSelector() {
      langdropdownCollapsed.value = !langdropdownCollapsed.value;
      return langdropdownCollapsed.value;
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

.icon-wrapper {
  margin: 0 10px;
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

.language-selector-wrapper {
  min-width: auto;
}

.language-dropbtn {
  height: 36px;
  width: 140px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  text-decoration: none;
  margin: 7px 0px 0 0px;
  padding: 0 10px;
  box-sizing: border-box;
  height: var(--navbar-height);
  line-height: var(--navbar-height);

  cursor: pointer;
  text-align: start;

  border: solid 1px black;
  border-radius: 5px;
  background-color: white;
  height: 36px;
}
.language-wrapper {
  color: black;
}
.language-dropdown-content {
  background-color: white;
  border: 1px solid black;
  border-radius: 5px;
  max-height: 150px;
  overflow: scroll;
}
.language-content {
  box-sizing: border-box;
  height: 30px;
  display: flex;
  align-items: center;

  padding: 0 0 0 30px;

  cursor: pointer;
  text-align: start;

  border-bottom: 1px solid lightgrey;
}

.language-content:hover {
  background-color: rgb(237, 237, 237);
}

.language-icon {
  margin: 0 1px;
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
