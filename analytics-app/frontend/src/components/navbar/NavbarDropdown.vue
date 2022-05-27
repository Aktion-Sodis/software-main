<template>
  <div id="drop-item" class="dropdown-item">
    <div id="drop-btn" class="dropdown-btn" @click="toggleContent">
      <div class="dropdown-btn-icon">
        <i class="icon" :class="items.icon"></i>
      </div>
      <div
        id="drop-btn-expand"
        class="dropdown-btn-expand"
        :class="{ collapsed: SideBarCollapsed }"
      >
        <div class="dropdown-btn-text">{{ items.name }}</div>
        <div class="drop-icon" :class="{ collapsed: SideBarCollapsed }">
          <i class="fa-solid fa-caret-down"></i>
        </div>
      </div>
    </div>
    <div
      id="drop-content"
      class="dropdown-content"
      :class="{ collapsed: SideBarCollapsed }"
      v-if="!contentCollapsed"
    >
      <router-link
        class="dropdown-link"
        v-for="item in items.items"
        :key="item.id"
        :to="item.to"
      >
        <div class="dropdown-link-text">{{ item.name }}</div>
      </router-link>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { ref } from "vue";

export default {
  props: {
    items: Object,
  },
  methods: {
    toggleContent() {
      if (this.SideBarCollapsed) {
        this.contentCollapsed = false;
        return this.contentCollapsed;
      }
      return (this.contentCollapsed = !this.contentCollapsed);
    },
  },
  computed: {
    ...mapState({
      SideBarCollapsed: (state) => state.NavbarAtributes.SideBarCollapsed,
    }),
  },
  watch: {
    SideBarCollapsed: {
      handler: function () {
        this.$nextTick(() => {
          if (this.SideBarCollapsed) {
            this.contentCollapsed = false;
          } else {
            this.contentCollapsed = true;
          }
        });
      },
      immediate: true,
    },
  },
  data() {
    return {
      contentCollapsed: true,
    };
  },
};
</script>

<style scoped>
.dropdown-item {
  color: white;
}
.dropdown-btn {
  display: flex;
  align-items: center;
  height: var(--link-height);
  width: fit-content;

  cursor: pointer;

  position: relative;

  z-index: 2;
}
.dropdown-btn-icon {
  width: var(--left-menu-width-collapsed);
}
.dropdown-btn-expand {
  width: calc(
    var(--left-menu-width-expanded) - var(--left-menu-width-collapsed)
  );
  display: flex;
  justify-content: space-between;
  align-items: center;

  position: relative;
}
.dropdown-btn-expand.collapsed {
  display: none;
}

#drop-item:hover #drop-btn-expand {
  display: flex;
}
#drop-item:hover #drop-btn {
  background-color: rgb(37, 119, 157);
}
#drop-item:hover #drop-content {
  display: flex;
  flex-direction: column;
}
.dropdown-btn-text {
  padding-left: 5px;
}
.drop-icon {
  position: relative;
  float: right;
  margin: 0 15px;
}
.drop-icon.collapsed {
  display: none;
}

.dropdown-content {
  width: calc(
    var(--left-menu-width-expanded) - var(--left-menu-width-collapsed)
  );
  margin-left: var(--left-menu-width-collapsed);
  z-index: 2;
}
.dropdown-content.collapsed {
  display: none;
  background-color: var(--bg-color-bright);
  margin-left: 0;
  position: absolute;
  left: var(--left-menu-width-collapsed);
}

.dropdown-link {
  text-decoration: none;
}

.dropdown-link-text {
  box-sizing: border-box;
  height: var(--sub-link-height);
  width: calc(
    var(--left-menu-width-expanded) - var(--left-menu-width-collapsed)
  );
  text-align: left;
  padding-left: 20px;
  color: white;

  display: flex;
  align-items: center;
}
.dropdown-link-text:hover {
  color: rgb(37, 119, 157);
}

.icon {
  width: 14px;
}

/* Div to close component when clicked somewhere else */
.outside {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0px;
  left: 0px;
  z-index: 1;
}
</style>
