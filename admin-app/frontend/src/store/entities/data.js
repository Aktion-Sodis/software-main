import { DataStore } from '@aws-amplify/datastore';
import { API } from 'aws-amplify';
import { deleteEntityController, getAllEntities } from './utils';
import { dataTypesDict, modalModesDict } from '../constants';
import { updateEntity } from '../../graphql/mutations';

const entitiesData = {
  namespaced: true,
  state: () => ({
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
    addEntity: (state, entity) => {
      state.entities.push(entity);
    },
    replaceEntity: (state, entity) => {
      state.entities.splice(
        state.entities.findIndex((i) => i.id === entity.id),
        1,
        entity,
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
      DataStore.save(entityDraft)
        .then((postResponse) => {
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
        })
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
    },
    APIput: async ({ commit, dispatch }, entityDraft) => {
      commit('setLoading', { newValue: true });
      await API.graphql({
        query: updateEntity,
        variables: {
          input: {
            id: entityDraft.originalId,
            name: entityDraft.newData.name,
            description: entityDraft.newData.description,
            parentEntityID: entityDraft.newData.parentEntityID,
            _version: entityDraft.originalVersion,
          },
        },
      })
        .then(() => {
          dispatch(
            'SYNC_UI/refreshHandler',
            {
              routeName: 'OrganizationStructure',
            },
            {
              root: true,
            },
          );
        })
        .catch(() => {
          commit('setLoading', { newValue: false });
        });
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
    // sync is handled over in LEVEL_Data module
    APIgetAll: async () => (await getAllEntities()).data.listEntities.items,
  },
};

export default entitiesData;
