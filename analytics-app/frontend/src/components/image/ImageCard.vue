<template>
  <div class="image-card">
    <el-image
      :src="image.img_src"
      fit="contain"
      class="image"
      :previewSrcList="preview"
      :initial-index="index"
    />
  </div>
</template>

<script>
export default {
  name: "SurveyCard",
  props: { image: Object, preview: Array, index: Number },
};
</script>

<style scoped>
.image-card {
  width: fit-content;
  height: fit-content;
  margin: 0 10px 10px 0;
  padding: 5px;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.5) inset;
}
.image {
  height: 200px;
  max-width: 240px;
  padding: 0;
  margin: 0;
}
</style>
