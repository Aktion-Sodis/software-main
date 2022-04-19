<template>
  <div class="question" :class="{ active: isActive }">
    <h4>
        {{ question.question_text }}
    </h4>
  </div>
</template>

<script>
export default {
  name: 'Question',
  props: ['question']
}
</script>

<style>
.question {
  width: 200px;
  margin-left: 5px;
  margin-right: 15px;
  margin-bottom: 10px;
  margin-top: 10px;
  box-shadow: 0px 0px 1px rgb(0, 0, 0, 0.25); 

  text-align: left;
  padding-left: 5px;
}

.question:hover {
  box-shadow: 0px 0px 5px rgb(0, 0, 0, 0.25); 
}

.question.active {
  background-color: black;
}

</style>