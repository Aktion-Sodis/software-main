<template>
  <div class="wrapper">
    <LeftMenu />
    <TopNavbar />
  </div>
</template>

<script>
import TopNavbar from "./Topnavbar.vue";
import LeftMenu from "./LeftMenu.vue";

export default {
  components: { TopNavbar, LeftMenu },
};
</script>

<style>
:root {
  --navbar-height: 70px;
  --link-height: 35px;
  --left-menu-width: 260px;
  --left-menu-width-collapsed: 70px;
}
</style>

<style scoped></style>
