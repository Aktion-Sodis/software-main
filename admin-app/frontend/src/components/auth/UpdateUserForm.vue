<template>
  <v-form ref="form" @submit.prevent="submit" lazy-validation>
    <div class="d-flex flex-column flex-sm-row">
      <v-text-field
        v-model="firstName"
        :rules="[rules.required, rules.notEmpty]"
        :label="$t('completeUserInfo.firstName')"
        :disabled="loading"
        required
        outlined
      ></v-text-field>
      <v-text-field
        class="ml-0 ml-sm-4"
        v-model="lastName"
        :rules="[rules.required, rules.notEmpty]"
        :label="$t('completeUserInfo.lastName')"
        :disabled="loading"
        required
        outlined
      ></v-text-field>
    </div>
    <v-text-field
      outlined
      required
      v-model="password"
      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required, rules.minPasswordLength]"
      :type="showPassword ? 'text' : 'password'"
      name="input-10-1"
      :label="$t('completeUserInfo.password.label')"
      :hint="$t('completeUserInfo.password.hint')"
      @click:append="showPassword = !showPassword"
    ></v-text-field>
    <v-btn :disabled="loading" type="submit" block large color="primary" class="text-none">
      <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
      <span v-else>
        {{ $t('completeUserInfo.start') }}
      </span>
    </v-btn>
  </v-form>
</template>

<script>
import { mapActions } from 'vuex';
import { formValidators } from '../../lib/utils';
import { routeNamesDict, signInStatusDict, typesDictionary } from '../../lib/constants';

export default {
  name: 'UpdateUserForm',
  data() {
    return {
      firstName: null,
      lastName: null,
      password: '',
      showPassword: false,
      loading: false,
      rules: {
        required: formValidators.required,
        minPasswordLength: formValidators.minPasswordLength,
        notEmpty: formValidators.notEmpty,
      },
    };
  },
  methods: {
    ...mapActions({
      completeUserInformation: 'auth/completeUserInformation',
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
      const signInStatus = await this.completeUserInformation({
        firstName: this.firstName,
        lastName: this.lastName,
        newPassword: this.password,
      });
      if (signInStatus === signInStatusDict.success) {
        this.$router.push({ name: routeNamesDict.OrganizationStructure });
        return;
      }
      if (signInStatus === signInStatusDict.failed) {
        this.showFeedbackForDuration({
          type: typesDictionary.error,
          text: this.$t('general.errorCodes.InternalErrorException'),
        });
        return;
      }
      if (signInStatus === signInStatusDict.completeUserInfo) {
        this.$router.push({ name: routeNamesDict.CompleteUserInfo });
      }
    },
  },
};
</script>
