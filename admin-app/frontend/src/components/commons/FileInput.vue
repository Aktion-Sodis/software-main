<template>
  <input type="file" :accept="acceptedType" @change="filesChange($event.target.files)" />
</template>

<script>
import { mapMutations } from 'vuex';
import { allowedFileUploadTypes } from '../../store/constants';

export default {
  name: 'FileInput',
  props: {
    acceptedType: {
      type: String,
      required: true,
      validator(value) {
        return allowedFileUploadTypes.includes(value);
      },
    },
  },
  methods: {
    ...mapMutations({
      setImageFile: 'dataModal/setImageFile',
    }),
    filesChange(files) {
      if (files.length !== 1) return;
      const file = files[0];
      if (file.size > 16000000) return;
      if (!allowedFileUploadTypes.includes(file.type)) return;
      this.setImageFile({ newValue: file });
    },
  },
};
</script>
