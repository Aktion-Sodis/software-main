<template>
    <v-container fluid class="outer-wrapper grey lighten-5">
        <v-row class="inner-wrapper" no-gutters>
            <v-col class="login-wrapper" cols="12" md="6">
                <v-container fluid>
                    <v-row no-gutters class="login-row">
                        <v-col cols="11" sm="10" md="8">
                            <h1>{{ $t("login.title") }}</h1>
                            <p class="mb-8 mt-4">{{ $t("login.subtitle") }}</p>
                            <v-form ref="form" @submit.prevent="submit" lazy-validation>
                                <v-text-field
                                    v-model="username"
                                    :rules="[rules.required]"
                                    :label="$t('login.username')"
                                    required
                                    outlined
                                ></v-text-field>
                                <v-text-field
                                    v-model="password"
                                    :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                                    :rules="[rules.required]"
                                    :type="showPassword ? 'text' : 'password'"
                                    name="input-10-1"
                                    :label="$t('login.password')"
                                    @click:append="showPassword = !showPassword"
                                    outlined
                                ></v-text-field>
                                <div class="row-space-between">
                                    <v-checkbox
                                        class="my-0"
                                        v-model="rememberMe"
                                        :label="$t('login.remember-me')"
                                    ></v-checkbox>
                                    <p class="mt-1 py-0">{{ $t("login.forgot-password") }}</p>
                                </div>
                                <v-btn
                                    type="submit"
                                    block
                                    large
                                    color="primary"
                                    class="text-none"
                                >{{ $t('login.sign-in') }}</v-btn>
                                <v-btn
                                    type="submit"
                                    block
                                    outlined
                                    large
                                    color="grey"
                                    class="mt-2 text-none"
                                >
                                    <svg
                                        viewBox="0 0 24 24"
                                        width="24"
                                        height="24"
                                        xmlns="http://www.w3.org/2000/svg"
                                        class="mr-2"
                                    >
                                        <g transform="matrix(1, 0, 0, 1, 27.009001, -39.238998)">
                                            <path
                                                fill="#4285F4"
                                                d="M -3.264 51.509 C -3.264 50.719 -3.334 49.969 -3.454 49.239 L -14.754 49.239 L -14.754 53.749 L -8.284 53.749 C -8.574 55.229 -9.424 56.479 -10.684 57.329 L -10.684 60.329 L -6.824 60.329 C -4.564 58.239 -3.264 55.159 -3.264 51.509 Z"
                                            />
                                            <path
                                                fill="#34A853"
                                                d="M -14.754 63.239 C -11.514 63.239 -8.804 62.159 -6.824 60.329 L -10.684 57.329 C -11.764 58.049 -13.134 58.489 -14.754 58.489 C -17.884 58.489 -20.534 56.379 -21.484 53.529 L -25.464 53.529 L -25.464 56.619 C -23.494 60.539 -19.444 63.239 -14.754 63.239 Z"
                                            />
                                            <path
                                                fill="#FBBC05"
                                                d="M -21.484 53.529 C -21.734 52.809 -21.864 52.039 -21.864 51.239 C -21.864 50.439 -21.724 49.669 -21.484 48.949 L -21.484 45.859 L -25.464 45.859 C -26.284 47.479 -26.754 49.299 -26.754 51.239 C -26.754 53.179 -26.284 54.999 -25.464 56.619 L -21.484 53.529 Z"
                                            />
                                            <path
                                                fill="#EA4335"
                                                d="M -14.754 43.989 C -12.984 43.989 -11.404 44.599 -10.154 45.789 L -6.734 42.369 C -8.804 40.429 -11.514 39.239 -14.754 39.239 C -19.444 39.239 -23.494 41.939 -25.464 45.859 L -21.484 48.949 C -20.534 46.099 -17.884 43.989 -14.754 43.989 Z"
                                            />
                                        </g>
                                    </svg>
                                    {{ $t('login.sign-in-with-google') }}
                                </v-btn>
                                <div class="push-to-end mt-4">
                                    <p>
                                        {{ $t('login.dont-have-an-account') }}
                                        <a
                                            href="#"
                                            class="font-weight-bold font-italic text-decoration-none"
                                        >{{ $t('login.register-here') }}</a>
                                    </p>
                                </div>
                            </v-form>
                        </v-col>
                    </v-row>
                    <v-row no-gutters class="d-md-none mt-16">
                        <v-col cols="6" sm="4" offset="3" offset-sm="4">
                            <div class="rounded-xl pa-4 lg-rounded-pill society-icon-wrapper">
                                <img
                                    src="../static/aktionSodisBig.png"
                                    style="width: 100%;"
                                    alt="Aktion Sodis Logo"
                                />
                            </div>
                        </v-col>
                    </v-row>
                </v-container>
            </v-col>
            <v-col class="images-wrapper" cols="12" md="6">
                <v-container style="height: 100%" fluid>
                    <v-row style="height: 100%" no-gutters>
                        <v-col cols="6" offset="3" class="login-row">
                            <div
                                class="rounded-xl pa-4 lg-rounded-pill d-none d-md-block society-icon-wrapper"
                            >
                                <img
                                    src="../static/aktionSodisBig.png"
                                    style="width: 100%;"
                                    alt="Aktion Sodis Logo"
                                />
                            </div>
                        </v-col>
                    </v-row>
                </v-container>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name: "Login",
    data() {
        return {
            username: "",
            password: "",
            showPassword: false,
            rules: {
                required: value => !!value || this.requiredi18n,
            },
            rememberMe: true
        }
    },
    computed: {
        ...mapGetters({
            isAuthenticated: "auth/getIsAuthenticated",
        }),
        requiredi18n: function () {
            return this.$t("login.required")
        }
    },
    methods: {
        submit() {
            const valid = this.$refs.form.validate()
            if (valid) {
                const signInSuccess = this.$store.dispatch("auth/signIn", {
                    username: this.username
                })
                if (signInSuccess) {
                    this.$router.push({ name: "Home" })
                }
            }
        }
    }
};
</script>

<style scoped>
.outer-wrapper {
    padding: 0;
    height: 100%;
    overflow: hidden;
}
.inner-wrapper {
    height: 100%;
}

.login-wrapper {
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    z-index: 2;
}

.login-row {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    z-index: 1;
}
.images-wrapper {
    background-image: url("../static/colleagues.jpeg");
    background-size: cover;
    background-position: center;
    padding: 0;
    height: 100vh;
    overflow: hidden;
}

@media only screen and (max-width: 960px) {
    .images-wrapper {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 0;
    }

    .login-wrapper {
        background-color: rgba(255, 255, 255, 0.85);
        height: 100vh;
    }
}

.row-space-between {
    display: flex;
    justify-content: space-between;
}

.push-to-end {
    display: flex;
    justify-content: end;
}

.background-img {
    height: 100%;
}

.society-icon-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    max-width: 100%;
    z-index: 2;
    background-color: gray;
}
</style>