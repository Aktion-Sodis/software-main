import { v4 as uuidv4 } from "uuid";

const organizationStructureModule = {
  namespaced: true,
  state: () => ({
    entityIdCurrentlyBeingEdited: null,
    entityModalIsDisplayed: false,
    levelIdOfEntityBeingCreated: null,

    levelIdCurrentlyBeingEdited: null,
    levelModalIsDisplayed: false,
  }),
  getters: {
    /* GENERIC GETTERS */
    getEntityModalIsEdit: (state) =>
      state.entityIdCurrentlyBeingEdited !== null,
    getEntityCurrentlyBeingEdited: (state, getters, rootState, rootGetters) =>
      rootGetters["entities/getEntityById"](
        state.entityIdCurrentlyBeingEdited
      ) || null,
    getEntityModalIsDisplayed: (state) => state.entityModalIsDisplayed,
    getLevelIdOfEntityBeingCreated: (state) =>
      state.levelIdOfEntityBeingCreated,

    getLevelModalIsEdit: (state) => state.levelIdCurrentlyBeingEdited !== null,
    getLevelCurrentlyBeingEdited: (state, getters, rootState, rootGetters) =>
      rootGetters["entities/getLevelById"](state.levelIdCurrentlyBeingEdited) ||
      null,
    getLevelModalIsDisplayed: (state) => state.levelModalIsDisplayed,
  },
  mutations: {
    setEntityIdCurrentlyBeingEdited: (state, entityId) => {
      state.entityIdCurrentlyBeingEdited = entityId;
    },
    setEntityModalIsDisplayed: (state, payload) => {
      state.entityModalIsDisplayed = payload;
    },
    setLevelIdCurrentlyBeingEdited: (state, levelId) => {
      state.levelIdCurrentlyBeingEdited = levelId;
    },
    setLevelModalIsDisplayed: (state, payload) => {
      state.levelModalIsDisplayed = payload;
    },
    setLevelIdOfEntityBeingCreated: (state, payload) => {
      state.levelIdOfEntityBeingCreated = payload;
    },
  },
  actions: {
    clickOnEditEntity: ({ commit, dispatch }, payload) => {
      commit("setEntityIdCurrentlyBeingEdited", payload);
      dispatch("showEntityModal");
    },
    clickOnAddNewEntity: ({ commit, dispatch }, payload) => {
      commit("setEntityIdCurrentlyBeingEdited", null);
      commit("setLevelIdOfEntityBeingCreated", payload);
      dispatch("showEntityModal");
    },
    saveLevel: (
      { commit },
      { levelName, levelDescription, upperLevelId, technologies }
    ) => {
      commit(
        "entities/injectNewLevel",
        { levelId: upperLevelId - 0.1, upperLevelId },
        {
          root: true,
        }
      );
      commit(
        "entities/addLevel",
        {
          name: levelName,
          description: levelDescription,
          levelId: uuidv4(),
          upperLevelId,
          allowedTechnologies: technologies,
        },
        { root: true }
      );
    },
    saveEntity: (
      { commit },
      {
        entityId,
        entityName,
        entityDescription,
        entityLevelId,
        entityUpperEntityId,
      }
    ) => {
      if (entityId === null)
        commit(
          "entities/injectNewEntity",
          {
            entityName,
            entityDescription,
            entityLevelId,
            entityUpperEntityId,
          },
          { root: true }
        );
      else
        commit(
          "entities/replaceEntity",
          {
            entityId,
            entityName,
            entityDescription,
            entityLevelId,
            entityUpperEntityId,
          },
          { root: true }
        );
    },
    showEntityModal: ({ commit }) => {
      commit("setEntityModalIsDisplayed", true);
    },
    showLevelModal: ({ commit }) => {
      commit("setLevelModalIsDisplayed", true);
    },
    closeEntityModal: ({ commit }) => {
      commit("setEntityIdCurrentlyBeingEdited", null);
      commit("setEntityModalIsDisplayed", false);
    },
    closeLevelModal: ({ commit }) => {
      commit("setLevelIdCurrentlyBeingEdited", null);
      commit("setLevelModalIsDisplayed", false);
    },
  },
};

export default organizationStructureModule;
