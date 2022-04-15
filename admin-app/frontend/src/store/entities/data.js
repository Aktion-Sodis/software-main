import { DataStore } from '@aws-amplify/datastore';
import { API, Storage } from 'aws-amplify';
import { dataTypesDict, modalModesDict } from '../../lib/constants';
import { deleteEntity } from '../../graphql/mutations';
import { AppliedCustomData, Entity, I18nString } from '../../models';
import { deriveFilePath } from '../../lib/utils';

const entitiesData = {
  namespaced: true,
  state: () => ({
    entities: [],

    loading: false,
  }),
  getters: {
    /* READ */
    getEntities: ({ entities }) => entities.filter((e) => !e._deleted),
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
    APIpost: async ({ commit, dispatch, rootGetters }, entityDraft) => {
      let success = true;
      commit('setLoading', { newValue: true });

      const entity = new Entity({
        ...entityDraft,
        name: new I18nString(entityDraft.name),
        description: new I18nString(entityDraft.description),
        customData: entityDraft.customData.map((cd) => new AppliedCustomData(cd)),
      });

      try {
        const postResponse = await DataStore.save(entity);

        if (rootGetters['dataModal/getImageFile'] instanceof File) {
          try {
            await Storage.put(
              deriveFilePath('entityPicPath', { entityID: postResponse.id }),
              rootGetters['dataModal/getImageFile'],
            );
          } catch {
            success = false;
          }
        }

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
      } catch (error) {
        success = false;
        console.log(error);
      }

      commit('setLoading', { newValue: false });
      return success;
    },
    APIput: async ({
      commit, dispatch, getters, rootGetters,
    }, { newData, originalId }) => {
      commit('setLoading', { newValue: true });
      let success = true;

      const original = getters.ENTITYById({ id: originalId });

      try {
        const putResponse = await DataStore.save(
          Entity.copyOf(original, (updated) => {
            updated.name = newData.name;
            updated.description = newData.description;
            updated.parentEntityID = newData.parentEntityID;
            updated.customData = newData.customData.map((cd) => new AppliedCustomData(cd));
          }),
        );

        if (rootGetters['dataModal/getImageFile'] instanceof File) {
          try {
            console.log(deriveFilePath('entityPicPath', { entityID: putResponse.id }));
            await Storage.put(
              deriveFilePath('entityPicPath', { entityID: putResponse.id }),
              rootGetters['dataModal/getImageFile'],
            );
          } catch {
            success = false;
          }
        }

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
      } catch (error) {
        console.log('hey', error);
        success = false;
      }

      commit('setLoading', { newValue: false });
      return success;
    },
    APIdelete: async ({ commit, dispatch }, { id, _version }) => {
      let success = true;
      commit('setLoading', { newValue: true });

      try {
        await API.graphql({
          query: deleteEntity,
          variables: { input: { id, _version } },
        });
      } catch {
        success = false;
      }

      if (success) {
        Storage.remove(deriveFilePath('entityPicPath', { entityID: id }));
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
      }

      commit('setLoading', { newValue: false });
      return success;
    },
    APIgetAll: async () => {
      try {
        return await DataStore.query(Entity);
      } catch {
        return [];
      }
    },
  },
};

export default entitiesData;
