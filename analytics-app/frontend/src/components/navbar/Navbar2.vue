<template>
  <div class="wrapper">
    <div class="organization-wrapper">
      <el-image
        class="organization-icon"
        src="/src/static/aktionSodisSmall.png"
      />
      <div class="organization-name">Aktion Sodis</div>
    </div>
    <NavbarLinks></NavbarLinks>
  </div>
</template>

<script>
import NavbarLinks from "./NavbarLinks.vue";
export default {
  components: { NavbarLinks },
};
</script>

<style scoped>
.wrapper {
  display: flex;
  align-items: center;
  justify-content: space-between;

  background-color: var(--bg-color);
}
.organization-wrapper {
  display: flex;
  align-items: center;
}
.organization-icon {
  width: 30px;
  height: 30px;
  margin: 0 0 0 10px;
}
.organization-name {
  color: white;
  font-size: 20px;
  margin: 0 10px 0 10px;
}

@media screen and (max-width: 820px) {
  .organization-icon {
    display: none;
  }
}
</style>
