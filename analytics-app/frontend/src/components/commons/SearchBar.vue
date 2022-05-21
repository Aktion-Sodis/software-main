.
<template>
  <div class="searchbar-wrapper">
    <el-form>
      <el-form-item class="text-wrapper">
        <el-input placeholder="Search"></el-input>
      </el-form-item>
    </el-form>
    <el-form>
      <el-form-item class="btn-wrapper">
        <el-button type="primary"> Search</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.searchbar-wrapper {
  display: flex;
  align-items: center;
}
.text-wrapper {
  display: block;
  margin: 0;
  width: 240px;
}
.btn-wrapper {
  display: block;
  margin: 0;
  width: 40px;
}
</style>
