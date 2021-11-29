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
      {
        entityId: 1,
        hierarchyId: 1,
        upperEntityId: 0,
        name: "Mies van der Rohe Straße",
      },
      { entityId: 2, hierarchyId: 1, upperEntityId: 0, name: "Nizzaallee" },
      { entityId: 3, hierarchyId: 2, upperEntityId: 2, name: "Eine 4er WG" },
    ],
  }),
  getters: {
    getAllEntitiesOfHierarchyByHid: (state) => (hid) => {
      return state.hierarchialData.filter((e) => e.hierarchyId === hid);
    },
    getHierarchialData: (state) => {
      return state.hierarchialData;
    },
    getHierarchialStructure: (state) => {
      return state.hierarchialStructure;
    },
  },
  mutations: {},
  actions: {},
};

export default entitiesModule;
