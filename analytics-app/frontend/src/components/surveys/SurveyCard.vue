<template>
  <div class="survey-card">
    <div class="survey-card-inner">
      <div class="survey-image-wrap">
        <el-image class="image" :src="survey.src"/>
      </div>
      <div class="survey-description-wrap">
        <el-row>
          <el-col :span="21">
            <div class="survey-title">
            {{ survey.title }}
            </div>
            <div class="survey-date">
              {{ survey.date }}
            </div>
          </el-col>
          <el-col :span="3">
            <i class="fa-solid fa-ellipsis-vertical icon"></i>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SurveyCard',
  props: ['survey']
}
</script>

<style>
.survey-card {
  width: 200px;
  margin-left: 5px;
  margin-right: 10px;
  margin-bottom: 15px;
  display: inline-block;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.25); 
}

.survey-card:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.25); 
}

.image {
  width: 100%;
  padding-top: 10px;
  padding-bottom: 10px;
}

.survey-description-wrap {
  background-color: rgb(238, 235, 235);
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