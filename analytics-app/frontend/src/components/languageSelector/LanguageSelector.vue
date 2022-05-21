<template>
  <div class="language-selector-wrapper" @click="toggleLangguageSelector">
    <div class="language-dropbtn">
      <i class="language-icon fa-solid fa-globe"></i>
      <div class="language-wrapper">{{ $t("languages." + $i18n.locale) }}</div>
      <i class="language-icon fa-solid fa-caret-down"></i>
    </div>
    <div class="language-dropdown-content" v-show="!langdropdownCollapsed">
      <div
        class="language-content"
        v-for="locale in $i18n.availableLocales"
        :key="`locale-${locale}`"
        :value="locale"
        @click="changeLang(locale)"
      >
        <i class="language-icon fa-solid fa-globe"></i>
        <div class="language-wrapper">{{ $t("languages." + locale) }}</div>
        <i
          class="language-icon hidden fa-solid fa-caret-down"
          style="'display':hidden "
        ></i>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import i18n from "../../i18n";

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
    changeLang(locale) {
      this.$i18n.locale = locale;
      console.log(this.$i18n.availableLocales);
      return this.$i18n.locale;
    },
  },
  data() {
    return {
      selected: this.default,
    };
  },
};
</script>

<style scoped>
.language-selector-wrapper {
  min-width: auto;
}

.language-dropbtn {
  height: 30px;
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

  border-radius: 5px;
  border: 1px solid black;
  background-color: white;
  height: 36px;
}
.language-wrapper {
  color: black;
  width: 70px;
}
.language-content {
  height: 30px;
  width: 140px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  text-decoration: none;
  padding: 0 10px;
  box-sizing: border-box;

  cursor: pointer;
  text-align: start;

  border-radius: 5px;
  background-color: white;
}

.language-dropdown-content {
  background-color: white;
  border: 1px solid black;
  border-radius: 5px;
  max-height: 150px;
  width: 140px;
  overflow-x: hidden;
  overflow-y: scroll;
  box-sizing: border-box;
}

.language-content:hover {
  background-color: rgb(237, 237, 237);
}

.language-icon {
  margin: 0 1px;
}
.hidden {
  visibility: hidden;
}
</style>
