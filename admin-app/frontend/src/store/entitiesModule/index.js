import recursiveMarker from "./utils";

const entitiesModule = {
  namespaced: true,
  state: () => ({
    hierarchialStructure: [
      { name: "Gemeinde", hierarchyId: 0, upperHierarchy: null },
      { name: "Dorf", hierarchyId: 1, upperHierarchy: 0 },
      { name: "Family", hierarchyId: 2, upperHierarchy: 1 },
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
    getAllEntitiesOfHierarchyByHid: (state) => (hid) => {
      return state.hierarchialData
        .filter((e) => e.hierarchyId === hid)
        .sort((a, b) => a.entityId - b.entityId); // sort by entityId ascending
    },
    getEntityHasSiblingUnderIt: (state, getters) => (entityId, hid) => {
      const allDescendantsOfTreeRoot = getters.getAllDescendantsOfTreeRoot;
      const allDescendantsOfTreeRootAtHid = allDescendantsOfTreeRoot.filter(
        (e) => e.hierarchyId === hid
      );
      console.log(allDescendantsOfTreeRootAtHid);
      return (
        entityId !==
        Math.max(
          ...allDescendantsOfTreeRootAtHid
            .map((e) => e.entityId)
            .sort((a, b) => a - b) // sort by entityId ascending
        )
      );
    },
    getHierarchialData: (state) => state.hierarchialData,
    getHierarchialStructure: (state) => state.hierarchialStructure,
    getAllDescendantsOfTreeRoot: (state) =>
      recursiveMarker(
        state.treeRoot,
        state.hierarchialData.map((e) => ({
          ...e,
          marked: false,
        }))
      ),
    getEntityIsDescendantOfTreeRoot: (state, getters) => (entityId) =>
      getters.getAllDescendantsOfTreeRoot.some((e) => e.entityId === entityId),
    getHasChildren: (state, getters) => (entityId) =>
      getters.getHierarchialData.some((e) => e.upperEntityId === entityId),

    getTreeRoot: (state) => state.treeRoot,
    getParentInTreeRoot: (state, getters) => (upperEntityId) =>
      upperEntityId === null
        ? getters.getTreeRoot
        : getters.getAllDescendantsOfTreeRoot
            .concat(getters.getTreeRoot)
            .filter((e) => e.entityId === upperEntityId)[0] || null,
    getVerticalOrderByEntityId: (state, getters) => (entityId, hid) =>
      getters
        .getAllEntitiesOfHierarchyByHid(hid)
        .sort((a, b) => a.entityId - b.entityId)
        .findIndex((e) => e.entityId === entityId),
    getMaxVerticalOrderOfTreeRootDescendantsInAHierarchy:
      (state, getters) => (hid) => {
        const hierarchyContainsDescendent = getters
          .getAllEntitiesOfHierarchyByHid(hid)
          .some((e) => getters.getEntityIsDescendantOfTreeRoot(e.entityId));

        return hierarchyContainsDescendent
          ? hid <= getters.getTreeRoot.hierarchyId
            ? 0
            : getters.getAllEntitiesOfHierarchyByHid(hid).length -
              getters
                .getAllEntitiesOfHierarchyByHid(hid)
                .sort((a, b) => b.entityId - a.entityId) // asc
                .findIndex((e) =>
                  getters.getEntityIsDescendantOfTreeRoot(e.entityId)
                ) -
              1
          : -1;
      },
  },
  mutations: {
    setTreeRoot: (state, payload) => {
      state.treeRoot = payload;
    },
  },
  actions: {
    clickOnEntity: ({ commit }, payload) => {
      commit("setTreeRoot", payload);
    },
  },
};

export default entitiesModule;
