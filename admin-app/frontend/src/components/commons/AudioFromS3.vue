<template>
  <div style="position: relative">
    <VuetifyAudio :file="fetchedSrc" color="success" downloadable v-if="fetchedSrc" />
    <p v-else>{{ $t('general.noAudio') }}</p>
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
import VuetifyAudio from 'vuetify-audio';

export default {
  name: 'AudioFromS3',
  components: { VuetifyAudio },
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
  watch: {
    assumedSrc() {
      console.log('assumedSrc', this.assumedSrc);
      this.fetchSrc();
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
      this.loading = true;
      if (!this.assumedSrc) {
        this.loading = false;
        return;
      }
      try {
        console.log(this.assumedSrc);
        const audio = await Storage.get(this.assumedSrc, { download: true });
        console.log({ audio });
        this.fetchedSrc = URL.createObjectURL(audio.Body);
        console.log(this.fetchedSrc);
      } catch (error) {
        console.log({ error });
        this.fetchedSrc = null;
      }
      this.loading = false;
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
