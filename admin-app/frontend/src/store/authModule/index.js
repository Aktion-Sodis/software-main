import { Auth, API, graphqlOperation } from 'aws-amplify';
import { getUser } from '../../graphql/queries';
import { createUser } from '../../graphql/mutations';

import i18n from '../../i18n';

const authModule = {
  namespaced: true,
  state: () => ({
    isAuthenticated: false,
    token: null,

    // "Credentials"
    userId: null,
    email: null,
    firstName: null,
    lastName: null,

    rememberSession: true,
    priorRouteActivity: Date.now(),
    lastRouteActivity: Date.now(),

    tempPassword: null,
  }),
  getters: {
    getIsAuthenticated: ({ isAuthenticated }) => isAuthenticated,
    getToken: ({ token }) => token,
    getUserId: ({ userId }) => userId,
    getEmail: ({ email }) => email,
    getFirstName: ({ firstName }) => firstName,
    getLastName: ({ lastName }) => lastName,

    credentials: (_, {
      getUserId, getEmail, getFirstName, getLastName,
    }) => ({
      userId: getUserId,
      email: getEmail,
      firstName: getFirstName,
      lastName: getLastName,
    }),

    getRememberSession: ({ rememberSession }) => rememberSession,
    getLastRouteActivity: ({ lastRouteActivity }) => lastRouteActivity,
    getPriorRouteActivity: ({ priorRouteActivity }) => priorRouteActivity,

    // <==> is it longer than an hour?
    lastRouteActivityDiffTooLarge: (_, { getLastRouteActivity, getPriorRouteActivity }) => getLastRouteActivity - getPriorRouteActivity > 1000 * 60 * 60,

    getTempPassword: ({ tempPassword }) => tempPassword,
  },
  mutations: {
    setIsAuthenticated(state, { newValue }) {
      state.isAuthenticated = newValue;
    },
    setCredentials(state, {
      userId, email, firstName, lastName,
    }) {
      state.userId = userId;
      state.email = email;
      state.firstName = firstName;
      state.lastName = lastName;
    },
    setToken(state, { newToken }) {
      state.token = newToken;
    },
    setRememberSession(state, { newValue }) {
      state.rememberSession = newValue;
    },
    updateRouteActivity(state) {
      state.priorRouteActivity = state.lastRouteActivity;
      state.lastRouteActivity = Date.now();
    },
    deleteRouteActivity(state) {
      state.priorRouteActivity = null;
      state.lastRouteActivity = null;
    },
    setTempPassword(state, { newValue }) {
      state.tempPassword = newValue;
    },
  },
  actions: {
    async signIn({ commit, dispatch }, { email, password, rememberMe }) {
      try {
        const x = await Auth.signIn(email, password);
        const { username, Session, challengeName } = x;

        // if password is not finalized
        if (challengeName === 'NEW_PASSWORD_REQUIRED') {
          commit('setCredentials', {
            userId: username,
            email,
            firstName: null,
            lastName: null,
          });
          commit('setToken', { newToken: Session });
          commit('setTempPassword', { newValue: password });
          return 'completeUserInfo';
        }

        const userFoundInDb = (await API.graphql(graphqlOperation(getUser, { id: username }))).data
          .getUser;

        // if user exists and password is finalized
        commit('setCredentials', {
          userId: username,
          email,
          firstName: userFoundInDb.firstName,
          lastName: userFoundInDb.lastName,
        });
        commit('setToken', { newToken: Session });
        commit('setIsAuthenticated', { newValue: true });
        commit('setRememberSession', { newValue: rememberMe });
        return 'success';
      } catch (error) {
        console.log({ error });
        dispatch(
          'FEEDBACK_UI/showFeedbackForDuration',
          {
            type: 'error',
            text: i18n.t(`general.errorCodes.${error.code}`),
          },
          { root: true },
        );
        commit('setToken', { newToken: null });
        commit('setIsAuthenticated', { newValue: false });
        commit('setCredentials', {
          userId: null,
          email,
          firstName: null,
          lastName: null,
        });
        return 'failed';
      }
    },

    async completeUserInformation(
      { commit, getters, dispatch },
      { firstName, lastName, newPassword },
    ) {
      if (!getters.getUserId) {
        dispatch(
          'FEEDBACK_UI/showFeedbackForDuration',
          {
            type: 'error',
            text: 'You cannot just update a user profile without following the sign in flow.',
          },
          { root: true },
        );
        return 'failed';
      }

      try {
        await Auth.completeNewPassword(
          await Auth.signIn(getters.getEmail, getters.getTempPassword),
          newPassword,
        );
      } catch (error) {
        console.log(error);
        commit('setToken', { newToken: null });
        commit('setIsAuthenticated', { newValue: false });
        return 'failed';
      }

      try {
        await API.graphql(
          graphqlOperation(createUser, {
            input: {
              id: getters.getUserId,
              firstName,
              lastName,
              permissions: [],
            },
          }),
        );
        commit('setCredentials', {
          userId: getters.getUserId,
          email: getters.getEmail,
          firstName,
          lastName,
        });
        commit('setToken', { newToken: 'Session' });
        commit('setIsAuthenticated', { newValue: true });
        commit('setTempPassword', { newValue: null });
        return 'success';
      } catch (error) {
        console.log(error);
        commit('setToken', { newToken: null });
        commit('setIsAuthenticated', { newValue: false });
        return 'failed';
      }
    },

    async forgotPassword(_, { email }) {
      try {
        await Auth.forgotPassword(email);
        return 'success';
      } catch (error) {
        console.log(error);
        return 'failed';
      }
    },

    async forgotPasswordSubmit({ getters }, { code, newPassword }) {
      try {
        await Auth.forgotPasswordSubmit(getters.getEmail, code, newPassword);
        return 'success';
      } catch (error) {
        console.log(error);
        return 'failed';
      }
    },

    async changePassword(_, { oldPassword, newPassword }) {
      try {
        const user = await Auth.currentAuthenticatedUser();
        await Auth.changePassword(user, oldPassword, newPassword);
        return 'success';
      } catch (error) {
        console.log(error);
        return 'failed';
      }
    },
    async deleteSession({ commit, dispatch }) {
      try {
        await Auth.signOut();
      } catch (error) {
        dispatch(
          'FEEDBACK_UI/showFeedbackForDuration',
          {
            type: 'error',
            text: error.errors[0].message,
          },
          { root: true },
        );
      }
      commit('setCredentials', {
        userId: null,
        email: null,
        firstName: null,
        lastName: null,
      });
      commit('deleteRouteActivity');
      commit('setToken', { newToken: null });
      commit('setIsAuthenticated', { newValue: false });
    },
  },
};

export default authModule;
