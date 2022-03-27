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
      :rules="[rules.required, rules.min]"
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
import { mapActions, mapGetters } from 'vuex';

const passwordMinChar = 8;

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
        required: (value) => !!value || this.$t('general.form.required'),
        min: (value) => value.length >= 8 || this.minCharNotMeti18n,
        notEmpty: (value) => !value || value.replace(/ /g, '') !== '' || this.requiredi18n,
      },
    };
  },
  computed: {
    ...mapGetters({}),
    minCharNotMeti18n() {
      return this.$t('general.form.minCharNotMet', {
        minChar: passwordMinChar,
      });
    },
  },
  methods: {
    ...mapActions({
      completeUserInformation: 'auth/completeUserInformation',
    }),
    async submit() {
      const valid = this.$refs.form.validate();
      if (!valid) return;

      this.loading = true;
      const signInStatus = await this.completeUserInformation({
        firstName: this.firstName,
        lastName: this.lastName,
        newPassword: this.password,
      });
      if (signInStatus === 'success') {
        console.log('redirect to orga struct');
        this.$router.push({ name: 'OrganizationStructure' });
        return;
      }
      if (signInStatus === 'failed') {
        // TODO: handle error
        this.loading = false;
        return;
      }
      if (signInStatus === 'completeUserInfo') {
        this.$router.push({ name: 'CompleteUserInfo' });
      }
    },
  },
};
</script>
