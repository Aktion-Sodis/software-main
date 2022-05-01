<template>
  <div>
    <button @click="exampleButtonHandler">Example button</button>
    <h2>{{ helloWorld }}</h2>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "Home",
  computed: {
    ...mapGetters({
      helloWorld: "getHelloWorld",
    }),
  },
  methods: {
    ...mapActions({
      exampleButtonHandler: "exampleButtonHandler",
    }),
  },
};
</script>
