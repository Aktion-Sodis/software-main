<template>
  <div class="navbar">
    <div class="organization">
      <div class="logo" @click="currentRouteName">
        <el-image class="image" src="/src/static/aktionSodisSmall.png" />
      </div>
      <div class="organization-name">Aktion Sodis</div>
      <ul
        class="nav-links"
        :class="{ collapsed: menuCollapsed }"
        @click="closeNavLinks"
      >
        <li class="li">
          <router-link
            class="link"
            :class="{ active: $route.path === '/' }"
            to="/"
          >
            <i class="icon fas fa-home" />
            <p>Home</p>
          </router-link>
        </li>
        <li class="li">
          <router-link
            class="link"
            :class="{ active: $route.path === '/data' }"
            to="/data"
          >
            <i class="icon fa-solid fa-database" />
            <p>Data</p>
          </router-link>
        </li>
        <li class="li">
          <router-link
            class="link"
            :class="{ active: $route.path === '/dashboard' }"
            to="/dashboard"
          >
            <i class="icon fas fa-chart-bar" />
            <p>Dashboard</p>
          </router-link>
        </li>
      </ul>
    </div>
    <div class="extras">
      <div class="language-selector"><p>English</p></div>
      <div class="user" @click="toggleUserLinks">
        <i class="user-icon fa-solid fa-circle-user"></i>
      </div>
      <div class="burger" @click="toggleNavLinks">
        <i class="burger-icon fa-solid fa-bars" />
      </div>
    </div>
    <ul
      class="user-links"
      :class="{ collapsed: userCollapsed }"
      @click="closeUserLinks"
    >
      <li class="li">
        <router-link class="link" to="/dummy-view-2"
          ><i class="icon fa-solid fa-gear" />
          <p>Settings</p></router-link
        >
      </li>
      <li class="li">
        <router-link class="link" to="/login"
          ><i class="icon fa-solid fa-arrow-right-to-bracket" />
          <p>Login</p></router-link
        >
      </li>
      <li class="li">
        <router-link class="link" to="/login"
          ><i class="icon fa-solid fa-arrow-right-to-bracket" />
          <p>Login</p></router-link
        >
      </li>
    </ul>
  </div>
</template>

<script>
import { ref } from "vue";

const menuCollapsed = ref(true);
const userCollapsed = ref(true);

export default {
  setup() {
    return { menuCollapsed, userCollapsed };
  },
  methods: {
    closeNavLinks() {
      return [(menuCollapsed.value = true), (userCollapsed.value = true)];
    },
    toggleNavLinks() {
      return [
        (menuCollapsed.value = !menuCollapsed.value),
        (userCollapsed.value = true),
      ];
    },
    closeUserLinks() {
      console.log("Toggle");
      return [(userCollapsed.value = true), (menuCollapsed.value = true)];
    },
    toggleUserLinks() {
      console.log("Toggle");
      return [
        (userCollapsed.value = !userCollapsed.value),
        (menuCollapsed.value = true),
      ];
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
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: var(--navbar-height);
  background-color: var(--bg-color);
}
.organization {
  display: flex;
  align-items: center;
}
.image {
  width: 30px;
  margin: 0 10px;
}
.organization-name {
  text-transform: uppercase;
  letter-spacing: 0px;
  font-size: 20px;
  color: white;
  margin-right: 20px;
}
.nav-links {
  display: flex;
  align-items: center;
}
.user-links {
  display: flex;
  flex-direction: column;
  position: absolute;
  right: 0px;
  top: var(--navbar-height);
  background-color: var(--bg-color);
  align-items: flex-start;
  width: 150px;
  border-top: 1px solid black;
  border-radius: 0px 0px 0px 5px;
  padding: 4px 0px 4px 0px;

  z-index: 1;
}
.user-links.collapsed {
  display: none;
}
.li {
  width: 100%;
  margin: 2px 0 2px 5px;
  width: calc(100% - 10px);
  list-style: none;
}
.link {
  text-decoration: none;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  display: flex;
  align-items: center;
  border-radius: 5px;
  height: var(--link-height);
  box-sizing: border-box;
  padding: 2px 12px 1px 1px;
}
.link.active .user-link.active {
  background-color: var(--item-active);
}
.link:hover .user-link:hover {
  background-color: var(--item-hover);
}
.icon {
  width: 16px;
  margin: 9px;
}
.extras {
  display: flex;
  align-items: center;
}
.language-selector {
  margin: 0 5px;
  color: white;
}
.user {
  margin: 0 0;
}
.user-icon {
  height: 25px;
  color: white;
  margin: 0 10px;
}
.burger {
  display: none;
}
.burger-icon {
  height: 30px;
}
.link.active {
  background-color: var(--item-active);
}
.link:hover {
  background-color: var(--item-hover);
}

@media screen and (max-width: 820px) {
  .nav-links {
    display: flex;
    flex-direction: column;
    position: absolute;
    right: 0px;
    top: var(--navbar-height);
    background-color: var(--bg-color);
    align-items: flex-start;
    width: 100%;
    border-top: 1px solid black;
    border-radius: 0px 0px 5px 5px;
    padding: 4px 0px 4px 0px;

    z-index: 1;
  }
  .nav-links.collapsed {
    display: none;
  }
  .user-links {
    width: 100%;
    border-radius: 0px 0px 5px 5px;
  }
  .burger {
    display: block;
    color: white;
    margin: 0 10px;
  }
  .user-icon {
    margin: 0 0;
  }
  .organization-name {
    display: none;
  }
}
</style>
