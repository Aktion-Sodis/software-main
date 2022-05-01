<template>
  <div>
    <div></div>
    <div class="graph-wrapper" ref="plot1"></div>
  </div>
</template>

<script>
import Plotly from "plotly.js-dist";
import { mapState } from "vuex";

export default {
  computed: {
    ...mapState({
      graphData: (state) => state.charts.graphData,
    }),
  },
  mounted() {
    Plotly.newPlot(
      this.$refs.plot1,
      this.graphData.data,
      this.graphData.layout,
      this.graphData.config
    );
  },
};
</script>

<style scoped>
.graph-wrapper {
  height: 100%;
  width: 100%;
}
</style>