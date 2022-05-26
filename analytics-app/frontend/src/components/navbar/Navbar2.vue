<template>
  <div class="wrapper">
    <LeftMenu />
    <TopNavbar />
  </div>
</template>

<script>
import { mapState } from "vuex";

import TopNavbar from "./TopNavbar.vue";
import LeftMenu from "./LeftMenu.vue";

export default {
  components: { TopNavbar, LeftMenu },
  mounted: function () {
    this.root = document.documentElement;
  },
  computed: {
    ...mapState({
      SideBarCollapsed: (state) => state.NavbarAtributes.SideBarCollapsed,
    }),
  },
};
</script>

<style>
:root {
  --navbar-height: 60px;
  --link-height: 50px;
  --sub-link-height: 35px;

  --left-menu-width: 260px;
  --left-menu-width-collapsed: 60px;
  --left-menu-width-expanded: 260px;
}
</style>

<style scoped></style>
