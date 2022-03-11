<script setup>
import { useStore } from 'vuex';

const store = useStore();
</script>

<template>
  <div>
    <p>{{ store.getters['volatileDummyModule/getMessage'] }}</p>
    <h2>{{ store.getters['volatileDummyModule/getRandomNumber'] }}</h2>
  </div>
</template>
