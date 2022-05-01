<template>
  <div>
    <div>{{ graphData.layout.title }}</div>
    <div class="graph-wrapper" ref="plot1"></div>
  </div>
</template>

<script>
import Plotly from "plotly.js-dist";

export default {
  data: function () {
    return {
      graphData: {
        data: [
          {
            x: ["giraffes", "orangutans", "monkeys"],
            y: [20, 14, 23],
            type: "bar",
          },
        ],
        layout: { title: "My graph" },
      },
    };
  },
  mounted() {
    Plotly.newPlot(this.$refs.plot1, this.graphData.data);
  },
};
</script>

<style scoped>
.graph-wrapper {
  height: auto;
  width: auto;
}
</style>