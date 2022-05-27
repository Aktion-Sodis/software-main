<template>
  <div>
    <div class="graph-wrapper" ref="plot"></div>
  </div>
</template>

<script>
import axios from "axios";
import Plotly from "plotly.js-dist";
import { ref } from "vue";

export default {
  setup() {
    return {};
  },
  mounted() {
    this.init();
  },
  methods: {
    init() {
      const path = "http://127.0.0.1:5000/graphdata";
      axios
        .get(path)
        .then((res) => {
          var data = res.data.data;

          this.graphData.data[0].x = data.xData;
          this.graphData.data[0].y = data.yData;
          this.graphData.layout.title.text = data.titleText;
          this.graphData.layout.yaxis.title = data.yAxisTitle;
          this.graphData.layout.xaxis.title = data.xAxisTitle;

          Plotly.react(
            this.$refs.plot,
            this.graphData.data,
            this.graphData.layout,
            this.graphData.config
          );
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
  },
  computed: {
    graphData() {
      return {
        data: [
          {
            x: ["Apples", "Oranges", "Watermelon", "Pears"],
            y: [3, 2, 1, 4],
            type: "bar",
          },
        ],
        layout: {
          title: {
            text: "Hallo",
            font: {
              size: 24,
            },
            xref: "paper",
          },
          yaxis: {
            title: "Y",
            tickvals: [1, 2, 3, 4],
            tickmode: "array",
            automargin: true,
            titlefont: { size: 20 },
          },
          xaxis: {
            title: "X",
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
