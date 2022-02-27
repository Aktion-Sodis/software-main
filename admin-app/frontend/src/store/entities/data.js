import {
  Entity, postNewEntity, putEntity, deleteEntity,
} from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

const entitiesData = {
  namespaced: true,
  state: () => ({
    entities: [
      {
        id: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
        name: 'Aachen',
        description: 'Some description',
        levelId: '5a93459f-f23d-44e6-a112-c41e90473a2d',
        upperEntityId: null,
        tagIds: ['2b6e7572-c026-48bf-aa54-0201d1a98e39'],
      },
      {
        id: 'afd8874d-ac52-4508-8351-f35f8f7e28a0',
        name: 'Sinop',
        description: 'Some description',
        levelId: '5a93459f-f23d-44e6-a112-c41e90473a2d',
        upperEntityId: null,
        tagIds: [],
      },
      {
        id: '0b38df2a-84f5-4066-9c0c-f447b93e8278',
        name: 'Nizzaallee',
        description: 'Some description',
        levelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
        upperEntityId: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
        tagIds: [],
      },
      {
        id: '3d29c7aa-f422-41bc-99ae-35480a1f415e',
        name: 'Mies van der Rohe Straße',
        description: 'Some description',
        levelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
        upperEntityId: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
        tagIds: [],
      },
      {
        id: '327ac9b8-ab56-47e0-a1c5-bd4c978645a0',
        name: 'Atatürk Caddesi',
        description: 'Some description',
        levelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
        upperEntityId: 'afd8874d-ac52-4508-8351-f35f8f7e28a0',
        tagIds: [],
      },
      {
        id: 'b046cde7-4f18-4fc9-9b13-eb49c98f226c',
        name: 'Eine 4er WG',
        description: 'Some description',
        levelId: 'd1faef12-cf15-4b5e-9637-b4ffbd156954',
        upperEntityId: '0b38df2a-84f5-4066-9c0c-f447b93e8278',
        tagIds: [],
      },
    ],

    entityTags: [
      { tagId: '2b6e7572-c026-48bf-aa54-0201d1a98e39', name: 'Tag 1' },
      { tagId: '6bc8b24c-9faa-47ad-973e-85b135136f08', name: 'Tag 2' },
    ],

    loading: false,
  }),
  getters: {
    /* READ */
    getEntities: ({ entities }) => entities,
    getEntityTags: ({ entityTags }) => entityTags,
    getLoading: ({ loading }) => loading,

    // sort by id for consistency
    allEntitiesByLevelId:
      (_, { getEntities }) => ({ levelId }) => getEntities.filter((e) => e.levelId === levelId).sort((a, b) => a.id - b.id),

    verticalOrderByEntityId:
      (_, { allEntitiesByLevelId }) => ({ entityId, levelId }) => allEntitiesByLevelId({ levelId }).findIndex((e) => e.id === entityId),

    maxVerticalOrderOfChildren:
      (_, { allEntitiesByLevelId }, rootState, rootGetters) => ({ entityId, levelId }) => {
        const allEntitiesInLowerLevel = allEntitiesByLevelId({
          levelId: rootGetters['LEVEL_Data/getLevels'].find((l) => l.upperLevelId === levelId)?.id,
        });
        const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
          (e) => e.upperEntityId === entityId,
        );
        return lowerLevelContainsChildren
          ? allEntitiesInLowerLevel.length
              - allEntitiesInLowerLevel.reverse().findIndex((e) => e.upperEntityId === entityId)
              - 1
          : -1;
      },
    minVerticalOrderOfChildren:
      (_, { allEntitiesByLevelId }, rootState, rootGetters) => ({ entityId, levelId }) => {
        const allEntitiesInLowerLevel = allEntitiesByLevelId({
          levelId: rootGetters['LEVEL_Data/getLevels'].find((l) => l.upperLevelId === levelId)?.id,
        });
        const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
          (e) => e.upperEntityId === entityId,
        );
        return lowerLevelContainsChildren
          ? allEntitiesInLowerLevel.findIndex((e) => e.upperEntityId === entityId)
          : -1;
      },

    hasDescendantsById:
      (_, { getEntities }) => ({ id }) => getEntities.some((e) => e.upperEntityId === id),

    hasParentByUpperEntityId:
      (_, { getEntities }) => ({ upperEntityId }) => upperEntityId && getEntities.some((e) => e.id === upperEntityId),

    ENTITYById:
      (_, { getEntities }) => ({ id }) => getEntities.find((i) => i.id === id),
    tagById:
      (_, { getEntityTags }) => ({ tagId }) => getEntityTags.find((t) => t.tagId === tagId),

    /* returns "lines" with the schema {id, id, indentation, y0, y1} */
    calculatedLines: (
      _,
      {
        allEntitiesByLevelId,
        hasDescendantsById,
        verticalOrderByEntityId,
        minVerticalOrderOfChildren,
        maxVerticalOrderOfChildren,
      },
      rootState,
      rootGetters,
    ) => {
      const lines = [];
      rootGetters['LEVEL_Data/sortedLevels'].forEach((l) => {
        const allParentsInLevel = allEntitiesByLevelId({ levelId: l.id }).filter((e) => hasDescendantsById({ id: e.id }));
        allParentsInLevel.forEach((p, index) => {
          const parentVerticalOrder = verticalOrderByEntityId({
            entityId: p.id,
            levelId: p.levelId,
          });
          const newLine = {
            levelId: l.id,
            entityId: p.id,
            indentation: index,
            y0: Math.min(
              minVerticalOrderOfChildren({ entityId: p.id, levelId: l.id }),
              parentVerticalOrder,
            ),
            y1: Math.max(
              maxVerticalOrderOfChildren({ entityId: p.id, levelId: l.id }),
              parentVerticalOrder,
            ),
          };
          lines.push(newLine);
        });
      });
      return lines;
    },

    calculatedLinesByLevelId:
      (_, { calculatedLines }, rootState, rootGetters) => ({ levelId }) => calculatedLines.filter(
        (li) => rootGetters['LEVEL_Data/getLevels'].find((le) => le.upperLevelId === li.levelId).id
            === levelId,
      ),

    lineByEntityId:
      (_, { calculatedLines }) => ({ id }) => calculatedLines.find((l) => l.entityId === id) || {
        indentation: 0,
      },
  },
  mutations: {
    addEntity: (state, {
      id, name, description, levelId, upperEntityId, tagIds,
    }) => {
      state.entities.push(
        new Entity({
          id,
          name,
          description,
          levelId,
          upperEntityId,
          tagIds,
        }),
      );
    },
    replaceEntity: (state, {
      id, name, description, levelId, upperEntityId, tagIds,
    }) => {
      state.entities.splice(
        state.entities.findIndex((i) => i.id === id),
        1,
        new Entity({
          id,
          name,
          description,
          levelId,
          upperEntityId,
          tagIds,
        }),
      );
    },
    deleteEntity: (state, { id }) => {
      state.entities.splice(
        Array.from(state.entities).findIndex((i) => i.id === id),
        1,
      );
    },
    setLoading: (state, { newValue }) => {
      state.loading = newValue;
    },

    deleteEntitiesByLevelId: (state, { levelId }) => {
      state.entities = state.entities.filter((e) => e.levelId !== levelId);
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch }, entityDraft) => {
      commit('setLoading', { newValue: true });
      const postResponse = await postNewEntity(entityDraft);
      commit('addEntity', postResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: postResponse.id,
          dataType: dataTypesDict.entity,
        },
        {
          root: true,
        },
      );

      commit('setLoading', { newValue: false });
    },
    APIput: async ({ commit, dispatch }, entityDraft) => {
      commit('setLoading', { newValue: true });
      const putResponse = await putEntity(entityDraft);
      commit('replaceEntity', putResponse);
      dispatch(
        'dataModal/readData',
        {
          dataId: putResponse.id,
          dataType: dataTypesDict.entity,
        },
        {
          root: true,
        },
      );
      commit('setLoading', { newValue: false });
    },
    APIdelete: async ({ commit, dispatch }, { id }) => {
      commit('setLoading', { newValue: true });
      const deleteResponse = await deleteEntity();
      if (deleteResponse.errors.length > 0) {
        commit('setLoading', { newValue: false });
      }
      commit('deleteEntity', {
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

export default entitiesData;
