<template>
  <v-container fluid class="ma-0 pa-0">
    <v-row no-gutters>
      <v-col class="d-flex flex-column justify-center align-center" cols="12" md="6">
        <v-container fluid class="pt-16 pt-md-0">
          <v-row no-gutters class="d-flex justify-center align-center">
            <v-col cols="11" sm="10" md="8">
              <h1 v-if="$route.name === 'Login'">{{ $t('login.title') }}</h1>
              <h1 v-else-if="$route.name === 'CompleteUserInfo'">
                {{ $t('completeUserInfo.title') }}
              </h1>
              <h1 v-else-if="$route.name === 'ChangePassword'">
                {{ $t('changePassword.title') }}
              </h1>
              <h1 v-else-if="$route.name === 'ForgotPassword'">
                {{ $t('forgotPassword.title') }}
              </h1>
              <p class="mb-8 mt-4" v-if="$route.name === 'Login'">
                {{ $t('login.subtitle') }}
              </p>
              <p class="mb-8 mt-4" v-else-if="$route.name === 'CompleteUserInfo'">
                {{ $t('completeUserInfo.subtitle') }}
              </p>
              <p class="mb-8 mt-4" v-else-if="$route.name === 'ChangePassword'">
                {{ $t('changePassword.subtitle') }}
              </p>
              <p class="mb-8 mt-4" v-else-if="$route.name === 'ForgotPassword'">
                {{ $t('forgotPassword.subtitle') }}
              </p>

              <LoginForm v-if="$route.name === 'Login'" />
              <UpdateUserForm v-else-if="$route.name === 'CompleteUserInfo'" />
              <ChangePasswordForm v-else-if="$route.name === 'ChangePassword'" />
              <ForgotPasswordForm v-else-if="$route.name === 'ForgotPassword'" />
            </v-col>
          </v-row>
          <v-row no-gutters class="d-md-none mt-4 mt-md-16">
            <v-col cols="6" sm="4" offset="3" offset-sm="4">
              <a href="https://aktion-sodis.org/" target="_blank">
                <div
                  class="d-flex justify-center align-center rounded-xl pa-4 lg-rounded-pill grey"
                >
                  <img
                    src="../static/aktionSodisBig.png"
                    style="width: 100%"
                    alt="Aktion Sodis Logo"
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
              <a href="https://aktion-sodis.org/" target="_blank">
                <div class="rounded-xl pa-4 lg-rounded-pill d-none d-md-block grey">
                  <img
                    src="../static/aktionSodisBig.png"
                    style="width: 100%"
                    alt="Aktion Sodis Logo"
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
import { mapActions, mapGetters } from 'vuex';
import ChangePasswordForm from '../components/commons/ChangePasswordForm.vue';
import ForgotPasswordForm from '../components/commons/ForgotPasswordForm.vue';
import LoginForm from '../components/commons/LoginForm.vue';
import UpdateUserForm from '../components/commons/UpdateUserForm.vue';

export default {
  components: {
    LoginForm,
    UpdateUserForm,
    ChangePasswordForm,
    ForgotPasswordForm,
  },
  name: 'Auth',
  data() {
    return {};
  },
  computed: {
    ...mapGetters({}),
  },
  methods: {
    ...mapActions({}),
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
