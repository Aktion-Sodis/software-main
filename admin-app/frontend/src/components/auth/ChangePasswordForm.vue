<template>
  <v-form ref="form" @submit.prevent="submit" lazy-validation>
    <v-text-field
      outlined
      required
      v-model="oldPassword"
      :append-icon="showOldPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required, rules.min]"
      :type="showOldPassword ? 'text' : 'password'"
      :label="$t('ChangePassword.oldPassword.label')"
      :hint="$t('ChangePassword.oldPassword.hint')"
      @click:append="showOldPassword = !showOldPassword"
    ></v-text-field>
    <v-text-field
      outlined
      required
      v-model="newPassword"
      :append-icon="showNewPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required, rules.minPasswordLength]"
      :type="showNewPassword ? 'text' : 'password'"
      :label="$t('ChangePassword.newPassword.label')"
      :hint="$t('ChangePassword.newPassword.hint')"
      @click:append="showNewPassword = !showNewPassword"
    ></v-text-field>
    <v-btn :disabled="loading" type="submit" block large color="primary" class="text-none">
      <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
      <span v-else>
        {{ $t('CompleteUserInfo.start') }}
      </span>
    </v-btn>
  </v-form>
</template>

<script>
import { mapActions } from 'vuex';
import { formValidators } from '../../lib/utils';
import { routeNamesDict, typesDictionary } from '../../lib/constants';

export default {
  name: 'ChangePasswordForm',
  data() {
    return {
      oldPassword: '',
      newPassword: '',
      showOldPassword: false,
      showNewPassword: false,
      loading: false,
      rules: {
        required: formValidators.required,
        minPasswordLength: formValidators.minPasswordLength,
        notEmpty: formValidators.notEmpty,
      },
    };
  },
  mounted() {
    this.$refs.form.reset();
  },
  methods: {
    ...mapActions({
      changePassword: 'auth/changePassword',
      showFeedbackForDuration: 'FEEDBACK_UI/showFeedbackForDuration',
    }),
    async submit() {
      const valid = this.$refs.form.validate();
      if (!valid) {
        this.showFeedbackForDuration({
          type: typesDictionary.error,
          text: this.$t('general.form.invalidForm'),
        });
        return;
      }

      this.loading = true;
      const changePasswordStatus = await this.changePassword({
        oldPassword: this.oldPassword,
        newPassword: this.newPassword,
      });
      if (changePasswordStatus === 'success') {
        this.$router.push({ name: routeNamesDict.OrganizationStructure });
        return;
      }
      if (changePasswordStatus === 'failed') {
        this.showFeedbackForDuration({
          text: this.$t('general.errorCodes.InternalErrorException'),
        });
        this.loading = false;
      }
    },
  },
};
</script>
