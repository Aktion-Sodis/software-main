<template>
  <div class="container">
    <div class="return-wrapper">
      <el-button class="sodis return"
        ><i class="fa-solid fa-arrow-left"></i
      ></el-button>
    </div>
    <div class="header">Dashboard - Nisaba</div>
    <div class="button-wrapper">
      <el-button class="sodis download"
        ><i class="fa-solid fa-download"></i
      ></el-button>
    </div>
    <div class="main">
      <div class="tabs-wrapper">
        <div class="tabs">
          <div
            class="tab"
            :class="{ active: tab.id === selectedTabID }"
            v-for="tab in tabs"
            :key="tab.id"
            @click="selectTab(tab.id)"
          >
            {{ tab.name }}
          </div>
        </div>
        <div class="add-tab">
          <el-button class="sodis plus"
            ><i class="fa-solid fa-plus"></i
          ></el-button>
        </div>
      </div>
      <div class="content-wrapper">
        <div
          class="preview"
          v-for="content in selectedTab().content"
          :key="content.id"
        >
          {{ content.name }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    selectTab(tabID) {
      this.selectedTabID = tabID;
    },
    selectedTab() {
      return this.tabs.find((item) => item.id === this.selectedTabID) || 0;
    },
  },
  data() {
    return {
      selectedTabID: 1,
      tabs: [
        {
          id: 1,
          name: "Tab1",
          content: [
            {
              id: 1,
              name: "Tab1 Content 1",
            },
            { id: 1, name: "Tab1 Content 2" },
          ],
        },
        {
          id: 2,
          name: "Tab2",
          content: [
            {
              id: 1,
              name: "Tab2 Content 1",
            },
            { id: 1, name: "Tab2 Content 2" },
          ],
        },
        {
          id: 3,
          name: "Tab3",
          content: [
            {
              id: 1,
              name: "Tab3 Content 1",
            },
            { id: 1, name: "Tab3 Content 2" },
          ],
        },
      ],
    };
  },
};
</script>

<style>
:root {
  --container-margin: 25px;
}
</style>

<style scoped>
.container {
  box-sizing: border-box;
  margin-left: var(--container-margin);
  margin-right: var(--container-margin);
  margin-bottom: var(--container-margin);
  height: calc(100vh - var(--navbar-height) - 1 * var(--container-margin));

  display: grid;
  grid-template-rows: 60px calc(
      100vh - var(--navbar-height) - var(--container-margin) - 60px
    );
  grid-template-columns:
    60px calc(
      100vw - var(--left-menu-width) - var(--container-margin) * 2 - 60px -
        200px
    )
    200px;

  grid-template-areas:
    "return header buttons"
    "main main main";
}

.return-wrapper {
  grid-area: return;
  justify-self: start;
  border: none;
  margin: auto 0;
}
.sodis {
  background-color: var(--bg-color);
  color: white;
}
.return {
  width: 50px;
}
.header {
  grid-area: header;
  margin: auto 0;
  text-align: left;
  font-size: 20px;
}
.main {
  grid-area: main;
  background-color: rgb(255, 255, 255);
}
.button-wrapper {
  grid-area: buttons;
  justify-self: end;
  margin: auto 0;
}

.plus,
.download {
  width: 50px;
}

/* Tabs */

.tabs-wrapper {
  grid-area: tabs;
  background-color: rgb(236, 245, 254);
  overflow-y: hidden;
  overflow-x: scroll;

  display: flex;
  align-items: center;
  justify-content: space-between;
}
.add-tab {
  background-color: rgb(236, 245, 254);
}
.tabs {
  display: flex;
  border-top: 1px solid black;
  border-bottom: none;
  background-color: rgb(255, 255, 255);
}
.tab {
  height: 40px;
  width: 200px;
  border-bottom: 0.5px solid black;
  border-left: 0.5px solid black;
  border-right: 0.5px solid black;
}
.tab.active {
  border-bottom: 0.5px solid rgb(255, 255, 255);
}

.content-wrapper {
  overflow-y: scroll;
  height: calc(
    100vh - var(--navbar-height) - 60px - 60px - var(--container-margin)
  );
  display: flex;
  flex-direction: row;
}
.preview {
  background-color: aqua;
  height: 300px;
  width: 500px;
}

/* Designing for scroll-bar */
::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: rgb(255, 255, 255);
  border-radius: 0px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: var(--bg-color);
  border-radius: 1px;
}
</style>
