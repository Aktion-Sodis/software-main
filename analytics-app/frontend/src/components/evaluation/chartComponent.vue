<template>
  <div>
    <div>{{}}</div>
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