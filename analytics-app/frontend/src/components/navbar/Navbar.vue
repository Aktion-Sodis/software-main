<template>
  <div class="navbar">
    <div class="organization">
      <div class="burger" @click="toggleNavLinks">
        <div class="line1"></div>
        <div class="line2"></div>
        <div class="line3"></div>
      </div>
      <div class="logo" @click="currentRouteName">
        <el-image class="image" src="/src/static/aktionSodisSmall.png" />
      </div>
      <div class="name">Aktion Sodis</div>
      <ul
        class="nav-links"
        :class="{ collapsed: menuCollapsed }"
        @click="closeNavLinks"
      >
        <li>
          <router-link
            class="link"
            :class="{ active: $route.path === '/' }"
            to="/"
          >
            <i class="icon fas fa-home" />
            <p>Home</p>
          </router-link>
        </li>
        <li>
          <router-link
            class="link"
            :class="{ active: $route.path === '/data' }"
            to="/data"
          >
            <i class="icon fa-solid fa-database" />
            <p>Data</p>
          </router-link>
        </li>
        <li>
          <router-link
            class="link"
            :class="{ active: $route.path === '/dummy-view-2' }"
            to="/dummy-view-2"
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
    </div>
    <ul
      class="user-links"
      :class="{ collapsed: userCollapsed }"
      @click="closeUserLinks"
    >
      <li>
        <router-link class="user-link" to="/dummy-view-2"
          ><i class="icon fa-solid fa-gear" />
          <p>Settings</p></router-link
        >
      </li>
      <li>
        <router-link class="user-link" to="/login"
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

<style scoped>
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 50px;
  background-color: #2d91be;
}
.organization {
  display: flex;
  align-items: center;
}
.image {
  width: 30px;
  margin: 0 10px;
}
.name {
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
.nav-links li {
  list-style: none;
  margin-right: 3px;
}
.link {
  text-decoration: none;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  display: flex;
  align-items: center;
  padding: 2px 12px 1px 1px;
  border-radius: 5px;
}
.link.active {
  background-color: #feaa3a;
}
.link:hover {
  background-color: #64aa73;
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
  margin: 0 10px;
}
.user .user-icon {
  height: 30px;
  color: white;
}
.burger {
  display: none;
}
.user-links {
  display: flex;
  flex-direction: column;
  position: absolute;
  right: 0px;
  top: 50px;
  background-color: #2d91be;
  align-items: flex-start;
  width: 150px;
  border-top: 1px solid black;
}
.user-links li {
  width: 100%;
  margin: 5px 0 0 5px;
  padding: 1px 0 1px 0px;
  width: calc(100% - 10px);
  list-style: none;
}
.user-link {
  text-decoration: none;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  display: flex;
  align-items: center;
  padding: 2px 12px 1px 1px;
  border-radius: 5px;
}
.user-link.active {
  background-color: #feaa3a;
}
.user-link:hover {
  background-color: #64aa73;
}
.burger div {
  width: 25px;
  height: 2px;
  margin: 5px 5px;
  background-color: white;
}
.user-links.collapsed {
  display: none;
}

@media screen and (max-width: 820px) {
  .nav-links {
    display: flex;
    flex-direction: column;
    position: absolute;
    left: 0px;
    top: 50px;
    background-color: #2d91be;
    color: white;
    align-items: flex-start;
    width: 100%;
    border-top: 1px solid black;
  }
  .nav-links.collapsed {
    display: none;
  }
  .nav-links li {
    margin: 5px 0 0 5px;
    padding: 1px 0 1px 0px;
    width: calc(100% - 10px);
  }
  .burger {
    display: block;
  }
  .logo {
    display: none;
  }
  .user-links {
    width: 100%;
  }
}
</style>
