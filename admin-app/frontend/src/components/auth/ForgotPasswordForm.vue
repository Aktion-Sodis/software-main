<template>
  <v-form ref="form" @submit.prevent="submit" lazy-validation>
    <div v-if="isCodeSent">
      <v-text-field
        v-model="emailedCode"
        :rules="[rules.required, rules.notEmpty]"
        :label="$t('ForgotPassword.emailedCode')"
        :disabled="loading"
        required
        outlined
      ></v-text-field>
      <v-text-field
        v-model="newPassword1"
        :rules="[rules.required, rules.notEmpty]"
        :label="$t('ForgotPassword.newPassword1')"
        :disabled="loading"
        required
        outlined
        :append-icon="showPassword1 ? 'mdi-eye' : 'mdi-eye-off'"
        :type="showPassword1 ? 'text' : 'password'"
      ></v-text-field>
      <v-text-field
        v-model="newPassword2"
        :rules="[rules.required, rules.notEmpty]"
        :label="$t('ForgotPassword.newPassword2')"
        :disabled="loading"
        required
        outlined
        :append-icon="showPassword2 ? 'mdi-eye' : 'mdi-eye-off'"
        :type="showPassword2 ? 'text' : 'password'"
      ></v-text-field>
      <v-btn :disabled="loading" type="submit" block large color="primary" class="text-none">
        <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
        <span v-else>
          {{ $t('ForgotPassword.confirm') }}
        </span>
      </v-btn>
    </div>
    <div v-else>
      <v-text-field
        v-model="email"
        :rules="[rules.required]"
        :label="$t('Login.email')"
        :disabled="loading"
        required
        outlined
      ></v-text-field>

      <v-btn
        :disabled="loading"
        block
        large
        color="primary"
        class="text-none"
        @click="sendEmailCode"
      >
        <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
        <span v-else>
          {{ $t('ForgotPassword.sendCode') }}
        </span>
      </v-btn>
    </div>
  </v-form>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex';
import { formValidators } from '../../lib/utils';
import { routeNamesDict, signInStatusDict } from '../../lib/constants';

export default {
  name: 'ForgotPasswordForm',
  data() {
    return {
      email: '',
      emailedCode: '',
      newPassword1: '',
      newPassword2: '',
      showPassword1: false,
      showPassword2: false,
      loading: false,
      isCodeSent: false,
      rules: {
        required: formValidators.required,
        notEmpty: formValidators.notEmpty,
      },
    };
  },
  computed: {
    ...mapGetters({
      storedEmail: 'auth/getEmail',
    }),
  },
  mounted() {
    this.email = this.storedEmail || '';
  },
  methods: {
    ...mapActions({
      forgotPasswordSubmit: 'auth/forgotPasswordSubmit',
      forgotPassword: 'auth/forgotPassword',
      showFeedbackForDuration: 'FEEDBACK_UI/showFeedbackForDuration',
    }),
    ...mapMutations({
      setCredentials: 'auth/setCredentials',
    }),
    async sendEmailCode() {
      this.loading = true;
      const forgotPasswordStatus = await this.forgotPassword({ email: this.email });
      if (forgotPasswordStatus === signInStatusDict.success) {
        this.isCodeSent = true;
        this.setCredentials({ email: this.email });
        this.loading = false;
        this.$refs.form.reset();
      } else if (forgotPasswordStatus === signInStatusDict.failed) {
        this.showFeedbackForDuration({ type: 'error', message: 'Sth went wrong' });
      }
      this.loading = false;
    },
    async submit() {
      const valid = this.$refs.form.validate();
      if (!valid) return;

      if (this.newPassword1 !== this.newPassword2) return;

      this.loading = true;
      const forgotPasswordSubmitStatus = await this.forgotPasswordSubmit({
        code: this.emailedCode,
        newPassword: this.newPassword1,
      });
      if (forgotPasswordSubmitStatus === signInStatusDict.success) {
        this.showFeedbackForDuration({
          type: 'success',
          text: 'Successfully updated your password.',
        });
        this.$router.push({ name: routeNamesDict.Login });
        return;
      }
      if (forgotPasswordSubmitStatus === signInStatusDict.failed) {
        // TODO: handle error
        this.loading = false;
      }
    },
  },
};
</script>
