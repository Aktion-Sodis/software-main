import { API, graphqlOperation } from 'aws-amplify';
import { createIntervention, createLevel } from '../../graphql/mutations';
import { syncStatusDict } from '../constants';
import { waitForMilliseconds } from '../../lib/utils';

const SYNC_UI = {
  namespaced: true,
  state: () => ({
    status: syncStatusDict.synched,
    isStatusLocked: false,
  }),
  getters: {
    getStatus: ({ status }) => status,
    syncActionIcon: (_, { getState }) => getState,
  },
  mutations: {
    setStatus: (state, { newStatus }) => {
      if (!state.isStatusLocked) state.status = newStatus;
    },
    setIsStatusLocked: (state, { newValue }) => {
      state.isStatusLocked = newValue;
    },
  },
  actions: {
    refreshHandler: async ({ commit, dispatch }, { routeName }) => {
      commit('setStatus', { newStatus: syncStatusDict.synchronizing });
      if (routeName === 'Interventions') {
        await dispatch('INTERVENTION_Data/sync', null, { root: true });
      } else if (routeName === 'OrganizationStructure') {
        await dispatch('LEVEL_Data/sync', null, { root: true });
      } else if (routeName === 'Surveys') {
        await dispatch('SURVEY_Data/sync', null, { root: true });
      }
      commit('setStatus', { newStatus: syncStatusDict.synched });
      commit('setIsStatusLocked', { newValue: true });
      await waitForMilliseconds(5000);
      commit('setIsStatusLocked', { newValue: false });
      commit('setStatus', { newStatus: syncStatusDict.inSync });
    },
    createDummyInterventions: async () => {
      const interventions = [
        {
          name: 'Kitchen',
          description:
            'A kitchen is a room or part of a room used for cooking and food preparation in a dwelling or in a commercial establishment.',
          interventionType: 'TECHNOLOGY',
        },
        {
          name: 'Toilet',
          description:
            'A toilet is a piece of sanitary hardware that collects human urine and feces, and sometimes toilet paper, usually for disposal.',
          interventionType: 'TECHNOLOGY',
        },
        {
          name: 'Plantation',
          description:
            'A plantation is an agricultural estate, generally centered on a plantation house, meant for farming that specializes in cash crops, usually mainly planted with a single crop, with perhaps ancillary areas for vegetables for eating and so on.',
          interventionType: 'TECHNOLOGY',
        },
        {
          name: 'Birth Control',
          description:
            'Birth control, also known as contraception, anticonception, and fertility control, is a method or device used to prevent pregnancy.',
          interventionType: 'EDUCATION',
        },
        {
          name: 'Gender Equality',
          description:
            'Gender equality, also known as sexual equality or equality of the sexes, is the state of equal ease of access to resources and opportunities regardless of gender, including economic participation and decision-making; and the state of valuing different behaviors, aspirations and needs equally, regardless of gender. ',
          interventionType: 'EDUCATION',
        },
      ];
      /* eslint-disable */
      for (const intervention of interventions) {
        const apiIntervention = await API.graphql(
          graphqlOperation(createIntervention, {
            input: intervention,
          })
        );
        /* eslint-enable */
      }
    },
    createDummyLevels: async () => {
      const levels = [
        // {
        //   name: 'Gemeinde',
        //   description: 'Some description',
        //   parentLevelID: null,
        //   interventionsAreAllowed: false,
        //   customData: [],
        // },
        // {
        //   name: 'Dorf',
        //   description: 'Some description',
        //   interventionsAreAllowed: true,
        //   parentLevelID: '8393b581-8f07-49ed-b7d9-b71b0934d6f0',
        //   customData: [],
        // },
        {
          name: 'Family',
          description: 'Some description',
          parentLevelID: 'fbb10ca4-47b2-4bb2-ac74-89a60139d892',
          interventionsAreAllowed: true,
          customData: [],
        },
      ];
      /* eslint-disable */
      for (const level of levels) {
        const apiLevel = await API.graphql(
          graphqlOperation(createLevel, {
            input: level,
          })
        );
        /* eslint-enable */
      }
    },
  },
};

export default SYNC_UI;
