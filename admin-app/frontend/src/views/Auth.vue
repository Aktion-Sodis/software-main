<template>
  <v-container fluid class="ma-0 pa-0">
    <v-row no-gutters>
      <v-col class="d-flex flex-column justify-center align-center" cols="12" md="6">
        <v-container fluid class="pt-16 pt-md-0">
          <v-row no-gutters class="d-flex justify-center align-center">
            <v-col cols="11" sm="10" md="8">
              <h1>{{ $t(`${$route.name}.title`) }}</h1>
              <p class="mb-8 mt-4">
                {{ $t(`${$route.name}.subtitle`) }}
              </p>
              <LoginForm v-if="$route.name === routeNamesDict.Login" />
              <UpdateUserForm v-else-if="$route.name === routeNamesDict.CompleteUserInfo" />
              <ChangePasswordForm v-else-if="$route.name === routeNamesDict.ChangePassword" />
              <ForgotPasswordForm v-else-if="$route.name === routeNamesDict.ForgotPassword" />
            </v-col>
          </v-row>
          <v-row no-gutters class="d-md-none mt-4 mt-md-16">
            <v-col cols="6" sm="4" offset="3" offset-sm="4">
              <a :href="societyWebsiteHref" target="_blank">
                <div
                  class="d-flex justify-center align-center rounded-xl pa-4 lg-rounded-pill grey"
                >
                  <img
                    :src="requireSocietyLogoBig()"
                    style="width: 100%"
                    :alt="`${societyVerboseName} Logo`"
                  />
                </div>
              </a>
            </v-col>
          </v-row>
        </v-container>
      </v-col>
      <v-col class="centered-bg-img d-none d-md-block" style="height: 100vh" cols="12" md="6">
        <v-container style="height: 100%" fluid>
          <v-row style="height: 100%" no-gutters>
            <v-col cols="6" offset="3" class="d-flex justify-center align-center">
              <a :href="societyWebsiteHref" target="_blank">
                <div class="rounded-xl pa-4 lg-rounded-pill d-none d-md-block grey">
                  <img
                    :src="requireSocietyLogoBig()"
                    style="width: 100%"
                    :alt="`${societyVerboseName} Logo`"
                  />
                </div>
              </a>
            </v-col>
          </v-row>
        </v-container>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ChangePasswordForm from '../components/auth/ChangePasswordForm.vue';
import ForgotPasswordForm from '../components/auth/ForgotPasswordForm.vue';
import LoginForm from '../components/auth/LoginForm.vue';
import UpdateUserForm from '../components/auth/UpdateUserForm.vue';
import { routeNamesDict } from '../lib/constants';

export default {
  components: {
    LoginForm,
    UpdateUserForm,
    ChangePasswordForm,
    ForgotPasswordForm,
  },
  name: 'Auth',
  computed: {
    routeNamesDict() {
      return routeNamesDict;
    },
    societyVerboseName() {
      return process.env.VUE_APP_SOCIETY_VERBOSE_NAME || 'Aktion Sodis';
    },
    societyWebsiteHref() {
      return process.env.VUE_APP_SOCIETY_WEBSITE_HREF || 'https://aktion-sodis.org';
    },
  },
  methods: {
    requireSocietyLogoBig() {
      const societyLogoBigName = process.env.VUE_APP_LOGO_BIG;
      let res;
      try {
        // eslint-disable-next-line
        res = require(`../static/${societyLogoBigName}`);
      } catch {
        // eslint-disable-next-line
        res = require(`../static/aktionSodisBig.png`);
      }
      return res;
    },
  },
};
</script>

<style scoped>
.centered-bg-img {
  background-image: url('../static/colleagues.jpg');
  background-size: cover;
  background-position: center;
}
</style>
