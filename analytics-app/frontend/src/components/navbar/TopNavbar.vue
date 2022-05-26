<template>
  <div class="top-navbar">
    <div @click="toggleSidebar">
      <i class="icon fa-solid fa-bars"></i>
    </div>
    <SearchBar />
    <div class="settings-wrapper">
      <LanguageSelector />
      <NotificationPanel />
      <i class="icon fa-solid fa-gear"></i>
      <i class="icon fa-solid fa-circle-user"></i>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { mapState, mapMutations, mapActions } from "vuex";

import LanguageSelector from "../commons/LanguageSelector.vue";
import SearchBar from "../commons/SearchBar.vue";
import NotificationPanel from "../commons/NotificationPanel.vue";

export default {
  components: { LanguageSelector, SearchBar, NotificationPanel },
  computed: {
    ...mapState({
      SideBarCollapsed: (state) => state.NavbarAtributes.SideBarCollapsed,
      LeftMenuWidth: (state) => state.NavbarAtributes.LeftMenuWidth,
    }),
  },
  methods: {
    ...mapMutations({
      toggleSidebar: "toggleSidebar",
    }),
  },
  mounted: function () {
    this.root = document.documentElement;
  },
  watch: {
    SideBarCollapsed: {
      handler: function () {
        this.$nextTick(() => {
          if (this.SideBarCollapsed) {
            this.root.style.setProperty("--left-menu-width", "60px");
          } else {
            this.root.style.setProperty("--left-menu-width", "260px");
          }
        });
      },
      immediate: true,
    },
  },
  data() {
    return {
      root: null,
    };
  },
};
</script>

<style scoped>
.top-navbar {
  height: var(--navbar-height);
  margin-left: var(--left-menu-width);
  background-color: white;
  position: fixed;
  z-index: 1;
  top: 0;
  right: 0;
  left: 0;

  display: flex;
  align-items: center;
  justify-content: space-between;
}
.icon {
  height: 20px;
  color: rgb(0, 0, 0);
  margin: 0 10px;
}
.settings-wrapper {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
</style>
