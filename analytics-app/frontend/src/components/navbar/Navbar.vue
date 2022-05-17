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
      <div class="dropdown" @mouseleave="hideContent" @click="toggleContent">
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
            Export
          </router-link>
        </div>
      </div>
      <router-link
        class="link"
        :class="{ active: $route.path === '/dashboard' }"
        to="/dashboard"
        @click="toggleNavbar"
      >
        <i class="icon fas fa-chart-bar" />
        Dashboard
      </router-link>
    </div>
    <router-link class="link" to="/login">
      <i class="icon fa-solid fa-arrow-right-to-bracket" />
      Login
    </router-link>
  </div>
  <div class="burger" @click="toggleNavbar">
    <i class="burger-icon fa-solid fa-bars" />
  </div>
</template>

<script>
import NavbarLinks from "./NavbarLinks.vue";
export default {
  components: { NavbarLinks },
};
</script>

<style scoped>
.wrapper {
  display: flex;
  align-items: center;
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

.burger {
  display: none;
}
.burger-icon {
  height: 30px;
}

@media screen and (max-width: 820px) {
  .organization-icon {
    display: none;
  }
  .navbar-wrapper {
    height: var(--navbar-height);
    display: flex;
    justify-content: space-between;
    background-color: var(--bg-color);
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
    margin: 0 10px;
  }
}
</style>
