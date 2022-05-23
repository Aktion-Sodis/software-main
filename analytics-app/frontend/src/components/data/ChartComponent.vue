<template>
  <div>
    <div class="graph-wrapper" ref="plot1"></div>
  </div>
</template>

<script>
import Plotly from "plotly.js-dist";
import { ref } from "vue";

var graphData = {
  titleText: "Das ist der neue Titel",
  xAxisTitle: "Hallo X",
  yAxisTitle: "Hallo Y",
  xData: ["Apples", "Oranges", "Watermelon", "Pears"],
  yData: [3, 2, 1, 4],
  type: "bar",
};

export default {
  mounted() {
    Plotly.newPlot(
      this.$refs.plot1,
      this.graph.data,
      this.graph.layout,
      this.graph.config
    );
  },
  setup() {
    return { graphData };
  },
  computed: {
    graph() {
      return {
        data: [
          {
            x: graphData.xData,
            y: graphData.yData,
            type: graphData.type,
          },
        ],
        layout: {
          title: {
            text: graphData.titleText,
            font: {
              size: 24,
            },
            xref: "paper",
          },
          yaxis: {
            title: graphData.yAxisTitle,
            tickvals: [1, 2, 3, 4],
            tickmode: "array",
            automargin: true,
            titlefont: { size: 20 },
          },
          xaxis: {
            title: graphData.xAxisTitle,
            automargin: true,
            titlefont: { size: 20 },
          },
          paper_bgcolor: "#rgb(45, 145, 190, 0.2)",
          plot_bgcolor: "#rgb(45, 145, 190, 0.2)",
        },
        config: { responsive: true },
      };
    },
  },
};
</script>

<style scoped>
.graph-wrapper {
  height: 100%;
  width: 100%;
}
</style>
