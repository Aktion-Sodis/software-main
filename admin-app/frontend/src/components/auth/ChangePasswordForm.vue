<template>
  <v-form ref="form" @submit.prevent="submit" lazy-validation>
    <v-text-field
      outlined
      required
      v-model="oldPassword"
      :append-icon="showOldPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required, rules.min]"
      :type="showOldPassword ? 'text' : 'password'"
      name="input-10-1"
      :label="$t('changePassword.oldPassword.label')"
      :hint="$t('changePassword.oldPassword.hint')"
      @click:append="showOldPassword = !showOldPassword"
    ></v-text-field>
    <v-text-field
      outlined
      required
      v-model="newPassword"
      :append-icon="showNewPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required, rules.min]"
      :type="showNewPassword ? 'text' : 'password'"
      name="input-10-1"
      :label="$t('changePassword.newPassword.label')"
      :hint="$t('changePassword.newPassword.hint')"
      @click:append="showNewPassword = !showNewPassword"
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
  name: 'ChangePasswordForm',
  data() {
    return {
      oldPassword: '',
      newPassword: '',
      showOldPassword: false,
      showNewPassword: false,
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
      changePassword: 'auth/changePassword',
    }),
    async submit() {
      const valid = this.$refs.form.validate();
      if (!valid) return;

      this.loading = true;
      const changePasswordStatus = await this.changePassword({
        oldPassword: this.oldPassword,
        newPassword: this.newPassword,
      });
      if (changePasswordStatus === 'success') {
        console.log('redirect to orga struct');
        this.$router.push({ name: 'OrganizationStructure' });
        return;
      }
      if (changePasswordStatus === 'failed') {
        // TODO: handle error
        this.loading = false;
      }
    },
  },
};
</script>
