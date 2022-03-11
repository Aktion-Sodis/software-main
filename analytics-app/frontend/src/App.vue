<script setup>
import { routes } from './router';
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
</script>

<template>
  <div>
    <img alt="Vue logo" src="./assets/logo.png" />
    <div class="navbar">
      <span v-for="route in routes" :key="route.name">
        <router-link :to="{ name: route.name }"> {{ route.name }} </router-link>
      </span>
    </div>
    <h1>This is the {{ $route.name }} view.</h1>
    <router-view> </router-view>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.navbar {
  width: 100%;
  display: flex;
  justify-content: space-around;
}
</style>
