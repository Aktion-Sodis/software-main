<template>
  <input type="file" :accept="acceptedType" @change="filesChange($event.target.files)" />
</template>

<script>
import { mapActions, mapMutations } from 'vuex';
import { allowedFileUploadTypes, typesDictionary } from '../../../lib/constants';

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
    isForQuestions: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  methods: {
    ...mapMutations({
      setImageFile: 'dataModal/setImageFile',
    }),
    ...mapActions({
      addImageToQuestion: 'QUESTION_UI/addImageToQuestion',
      showFeedbackForDuration: 'FEEDBACK_UI/showFeedbackForDuration',
    }),
    filesChange(files) {
      let success = true;
      if (files.length !== 1) success = false;
      const file = files[0];
      if (file.size > 16000000 || !allowedFileUploadTypes.includes(file.type)) success = false;

      if (this.isForQuestions) {
        this.addImageToQuestion({ newQuestionImage: file });
      } else {
        this.setImageFile({ newValue: file });
      }

      this.showFeedbackForDuration({
        type: success ? typesDictionary.success : typesDictionary.error,
        text: this.$t(
          `general.operationFeedback.upload.${
            success ? typesDictionary.success : typesDictionary.error
          }`,
        ),
        duration: 2000,
      });
    },
  },
};
</script>
