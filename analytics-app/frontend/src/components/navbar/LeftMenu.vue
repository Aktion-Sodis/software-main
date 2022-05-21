<template>
  <div class="left-menu">
    <div class="logo-wrapper">
      <el-image
        class="organization-icon"
        src="/src/static/aktionSodisSmall.png"
      />
      <div class="organization-name">Aktion Sodis</div>
    </div>
    <div class="left-menu-container">Test</div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.left-menu {
  width: var(--left-menu-width);
  background-color: var(--bg-color);
  float: left;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  bottom: 0;
}
.logo-wrapper {
  height: var(--navbar-height);
  display: flex;
  align-items: center;
  justify-content: center;
}
.organization-icon {
  height: 30px;
  width: 30px;
}
.organization-name {
  font-size: 25px;
  text-transform: uppercase;
  padding: 0 10px;
}
.left-menu-container {
  display: flex;
  flex-direction: column;
}
</style>
