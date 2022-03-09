import {
  Entity,
  postEntityController,
  putEntityController,
  deleteEntityController,
  getAllEntities,
} from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

const entitiesData = {
  namespaced: true,
  state: () => ({
    // entities: [
    //   {
    //     id: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
    //     name: 'Aachen',
    //     description: 'Some description',
    //     entityLevelId: '5a93459f-f23d-44e6-a112-c41e90473a2d',
    //     parentEntityID: null,
    //   },
    //   {
    //     id: 'afd8874d-ac52-4508-8351-f35f8f7e28a0',
    //     name: 'Sinop',
    //     description: 'Some description',
    //     entityLevelId: '5a93459f-f23d-44e6-a112-c41e90473a2d',
    //     parentEntityID: null,
    //   },
    //   {
    //     id: '0b38df2a-84f5-4066-9c0c-f447b93e8278',
    //     name: 'Nizzaallee',
    //     description: 'Some description',
    //     entityLevelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
    //     parentEntityID: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
    //   },
    //   {
    //     id: '3d29c7aa-f422-41bc-99ae-35480a1f415e',
    //     name: 'Mies van der Rohe Straße',
    //     description: 'Some description',
    //     entityLevelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
    //     parentEntityID: 'f77a7d3f-fb7f-434e-8be3-32b74269083c',
    //   },
    //   {
    //     id: '327ac9b8-ab56-47e0-a1c5-bd4c978645a0',
    //     name: 'Atatürk Caddesi',
    //     description: 'Some description',
    //     entityLevelId: 'e7a03934-90b9-405b-807b-3f748b15ae69',
    //     parentEntityID: 'afd8874d-ac52-4508-8351-f35f8f7e28a0',
    //   },
    //   {
    //     id: 'b046cde7-4f18-4fc9-9b13-eb49c98f226c',
    //     name: 'Eine 4er WG',
    //     description: 'Some description',
    //     entityLevelId: 'd1faef12-cf15-4b5e-9637-b4ffbd156954',
    //     parentEntityID: '0b38df2a-84f5-4066-9c0c-f447b93e8278',
    //   },
    // ],

    entities: [],

    loading: false,
  }),
  getters: {
    /* READ */
    getEntities: ({ entities }) => entities,
    getLoading: ({ loading }) => loading,

    // sort by id for consistency
    allEntitiesByLevelId:
      (_, { getEntities }) => ({ entityLevelId }) => getEntities.filter((e) => e.entityLevelId === entityLevelId).sort((a, b) => a.id - b.id),

    verticalOrderByEntityId:
      (_, { allEntitiesByLevelId }) => ({ entityId, entityLevelId }) => allEntitiesByLevelId({ entityLevelId }).findIndex((e) => e.id === entityId),

    maxVerticalOrderOfChildren:
      (_, { allEntitiesByLevelId }, rootState, rootGetters) => ({ entityId, entityLevelId }) => {
        const allEntitiesInLowerLevel = allEntitiesByLevelId({
          entityLevelId: rootGetters['LEVEL_Data/getLevels'].find(
            (l) => l.parentLevelID === entityLevelId,
          )?.id,
        });
        const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
          (e) => e.parentEntityID === entityId,
        );
        return lowerLevelContainsChildren
          ? allEntitiesInLowerLevel.length
              - allEntitiesInLowerLevel.reverse().findIndex((e) => e.parentEntityID === entityId)
              - 1
          : -1;
      },
    minVerticalOrderOfChildren:
      (_, { allEntitiesByLevelId }, rootState, rootGetters) => ({ entityId, entityLevelId }) => {
        const allEntitiesInLowerLevel = allEntitiesByLevelId({
          entityLevelId: rootGetters['LEVEL_Data/getLevels'].find(
            (l) => l.parentLevelID === entityLevelId,
          )?.id,
        });
        const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
          (e) => e.parentEntityID === entityId,
        );
        return lowerLevelContainsChildren
          ? allEntitiesInLowerLevel.findIndex((e) => e.parentEntityID === entityId)
          : -1;
      },

    hasDescendantsById:
      (_, { getEntities }) => ({ id }) => getEntities.some((e) => e.parentEntityID === id),

    hasParentByUpperEntityId:
      (_, { getEntities }) => ({ parentEntityID }) => parentEntityID && getEntities.some((e) => e.id === parentEntityID),

    ENTITYById:
      (_, { getEntities }) => ({ id }) => getEntities.find((i) => i.id === id),

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
        const allParentsInLevel = allEntitiesByLevelId({ entityLevelId: l.id }).filter((e) => hasDescendantsById({ id: e.id }));
        allParentsInLevel.forEach((p, index) => {
          const parentVerticalOrder = verticalOrderByEntityId({
            entityId: p.id,
            entityLevelId: p.entityLevelId,
          });
          const newLine = {
            entityLevelId: l.id,
            entityId: p.id,
            indentation: index,
            y0: Math.min(
              minVerticalOrderOfChildren({ entityId: p.id, entityLevelId: l.id }),
              parentVerticalOrder,
            ),
            y1: Math.max(
              maxVerticalOrderOfChildren({ entityId: p.id, entityLevelId: l.id }),
              parentVerticalOrder,
            ),
          };
          lines.push(newLine);
        });
      });
      return lines;
    },

    calculatedLinesByLevelId:
      (_, { calculatedLines }, rootState, rootGetters) => ({ entityLevelId }) => calculatedLines.filter(
        (li) => rootGetters['LEVEL_Data/getLevels'].find((le) => le.parentLevelID === li.entityLevelId)
          .id === entityLevelId,
      ),

    lineByEntityId:
      (_, { calculatedLines }) => ({ id }) => calculatedLines.find((l) => l.entityId === id) || {
        indentation: 0,
      },
  },
  mutations: {
    addEntity: (state, {
      id, name, description, entityLevelId, parentEntityID,
    }) => {
      state.entities.push(
        new Entity({
          id,
          name,
          description,
          entityLevelId,
          parentEntityID,
        }),
      );
    },
    replaceEntity: (state, {
      id, name, description, entityLevelId, parentEntityID, _version,
    }) => {
      state.entities.splice(
        state.entities.findIndex((i) => i.id === id),
        1,
        new Entity({
          id,
          name,
          description,
          entityLevelId,
          parentEntityID,
          _version,
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

    deleteEntitiesByLevelId: (state, { entityLevelId }) => {
      state.entities = state.entities.filter((e) => e.entityLevelId !== entityLevelId);
    },
    setEntities: (state, { newValue }) => {
      state.entities = newValue;
    },
  },
  actions: {
    APIpost: async ({ commit, dispatch }, entityDraft) => {
      commit('setLoading', { newValue: true });
      const postResponse = await postEntityController(entityDraft);
      if (postResponse?.errors?.length > 0) {
        commit('setLoading', { newValue: false });
        // error in API request
        return;
      }
      commit('addEntity', postResponse.data.createEntity);
      dispatch(
        'dataModal/readData',
        {
          dataId: postResponse.data.createEntity.id,
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
      const putResponse = await putEntityController(entityDraft);
      if (putResponse?.errors?.length > 0) {
        commit('setLoading', { newValue: false });
        // error in API request
        return;
      }
      commit('replaceEntity', putResponse.data.updateEntity);
      dispatch(
        'dataModal/readData',
        {
          dataId: putResponse.data.updateEntity.id,
          dataType: dataTypesDict.entity,
        },
        {
          root: true,
        },
      );
      commit('setLoading', { newValue: false });
    },
    APIdelete: async ({ commit, dispatch }, entityDraft) => {
      commit('setLoading', { newValue: true });
      const deleteResponse = await deleteEntityController(entityDraft);
      if (deleteResponse?.errors?.length > 0) {
        commit('setLoading', { newValue: false });
      }
      commit('deleteEntity', {
        id: entityDraft.id,
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
    // sync is handled over LEVEL_Data module
    APIgetAll: async () => (await getAllEntities()).data.listEntities.items,
  },
};

export default entitiesData;
