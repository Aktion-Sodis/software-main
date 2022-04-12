<template>
  <div style="height: 100%" class="pa-2">
    <div style="height: 100%" class="d-flex flex-column justify-space-around">
      <div class="d-flex flex-column align-center">
        <slot :clickHandler="clickHandler" name="creation-button"></slot>
        <h2 class="mt-2 mb-4">
          {{ $t(subtitleI18nSelector) }}
        </h2>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import { dataTypesDict } from '../../store/constants';

export default {
  name: 'DataCreationButtonCard',
  props: {
    subtitleI18nSelector: {
      type: String,
      required: true,
    },
    dataType: {
      type: String,
      required: true,
      validator: (value) => Object.values(dataTypesDict).includes(value),
    },
  },
  methods: {
    ...mapActions({
      createData: 'dataModal/createData',
    }),
    clickHandler() {
      this.createData({ dataType: this.dataType });
    },
  },
};
</script>
