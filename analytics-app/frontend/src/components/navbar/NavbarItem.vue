<template>
  <div id="nav-item" class="navbar-item">
    <router-link class="link" :to="item.to">
      <div class="navbar-icon">
        <i class="icon" :class="item.icon"></i>
      </div>
      <div
        id="nav-text"
        class="navbar-text"
        :class="{ collapsed: SideBarCollapsed }"
      >
        <div>{{ item.name }}</div>
      </div>
    </router-link>
  </div>
</template>

<script>
import { objectEntries } from "@antfu/utils";
import { mapState } from "vuex";

export default {
  props: {
    item: Object,
  },
  computed: {
    ...mapState({
      SideBarCollapsed: (state) => state.NavbarAtributes.SideBarCollapsed,
    }),
  },
};
</script>

<style scoped>
.navbar-item {
  color: white;
}
.link {
  text-decoration: none;
  display: flex;
  align-items: center;
  height: var(--link-height);
  width: fit-content;
  margin: 0;
  padding: 0;
}
.navbar-icon {
  box-sizing: border-box;
  width: var(--left-menu-width-collapsed);
  margin: 0;
  padding: 0;
  color: white;
}
.navbar-text {
  color: white;
  width: calc(
    var(--left-menu-width-expanded) - var(--left-menu-width-collapsed)
  );
  height: var(--link-height);
  text-align: left;
  box-sizing: border-box;
  padding-left: 5px;

  display: flex;
  align-items: center;

  position: absolute;
  left: var(--left-menu-width-collapsed);
}
.navbar-text.collapsed {
  display: none;
}
.navbar-item:hover {
  background-color: rgb(37, 119, 157);
}
#nav-item:hover #nav-text {
  display: flex;
  background-color: rgb(37, 119, 157);
}
.icon {
  width: 14px;
}
</style>
