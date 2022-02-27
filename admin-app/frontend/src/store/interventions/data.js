import {
  Intervention, postNewIntervention, putIntervention, deleteIntervention,
} from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

const interventionsData = {
  namespaced: true,
  state: () => ({
    interventions: [
      {
        id: 'bd5f6df6-a64c-4d60-9df2-8f29bb7944d5',
        name: 'Kitchen',
        description:
          'A kitchen is a room or part of a room used for cooking and food preparation in a dwelling or in a commercial establishment.',
        tagIds: ['7bbe9c5f-1784-41c5-8795-ae449ec95498'],
        contents: [
          {
            id: 'eff8b64c-22e9-4b34-948e-465a3f5b9a4a',
            type: 'MarkdownDocument',
            name: 'Some explanatory document',
            description:
              'IKEA is a Swedish-origin Dutch-headquartered multinational conglomerate that designs and sells ready-to-assemble furniture, kitchen appliances and home accessories, among other goods and home services.',
            tagIds: ['1a19542e-509a-4648-8280-bf5acb9825d7'],
          },
        ],
      },
      {
        id: '59fe15e7-59ad-46bf-a196-cbab81885d5b',
        name: 'Toilet',
        description:
          'A toilet is a piece of sanitary hardware that collects human urine and feces, and sometimes toilet paper, usually for disposal.',
        tagIds: ['7bbe9c5f-1784-41c5-8795-ae449ec95498'],
        contents: [],
      },
      {
        id: 'c220fb83-a0e4-4463-a28a-f21b260e609a',
        name: 'Plantation',
        description:
          'A plantation is an agricultural estate, generally centered on a plantation house, meant for farming that specializes in cash crops, usually mainly planted with a single crop, with perhaps ancillary areas for vegetables for eating and so on.',
        tagIds: ['7bbe9c5f-1784-41c5-8795-ae449ec95498'],
        contents: [],
      },
      {
        id: '5f463cd0-22d3-4321-960d-a4e01efeeccf',
        name: 'Birth Control',
        description:
          'Birth control, also known as contraception, anticonception, and fertility control, is a method or device used to prevent pregnancy.',
        tagIds: ['c1f87fc0-9e7c-400c-aec5-73719a87642a', '4b139d0e-1d61-4317-8cc6-1e1364d3b6b9'],
        contents: [
          {
            id: '300cc45e-f212-42a9-a940-367df3fd1dbb',
            type: 'Image',
            name: 'Some explanatory image',
            description:
              'An image (from Latin: imago) is an artifact that depicts visual perception, such as a photograph or other two-dimensional picture, that resembles a subject—usually a physical object—and thus provides a depiction of it.',
            tagIds: ['1a19542e-509a-4648-8280-bf5acb9825d7'],
          },
          {
            id: '2c3fb7fe-c23c-4164-a6e7-2fc4e969f18c',
            type: 'Video',
            name: 'Some explanatory video',
            description:
              'Video is an electronic medium for the recording, copying, playback, broadcasting, and display of moving visual media.',
            tagIds: ['1a19542e-509a-4648-8280-bf5acb9825d7'],
          },
        ],
      },
      {
        id: 'a7dcb0d2-28ca-4679-aa98-f2fc07c66066',
        name: 'Gender Equality',
        description:
          'Gender equality, also known as sexual equality or equality of the sexes, is the state of equal ease of access to resources and opportunities regardless of gender, including economic participation and decision-making; and the state of valuing different behaviors, aspirations and needs equally, regardless of gender. ',
        tagIds: ['c1f87fc0-9e7c-400c-aec5-73719a87642a', '4b139d0e-1d61-4317-8cc6-1e1364d3b6b9'],
        contents: [],
      },
    ],
    interventionTags: [
      { tagId: '7bbe9c5f-1784-41c5-8795-ae449ec95498', name: 'Technology' },
      { tagId: '4b139d0e-1d61-4317-8cc6-1e1364d3b6b9', name: 'Education' },
      { tagId: 'c1f87fc0-9e7c-400c-aec5-73719a87642a', name: 'Social' },
    ],
    interventionContentTags: [
      { tagId: '1a19542e-509a-4648-8280-bf5acb9825d7', name: 'Content tag 1' },
    ],

    loading: false,
  }),
  getters: {
    /* READ */
    getInterventions: ({ interventions }) => interventions,
    getInterventionTags: ({ interventionTags }) => interventionTags,
    getLoading: ({ loading }) => loading,

    INTERVENTIONById:
      (_, { getInterventions }) => ({ id }) => getInterventions.find((i) => i.id === id),
    tagById:
      (_, { getInterventionTags }) => ({ tagId }) => getInterventionTags.find((t) => t.tagId === tagId),
  },
  mutations: {
    addIntervention: (state, {
      id, name, description, tagIds, contents,
    }) => {
      state.interventions.push(
        new Intervention({
          id,
          name,
          description,
          tagIds,
          contents,
        }),
      );
    },
    replaceIntervention: (state, {
      id, name, description, tagIds, contents,
    }) => {
      state.interventions.splice(
        state.interventions.findIndex((i) => i.id === id),
        1,
        new Intervention({
          id,
          name,
          description,
          tagIds,
          contents,
        }),
      );
    },
    deleteIntervention: (state, { id }) => {
      state.interventions.splice(
        Array.from(state.interventions).findIndex((i) => i.id === id),
        1,
      );
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch }, interventionDraft) => {
      commit('setLoading', { newValue: true });
      const postResponse = await postNewIntervention(interventionDraft);
      commit('addIntervention', postResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: postResponse.id,
          dataType: dataTypesDict.intervention,
        },
        {
          root: true,
        },
      );

      commit('setLoading', { newValue: false });
    },
    APIput: async ({ commit, dispatch }, interventionDraft) => {
      commit('setLoading', { newValue: true });
      const putResponse = await putIntervention(interventionDraft);
      commit('replaceIntervention', putResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: putResponse.id,
          dataType: dataTypesDict.intervention,
        },
        {
          root: true,
        },
      );
      commit('setLoading', { newValue: false });
    },
    APIdelete: async ({ commit, dispatch }, { id }) => {
      commit('setLoading', { newValue: true });
      const deleteResponse = await deleteIntervention();
      if (deleteResponse.errors.length > 0) {
        commit('setLoading', { newValue: false });
      }
      commit('deleteIntervention', {
        id,
      });
      commit('dataModal/setDataIdInFocus', { newValue: null }, { root: true });
      commit('dataModal/setMode', { newValue: modalModesDict.read }, { root: true });
      dispatch(
        'dataModal/abortReadData',
        {},
        {
          root: true,
        },
      );

      commit('setLoading', { newValue: false });
    },
  },
};

export default interventionsData;
