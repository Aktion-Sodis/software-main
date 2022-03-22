<template>
  <div class="form-group">
    <div class="changeLanguange">
      <v-select
        v-if="openSelectBox"
        class="selectBox"
        :items="avaliableLocales"
        @change="openSelectBox = false"
        v-model="selectedLanguange"
        :label="selectedLanguange"
      ></v-select>
      <v-icon @click="openSelectBox = !openSelectBox" style="height: auto" large>
        mdi-plus
      </v-icon>
    </div>
    <v-text-field
      autofocus
      v-model="res[selectedLanguange]"
      :label="openSelectBox ? '' : label"
      required
      outlined
      dense
    ></v-text-field>
  </div>
</template>

<script>
import { I18nString } from '../../models';

export default {
  props: ['label'],
  data() {
    return {
      selectedLanguange: this.$i18n.locale,
      res: {},
      // res: {
      //   languageKeys: [this.$i18n.locale],
      //   languageTexts: [],
      // },
      avaliableLocales: this.$i18n.availableLocales,
      openSelectBox: false,
    };
  },
  watch: {
    res: {
      handler() {
        const languageKeys = [];
        const languageTexts = [];
        /*eslint-disable */
        Object.keys(this.res).forEach(key => {
          languageKeys.push(key);
          languageTexts.push(this.res[key]);
        });
        /* eslint-enable */
        this.$emit('res', new I18nString({
          languageKeys,
          languageTexts,
        }));
      },
      deep: true,
      immediate: true, //  Also very important the immediate in case you need it, the callback will be called immediately after the start of the observation
    },
    openSelectBox: {
      handler(newVal) {
        if (newVal === true) {
          this.selectedLanguange = '';
        }
      },
      deep: true,
      immediate: true, //  Also very important the immediate in case you need it, the callback will be called immediately after the start of the observation
    },
  },
  // methods: {
  //   onChange() {
  //     console.log('asd');
  //     // this.$emit('res', new I18nString(this.res));
  //   },
  // },
};
</script>

<style scoped>
.v-text-field {
  padding-top: 0px !important;
  margin-top: 4px;
}
.v-icon.v-icon::after {
  height: 0px;
}
.v-icon.v-icon {
  align-items: flex-start;
}
.selectBox {
  height: auto;
  width: 50%;
}
.form-group {
  position: relative;
}
.languangeArea {
  position: absolute;
  top: 80%;
  left: 0;
  right: 0;
  z-index: 1;
  background: #fff;
  border: 1px solid #ddd;
  border-top: none;
  padding: 10px;
  /* overflow: scroll; */
}
.closeModal {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 1;
  color: rgba(71, 4, 4, 0.774) !important;
}
.changeLanguange {
  position: absolute;
  right: 7px;
  top: 2px;
  z-index: 10;
  cursor: pointer;
  display: flex;
  height: auto;
}
</style>
