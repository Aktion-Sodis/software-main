<template>
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
</template>

<script>
import { ref } from "vue";

const langdropdownCollapsed = ref(true);

export default {
  setup() {
    return { langdropdownCollapsed };
  },
  methods: {
    toggleLangguageSelector() {
      langdropdownCollapsed.value = !langdropdownCollapsed.value;
      return langdropdownCollapsed.value;
    },
  },
};
</script>

<style scoped>
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
</style>
