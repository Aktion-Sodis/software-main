<template>
    <v-navigation-drawer permanent expand-on-hover class="primary-dark" width="17rem" absolute>
        <!-- expand-on-hover -->
        <div class="side-bar-inner-wrapper">
            <v-list>
                <v-list-item class="px-2">
                    <v-list-item-avatar>
                        <v-img src="../../static/aktionSodisSmall.png"></v-img>
                    </v-list-item-avatar>
                    <v-list-item-title class="white--text text-body-1">{{ societyName }}</v-list-item-title>
                </v-list-item>
            </v-list>

            <v-list nav dense class="mt-12">
                <v-list-item
                    :to="{ name: 'Home' }"
                    exact
                    :class="currentRouteName === 'Home' ? 'primary darken-4' : ''"
                >
                    <v-list-item-icon>
                        <v-icon color="white">mdi-home-outline</v-icon>
                    </v-list-item-icon>
                    <v-list-item-title class="white--text text-body-1">Home</v-list-item-title>
                </v-list-item>
                <v-list-item
                    :to="{ name: 'BaseData' }"
                    :class="currentRouteName === 'BaseData' ? 'primary darken-4' : ''"
                >
                    <v-list-item-icon>
                        <v-icon color="white">mdi-domain</v-icon>
                    </v-list-item-icon>
                    <v-list-item-title class="white--text text-body-1">Base data</v-list-item-title>
                </v-list-item>
                <v-list-item
                    :to="{ name: 'OrganizationStructure' }"
                    :class="currentRouteName === 'OrganizationStructure' ? 'primary darken-4' : ''"
                >
                    <v-list-item-icon>
                        <v-icon color="white">mdi-clipboard-text-outline</v-icon>
                    </v-list-item-icon>
                    <v-list-item-title class="white--text text-body-1">Organization structure</v-list-item-title>
                </v-list-item>
                <v-list-item
                    :to="{ name: 'Technologies' }"
                    :class="currentRouteName === 'Technologies' ? 'primary darken-4' : ''"
                >
                    <v-list-item-icon>
                        <v-icon color="white">mdi-wrench-outline</v-icon>
                    </v-list-item-icon>
                    <v-list-item-title class="white--text text-body-1">Technologies</v-list-item-title>
                </v-list-item>
            </v-list>

            <v-list dense>
                <v-list-item link>
                    <v-list-item-icon>
                        <v-icon color="white">mdi-cog-outline</v-icon>
                    </v-list-item-icon>
                </v-list-item>
                <v-list-item class="px-2">
                    <v-list-item-avatar>
                        <v-img src="https://randomuser.me/api/portraits/women/75.jpg"></v-img>
                    </v-list-item-avatar>
                    <div class="next-to-avatar">
                        <v-list-item-content>
                            <v-list-item-title
                                class="text-h6 white--text"
                            >{{ credentials.firstname }} {{ credentials.lastname }}</v-list-item-title>
                            <v-list-item-subtitle class="white--text">{{ credentials.email }}</v-list-item-subtitle>
                        </v-list-item-content>
                        <v-btn @click="logout" class="mx-2" fab elevation="0" small color="primary">
                            <v-icon color="white">mdi-exit-to-app</v-icon>
                        </v-btn>
                    </div>
                </v-list-item>
            </v-list>
        </div>
    </v-navigation-drawer>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

const societyName = process.env.VUE_APP_SOCIETY_NAME

export default {
    name: "SideBar",
    data: () => ({ societyName }),
    computed: {
        ...mapGetters({
            isAuthenticated: "auth/getIsAuthenticated",
            credentials: "auth/getCredentials"
        }),
    },
    props: { currentRouteName: String },
    methods: {
        ...mapActions({
            deleteSession: 'auth/deleteSession'
        }),
        logout() {
            this.deleteSession();
            this.$router.push({ name: "Login" })
        }
    }
};
</script>

<style scoped>
.side-bar-inner-wrapper {
    height: 100vh;
    display: flex;
    justify-content: space-between;
    flex-direction: column;
}

.next-to-avatar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
}
</style>