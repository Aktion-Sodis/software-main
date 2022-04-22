<template>
  <div v-if="$vuetify.breakpoint.name !== 'xs'">
    <v-text-field
      :label="$t('general.searchBox')"
      prepend-inner-icon="mdi-magnify"
      outlined
      dense
      background-color="grey"
      dark
      @focus="showToBeImplementedFeedback"
    ></v-text-field>
  </div>
  <div class="bottom-right-fixed" v-else>
    <v-btn fab dark small color="primary" @click="showToBeImplementedFeedback">
      <v-icon dark> mdi-magnify </v-icon>
    </v-btn>
  </div>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'SearchBox',
  methods: {
    ...mapActions({
      showToBeImplementedFeedback: 'FEEDBACK_UI/showToBeImplementedFeedback',
    }),
  },
};
</script>
