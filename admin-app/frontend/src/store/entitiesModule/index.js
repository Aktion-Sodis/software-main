import recursiveMarker from "./utils";

const entitiesModule = {
  namespaced: true,
  state: () => ({
    technologies: [
      { technologyId: 0, name: "Kitchen" },
      { technologyId: 1, name: "Toilet" },
      { technologyId: 2, name: "Plantation" },
    ],
    hierarchialStructure: [
      {
        name: "Gemeinde",
        hierarchyId: 0,
        upperHierarchy: null,
        allowedTechnologies: [],
      },
      {
        name: "Dorf",
        hierarchyId: 1,
        upperHierarchy: 0,
        allowedTechnologies: [2],
      },
      {
        name: "Family",
        hierarchyId: 2,
        upperHierarchy: 1,
        allowedTechnologies: [0, 1, 2],
      },
    ],
    hierarchialData: [
      { entityId: 0, hierarchyId: 0, upperEntityId: null, name: "Aachen" },
      { entityId: 4, hierarchyId: 0, upperEntityId: null, name: "Sinop" },
      { entityId: 2, hierarchyId: 1, upperEntityId: 0, name: "Nizzaallee" },
      {
        entityId: 1,
        hierarchyId: 1,
        upperEntityId: 0,
        name: "Mies van der Rohe Straße",
      },
      {
        entityId: 5,
        hierarchyId: 1,
        upperEntityId: 4,
        name: "Atatürk Mahallesi",
      },
      { entityId: 3, hierarchyId: 2, upperEntityId: 2, name: "Eine 4er WG" },
    ],
    treeRoot: {
      entityId: 0,
      hierarchyId: 0,
      upperEntityId: null,
      name: "Aachen",
    },
  }),
  getters: {
    getTechnologies: (state) => state.technologies,
    getTechnologyById: (state, getters) => (technologyId) =>
      getters.getTechnologies.find((e) => e.technologyId === technologyId),
    getHierarchialData: (state) => state.hierarchialData,
    getHierarchialStructure: (state) =>
      state.hierarchialStructure.sort((a, b) => a.hierarchyId - b.hierarchyId),
    getTreeRoot: (state) => state.treeRoot,
    getAllEntitiesOfHierarchyByHid: (state) => (hid) =>
      state.hierarchialData
        .filter((e) => e.hierarchyId === hid)
        .sort((a, b) => a.entityId - b.entityId), // sort by entityId ascending
    getEntityHasSiblingUnderIt: (state, getters) => (entityId, hid) => {
      const allDescendantsOfTreeRoot = getters.getAllDescendantsOfTreeRoot;
      const allDescendantsOfTreeRootAtHid = allDescendantsOfTreeRoot.filter(
        (e) => e.hierarchyId === hid
      );
      return (
        entityId !==
        Math.max(
          ...allDescendantsOfTreeRootAtHid
            .map((e) => e.entityId)
            .sort((a, b) => a - b) // sort by entityId ascending
        )
      );
    },
    getAllDescendantsOfTreeRoot: (state) =>
      recursiveMarker(
        state.treeRoot,
        state.hierarchialData.map((e) => ({
          ...e,
          marked: false,
        }))
      ),

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

    getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy:
      (state, getters) => (hid) => {
        const hierarchyContainsDescendent = getters
          .getAllEntitiesOfHierarchyByHid(hid)
          .some((e) => getters.getEntityIsInTree(e.entityId));

        return hierarchyContainsDescendent
          ? hid <= getters.getTreeRoot.hierarchyId
            ? 0
            : getters.getAllEntitiesOfHierarchyByHid(hid).length -
              getters
                .getAllEntitiesOfHierarchyByHid(hid)
                .sort((a, b) => b.entityId - a.entityId) // desc
                .findIndex((e) => getters.getEntityIsInTree(e.entityId)) -
              1
          : -1;
      },
    getMinVerticalOrderOfTreeRootDescendantsInAHierarchy:
      (state, getters) => (hid) => {
        const hierarchyContainsDescendent = getters
          .getAllEntitiesOfHierarchyByHid(hid)
          .some((e) => getters.getEntityIsInTree(e.entityId));

        return hierarchyContainsDescendent
          ? hid <= getters.getTreeRoot.hierarchyId
            ? 0
            : getters
                .getAllEntitiesOfHierarchyByHid(hid)
                .sort((a, b) => a.entityId - b.entityId) // asc
                .findIndex((e) => getters.getEntityIsInTree(e.entityId))
          : -1;
      },

    getEntityShouldHaveVerticalLine:
      (state, getters) => (entityId, upperEntityId, hid) => {
        const minVerticalOrderOfTreeRootDescendantsInAHierarchy =
          getters.getMinVerticalOrderOfTreeRootDescendantsInAHierarchy(hid);
        const maxVerticalOrderOfTreeRootDescendantsInAHierarchy =
          getters.getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy(hid);
        const verticalOrderOfParent = getters.getVerticalOrderByEntityId(
          upperEntityId,
          hid - 1
        );
        const verticalOrderOfSelf = getters.getVerticalOrderByEntityId(
          entityId,
          hid
        );
        if (
          verticalOrderOfParent <
          minVerticalOrderOfTreeRootDescendantsInAHierarchy
        ) {
          return (
            verticalOrderOfSelf <= verticalOrderOfParent &&
            verticalOrderOfSelf <
              maxVerticalOrderOfTreeRootDescendantsInAHierarchy
          );
        }
        if (
          verticalOrderOfParent >=
            minVerticalOrderOfTreeRootDescendantsInAHierarchy &&
          verticalOrderOfParent <=
            maxVerticalOrderOfTreeRootDescendantsInAHierarchy
        )
          return (
            verticalOrderOfSelf >=
              minVerticalOrderOfTreeRootDescendantsInAHierarchy &&
            verticalOrderOfSelf <
              maxVerticalOrderOfTreeRootDescendantsInAHierarchy
          );
        if (
          verticalOrderOfParent >
          maxVerticalOrderOfTreeRootDescendantsInAHierarchy
        ) {
          return (
            verticalOrderOfSelf <=
              minVerticalOrderOfTreeRootDescendantsInAHierarchy &&
            verticalOrderOfSelf < verticalOrderOfParent
          );
        }
      },

    getUpmostElementInTreeByHid: (state, getters) => (hid) =>
      getters.getAllEntitiesOfHierarchyByHid(hid),

    getEntityIsInTree: (state, getters) => (entityId) =>
      getters.getAllDescendantsOfTreeRoot.some(
        (e) => e.entityId === entityId
      ) || entityId === getters.getTreeRoot.entityId,
    getHasChildren: (state, getters) => (entityId) =>
      getters.getHierarchialData.some((e) => e.upperEntityId === entityId),
    getParentInTreeRoot: (state, getters) => (upperEntityId) =>
      upperEntityId === null
        ? getters.getTreeRoot
        : getters.getAllDescendantsOfTreeRoot
            .concat(getters.getTreeRoot)
            .find((e) => e.entityId === upperEntityId) || null,
  },
  mutations: {
    setTreeRoot: (state, payload) => {
      state.treeRoot = payload;
    },
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
  },
  actions: {
    clickOnEntity: ({ commit }, payload) => {
      commit("setTreeRoot", payload);
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
  },
};

export default entitiesModule;
