<template>
  <v-form ref="form" @submit.prevent="submit" lazy-validation>
    <v-text-field
      v-model="email"
      :rules="[rules.required]"
      :label="$t('Login.email')"
      :disabled="loading"
      required
      outlined
    ></v-text-field>
    <v-text-field
      v-model="password"
      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required]"
      :type="showPassword ? 'text' : 'password'"
      :label="$t('Login.password')"
      @click:append="showPassword = !showPassword"
      :disabled="loading"
      outlined
    ></v-text-field>
    <div class="d-flex justify-space-between">
      <v-checkbox
        class="my-0"
        v-model="rememberMe"
        :label="$t('Login.rememberMe')"
        :disabled="loading"
      ></v-checkbox>
      <div class="mt-1" @click="forgotPasswordHandler" style="cursor: pointer">
        <p class="py-0">{{ $t('Login.forgotPassword') }}</p>
      </div>
    </div>
    <v-btn :disabled="loading" type="submit" block large color="primary" class="text-none">
      <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
      <span v-else>
        {{ $t('Login.signIn') }}
      </span>
    </v-btn>
    <v-btn
      type="submit"
      block
      outlined
      large
      color="grey"
      class="mt-2 text-none"
      :disabled="loading"
      @click.prevent="showToBeImplementedFeedback"
    >
      <GoogleIcon />
      {{ $t('Login.withGoogle') }}
    </v-btn>
    <div class="d-flex justify-end mt-4">
      <p>
        {{ $t('Login.dontHaveAnAccount') }}
        <span>
          {{ $t('Login.askYourAdmin') }}
        </span>
      </p>
    </div>
  </v-form>
</template>

<script>
import { mapActions, mapMutations } from 'vuex';
import { formValidators } from '../../lib/utils';
import { routeNamesDict, signInStatusDict, vuexModulesDict } from '../../lib/constants';
import GoogleIcon from '../commons/GoogleIcon.vue';

export default {
  components: { GoogleIcon },
  name: 'LoginForm',
  data() {
    return {
      email: null,
      password: null,
      showPassword: false,
      rules: {
        required: formValidators.required,
      },
      rememberMe: true,
      loading: false,
    };
  },
  methods: {
    ...mapActions({
      showToBeImplementedFeedback: `${vuexModulesDict.feedback}/showToBeImplementedFeedback`,
      showFeedbackForDuration: `${vuexModulesDict.feedback}/showFeedbackForDuration`,
      signIn: `${vuexModulesDict.auth}/signIn`,
    }),
    ...mapMutations({
      setCredentials: `${vuexModulesDict.auth}/setCredentials`,
    }),
    async submit() {
      const valid = this.$refs.form.validate();
      if (!valid) return;

      this.loading = true;
      const signInStatus = await this.signIn({
        email: this.email,
        password: this.password,
        rememberMe: this.rememberMe,
      });
      if (signInStatus === signInStatusDict.success) {
        this.$router.push({ name: routeNamesDict.OrganizationStructure });
        return;
      }
      if (signInStatus === signInStatusDict.failed) {
        this.loading = false;
        // TODO: handle error
        return;
      }
      if (signInStatus === signInStatusDict.completeUserInfo) {
        this.$router.push({ name: routeNamesDict.CompleteUserInfo });
      }
    },
    forgotPasswordHandler() {
      this.setCredentials({ email: this.email || '' });
      this.$router.push({ name: routeNamesDict.ForgotPassword });
    },
  },
};
</script>
