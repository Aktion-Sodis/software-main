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
    getHierarchialData: (state) => {
      return state.hierarchialData;
    },
    getHierarchialStructure: (state) => {
      return state.hierarchialStructure;
    },
    getAllDescendantsOfTreeRoot: (state) => {
      const treeRoot = state.treeRoot;
      let markArray = state.hierarchialData.map((e) => ({
        ...e,
        marked: false,
      }));

      return recursiveMarker(treeRoot, markArray);
    },
    getEntityIsDescendantOfTreeRoot: (state, getters) => (entityId) => {
      return getters.getAllDescendantsOfTreeRoot.some(
        (e) => e.entityId === entityId
      );
    },
    getHasChildren: (state, getters) => (entityId) => {
      return getters.getHierarchialData.some(
        (e) => e.upperEntityId === entityId
      );
    },
    getTreeRoot: (state) => {
      return state.treeRoot;
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
