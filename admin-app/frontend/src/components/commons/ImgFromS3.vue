<template>
  <div style="position: relative">
    <slot name="v-img" :src="fetchedSrc" :lazy-src="requireImg(dataType)" v-if="fetchedSrc"></slot>
    <slot name="v-img" v-else :src="requireImg(dataType)"> </slot>
    <v-progress-circular
      class="loading-circle"
      v-if="loading"
      indeterminate
      color="primary"
    ></v-progress-circular>
  </div>
</template>

<script>
import { Storage } from 'aws-amplify';

export default {
  name: 'ImgFromS3',
  props: {
    assumedSrc: {
      required: true,
      validator: (value) => typeof value === 'string' || value === null || value instanceof File,
    },
    dataType: {
      type: String,
      default: 'default',
    },
  },
  data: () => ({
    fetchedSrc: null,
    loading: true,
  }),
  mounted() {
    this.fetchSrc();
  },
  methods: {
    async fetchSrc() {
      if (!this.assumedSrc) {
        this.loading = false;
        return;
      }

      if (this.assumedSrc instanceof File) {
        this.fetchedSrc = URL.createObjectURL(this.assumedSrc);
        this.loading = false;
        return;
      }
      try {
        await Storage.get(this.assumedSrc, {
          contentType: 'image/png',
          download: true,
        });
        this.fetchedSrc = await Storage.get(this.assumedSrc, {
          contentType: 'image/png',
        });
      } catch {
        this.fetchedSrc = null;
      }
      this.loading = false;
    },
    requireImg(dataType) {
      let res;
      try {
        // eslint-disable-next-line
        res = require(`../../static/defaultImages/${dataType}Card.png`);
      } catch (error) {
        // eslint-disable-next-line
        res = require('../../static/defaultImages/defaultCard.png');
      }
      return res;
    },
  },
};
</script>

<style scoped>
.loading-circle {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
