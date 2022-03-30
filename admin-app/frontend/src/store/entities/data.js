import { DataStore } from '@aws-amplify/datastore';
import { Entity } from '../../models';
import { deleteEntityController, getAllEntities } from './utils';
import { dataTypesDict, modalModesDict } from '../constants';

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
    replaceEntity: (
      state,
      {
        id, name, description, entityLevelId, parentEntityID, _version, appliedInterventions,
      },
    ) => {
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
          appliedInterventions,
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
    APIput: async ({ commit }, entityDraft) => {
      commit('setLoading', { newValue: true });
      console.log(entityDraft);
      // DataStore.save(
      //   Entity.copyOf(entityDraft, (item) => {
      //     item.name = entityDraft.name;
      //     item.description = entityDraft.description;
      //     item.appliedInterventions = entityDraft.appliedInterventions;
      //     item.customData = entityDraft.customData;
      //     item.location = entityDraft.location;
      //     item.parentEntityID = entityDraft.parentEntityID;
      //   }),
      // )
      //   .then((putResponse) => {
      //     commit('replaceEntity', putResponse);
      //     dispatch(
      //       'dataModal/readData',
      //       {
      //         dataId: putResponse.data.updateEntity.id,
      //         dataType: dataTypesDict.entity,
      //       },
      //       {
      //         root: true,
      //       },
      //     );
      //     commit('setLoading', { newValue: false });
      //   })
      //   .catch(() => {
      //     commit('setLoading', { newValue: false });
      //   });
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
    CreateDummyEntities: async ({ dispatch }) => {
      const entities = [
        new Entity({
          id: '3',
          name: {
            languageKeys: ['en-US', 'es-BO', 'tr-TR'],
            languageTexts: ['Sucre', 'Sucre', 'Sucre'],
          },
          description: { languageKeys: ['en-US', 'es-BO', 'tr-TR'], languageTexts: ['', '', ''] },
          entityLevelId: '1',
          parentEntityID: '0',
        }),
      ];

      // eslint-disable-next-line
      for (const entity of entities) {
        dispatch('APIpost', entity);
      }
    },
    // sync is handled over LEVEL_Data module
    APIgetAll: async () => (await getAllEntities()).data.listEntities.items,
  },
};

export default entitiesData;
