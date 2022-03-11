<script setup>
import { useStore } from 'vuex';

const store = useStore();
</script>

<template>
  <div>
    <p>{{ store.getters['persistedDummyModule/getMessage'] }}</p>
    <h2>{{ store.getters['persistedDummyModule/getRandomNumber'] }}</h2>
  </div>
</template>
