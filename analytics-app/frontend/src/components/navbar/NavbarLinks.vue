<template>
  <div class="navbar-wrapper">
    <div class="navbar">
      <router-link class="link" :class="{ active: $route.path === '/' }" to="/">
        <i class="icon fas fa-home" />
        Home
      </router-link>
      <div class="dropdown" @mouseover="showContent" @mouseleave="hideContent">
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
          >
            <i class="icon fa-solid fa-database" />
            Home1
          </router-link>
          <router-link
            class="link"
            :class="{ active: $route.path === '/data/dummy-view-2' }"
            to="/data/dummy-view-2"
          >
            <i class="icon fa-solid fa-download"></i>
            Export
          </router-link>
        </div>
      </div>
      <router-link
        class="link"
        :class="{ active: $route.path === '/dashboard' }"
        to="/dashboard"
      >
        <i class="icon fas fa-chart-bar" />
        Dashboard
      </router-link>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";

const dropdownCollapsed = ref(true);
console.log(dropdownCollapsed);

export default {
  setup() {
    return { dropdownCollapsed };
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
  background-color: var(--bg-color);
  display: flex;
}

.navbar {
  display: flex;
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
</style>
