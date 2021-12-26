const entitiesModule = {
  namespaced: true,
  state: () => ({
    technologies: [
      { technologyId: 0, description: "Some description", name: "Kitchen" },
      { technologyId: 1, description: "Some description", name: "Toilet" },
      { technologyId: 2, description: "Some description", name: "Plantation" },
    ],
    hierarchialStructure: [
      {
        description: "Some description",
        name: "Gemeinde",
        hierarchyId: 0,
        upperHierarchy: null,
        allowedTechnologies: [],
      },
      {
        description: "Some description",
        name: "Dorf",
        hierarchyId: 1,
        upperHierarchy: 0,
        allowedTechnologies: [2],
      },
      {
        description: "Some description",
        name: "Family",
        hierarchyId: 2,
        upperHierarchy: 1,
        allowedTechnologies: [0, 1, 2],
      },
    ],
    hierarchialData: [
      {
        entityId: 0,
        hierarchyId: 0,
        upperEntityId: null,
        description: "Some description",
        name: "Aachen",
      },
      {
        entityId: 4,
        hierarchyId: 0,
        upperEntityId: null,
        description: "Some description",
        name: "Sinop",
      },
      {
        entityId: 2,
        hierarchyId: 1,
        upperEntityId: 0,
        description: "Some description",
        name: "Nizzaallee",
      },
      {
        entityId: 1,
        hierarchyId: 1,
        upperEntityId: 0,
        description: "Some description",
        name: "Mies van der Rohe Straße",
      },
      {
        entityId: 5,
        hierarchyId: 1,
        upperEntityId: 4,
        description: "Some description",
        name: "Atatürk Mahallesi",
      },
      {
        entityId: 3,
        hierarchyId: 2,
        upperEntityId: 2,
        description: "Some description",
        name: "Eine 4er WG",
      },
    ],
    entityIdCurrentlyBeingEdited: null,
    entityModalIsDisplayed: false,
    hierarchyIdOfEntityBeingCreated: null,
  }),
  getters: {
    /* GENERIC GETTERS */
    getTechnologies: (state) => state.technologies,
    getTechnologyById: (state, getters) => (technologyId) =>
      getters.getTechnologies.find((e) => e.technologyId === technologyId),
    getHierarchialData: (state) => state.hierarchialData,
    getHierarchialStructure: (state) =>
      state.hierarchialStructure.sort((a, b) => a.hierarchyId - b.hierarchyId),
    getEntityById: (state, getters) => (entityId) =>
      getters.getHierarchialData.find((e) => e.entityId === entityId),
    getAllEntitiesOfHierarchyByHid: (state) => (hid) =>
      state.hierarchialData
        .filter((e) => e.hierarchyId === hid)
        .sort((a, b) => a.entityId - b.entityId), // sort by entityId ascending

    /* VERTICAL CALCULATIONS */
    getVerticalOrderByEntityId: (state, getters) => (entityId, hid) =>
      getters
        .getAllEntitiesOfHierarchyByHid(hid)
        .sort((a, b) => a.entityId - b.entityId)
        .findIndex((e) => e.entityId === entityId),
    getParentIsAboveEntity:
      (state, getters) => (entityId, upperEntityId, hid) =>
        !!(
          getters.getVerticalOrderByEntityId(upperEntityId, hid - 1) <
            getters.getVerticalOrderByEntityId(entityId, hid) &&
          upperEntityId !== null &&
          hid !== 0
        ),
    getMaxVerticalOrderOfChildren:
      (state, getters) => (entityId, hierarchyIndex) => {
        const lowerHierarchyContainsChildren = getters
          .getAllEntitiesOfHierarchyByHid(hierarchyIndex + 1)
          .some((e) => e.upperEntityId === entityId);

        return lowerHierarchyContainsChildren
          ? getters.getAllEntitiesOfHierarchyByHid(hierarchyIndex + 1).length -
              getters
                .getAllEntitiesOfHierarchyByHid(hierarchyIndex + 1)
                .sort((a, b) => b.entityId - a.entityId) // desc
                .findIndex((e) => e.upperEntityId === entityId) -
              1
          : -1;
      },
    getMinVerticalOrderOfChildren:
      (state, getters) => (entityId, hierarchyIndex) => {
        const lowerHierarchyContainsChildren = getters
          .getAllEntitiesOfHierarchyByHid(hierarchyIndex + 1)
          .some((e) => e.upperEntityId === entityId);

        return lowerHierarchyContainsChildren
          ? getters
              .getAllEntitiesOfHierarchyByHid(hierarchyIndex + 1)
              .sort((a, b) => a.entityId - b.entityId) // asc
              .findIndex((e) => e.upperEntityId === entityId)
          : -1;
      },

    getHasDescendants: (state, getters) => (entityId) =>
      getters.getHierarchialData.some((e) => e.upperEntityId === entityId),
    getEntityHasParent: (state, getters) => (upperEntityId) => {
      return getters.getHierarchialData.some(
        (e) => e.entityId === upperEntityId
      );
    },

    /* returns "lines" with the schema {hierarchyId, entityId, indentation, y0, y1} */
    getCalculatedLines: (state, getters) => {
      let lines = [];
      getters.getHierarchialStructure.forEach((h) => {
        const allParentsInHierarchy = getters
          .getAllEntitiesOfHierarchyByHid(h.hierarchyId)
          .filter((e) => getters.getHasDescendants(e.entityId));
        allParentsInHierarchy.forEach((p, index) => {
          const parentVerticalOrder = getters.getVerticalOrderByEntityId(
            p.entityId,
            p.hierarchyId
          );
          lines.push({
            hierarchyId: h.hierarchyId,
            entityId: p.entityId,
            indentation: index,
            y0: Math.min(
              getters.getMinVerticalOrderOfChildren(p.entityId, h.hierarchyId),
              parentVerticalOrder
            ),
            y1: Math.max(
              getters.getMaxVerticalOrderOfChildren(p.entityId, h.hierarchyId),
              parentVerticalOrder
            ),
          });
        });
      });
      return lines;
    },

    getCalculatedLinesByHierarchyId: (state, getters) => (hierarchyId) =>
      getters.getCalculatedLines.filter(
        (l) => l.hierarchyId + 1 === hierarchyId
      ),
    getLineByEntityId: (state, getters) => (entityId) =>
      getters.getCalculatedLines.find((l) => l.entityId === entityId) || {
        indentation: 0,
      },

    getEntityModalIsEdit: (state) =>
      state.entityIdCurrentlyBeingEdited !== null,
    getEntityCurrentlyBeingEdited: (state, getters) =>
      getters.getEntityById(state.entityIdCurrentlyBeingEdited) || null,
    getEntityModalIsDisplayed: (state) => state.entityModalIsDisplayed,
    getHierarchyIdOfEntityBeingCreated: (state) =>
      state.hierarchyIdOfEntityBeingCreated,
  },
  mutations: {
    addLevel: (state, payload) => {
      state.hierarchialStructure = state.hierarchialStructure.concat(payload);
    },
    injectNewLevel: (state, newLevelId, upperLevelIdOfNewLevel) => {
      state.hierarchialStructure = state.hierarchialStructure.map((e) =>
        e.upperHierarchy === upperLevelIdOfNewLevel
          ? { ...e, upperHierarchy: newLevelId }
          : e
      );
    },
    injectNewEntity: (
      state,
      { entityName, entityDescription, entityHierarchyId, entityUpperEntityId }
    ) => {
      state.hierarchialData = state.hierarchialData.concat({
        entityId: Math.random() * 100,
        hierarchyId: entityHierarchyId,
        upperEntityId: entityUpperEntityId,
        description: entityDescription,
        name: entityName,
      });
    },
    replaceEntity: (
      state,
      {
        entityId,
        entityName,
        entityDescription,
        entityHierarchyId,
        entityUpperEntityId,
      }
    ) => {
      console.log("hey");
      state.hierarchialData = state.hierarchialData.map((e) =>
        e.entityId === entityId
          ? {
              entityId,
              hierarchyId: entityHierarchyId,
              upperEntityId: entityUpperEntityId,
              description: entityDescription,
              name: entityName,
            }
          : e
      );
    },
    setEntityIdCurrentlyBeingEdited: (state, entityId) => {
      state.entityIdCurrentlyBeingEdited = entityId;
    },
    setEntityModalIsDisplayed: (state, payload) => {
      state.entityModalIsDisplayed = payload;
    },
    setHierarchyIdOfEntityBeingCreated: (state, payload) => {
      state.hierarchyIdOfEntityBeingCreated = payload;
    },
  },
  actions: {
    clickOnEditEntity: ({ commit, dispatch }, payload) => {
      commit("setEntityIdCurrentlyBeingEdited", payload);
      dispatch("showEntityModal");
    },
    clickOnAddNewEntity: ({ commit, dispatch }, payload) => {
      console.log(payload);
      commit("setEntityIdCurrentlyBeingEdited", null);
      commit("setHierarchyIdOfEntityBeingCreated", payload);
      dispatch("showEntityModal");
    },
    saveNewLevel: (
      { commit },
      { levelName, levelDescription, upperHierarchy, technologies }
    ) => {
      commit("injectNewLevel", upperHierarchy + 0.1, upperHierarchy);
      commit("addLevel", {
        name: levelName,
        description: levelDescription,
        hierarchyId: upperHierarchy + 0.1,
        upperHierarchy,
        allowedTechnologies: technologies,
      });
    },
    saveEntity: (
      { commit },
      {
        entityId,
        entityName,
        entityDescription,
        entityHierarchyId,
        entityUpperEntityId,
      }
    ) => {
      console.log({ entityId });
      if (entityId === null)
        commit("injectNewEntity", {
          entityName,
          entityDescription,
          entityHierarchyId,
          entityUpperEntityId,
        });
      else
        commit("replaceEntity", {
          entityId,
          entityName,
          entityDescription,
          entityHierarchyId,
          entityUpperEntityId,
        });
    },
    showEntityModal: ({ commit }) => {
      commit("setEntityModalIsDisplayed", true);
    },
    closeEntityModal: ({ commit }) => {
      commit("setEntityIdCurrentlyBeingEdited", null);
      commit("setEntityModalIsDisplayed", false);
    },
  },
};

export default entitiesModule;
