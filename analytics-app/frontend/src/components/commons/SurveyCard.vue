<template>
  <div class="survey-card">
    <div class="survey-card-inner">
      <el-image class="image" :src="src" :fit="contain" />
      <div class="survey-description-wrap">
        <el-row>
          <el-col :span="21">
            <div class="survey-title">
              {{ survey.name }}
            </div>
            <div class="survey-date">14.12.1996</div>
          </el-col>
          <el-col :span="3">
            <i class="fa-solid fa-ellipsis-vertical"></i>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "SurveyCard",
  props: ["survey"],
  data() {
    return {
      src: "https://sanito.org/wp-content/uploads/2017/12/Öko-Küchen-2-768x1024.jpg",
    };
  },
};
</script>

<style scoped>
.survey-card {
  width: 250px;
  margin-top: 5px;
  margin-left: 5px;
  margin-right: 5px;
  margin-bottom: 5px;
  border-radius: 5px;
  display: inline-block;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.5);
}
.survey-card.selected {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 1) !important;
}
.survey-card:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.5);
}
.image {
  height: 200px;
  padding: 10px;
}
.survey-description-wrap {
  background-color: rgb(45, 145, 190, 0.2);
  padding: 10px;
}
.survey-title {
  text-align: left;
  font-size: 15px;
}
.survey-date {
  text-align: left;
  font-size: 12px;
}
</style>
