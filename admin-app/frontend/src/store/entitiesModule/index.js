import { v4 as uuidv4 } from "uuid";

const entitiesModule = {
  namespaced: true,
  state: () => ({
    technologies: [
      {
        technologyId: "bd5f6df6-a64c-4d60-9df2-8f29bb7944d5",
        description: "Some description",
        name: "Kitchen",
      },
      {
        technologyId: "59fe15e7-59ad-46bf-a196-cbab81885d5b",
        description: "Some description",
        name: "Toilet",
      },
      {
        technologyId: "c220fb83-a0e4-4463-a28a-f21b260e609a",
        description: "Some description",
        name: "Plantation",
      },
    ],
    levels: [
      {
        description: "Some description",
        name: "Gemeinde",
        levelId: "5a93459f-f23d-44e6-a112-c41e90473a2d",
        upperLevelId: null,
        allowedTechnologies: [],
      },
      {
        description: "Some description",
        name: "Dorf",
        levelId: "e7a03934-90b9-405b-807b-3f748b15ae69",
        upperLevelId: "5a93459f-f23d-44e6-a112-c41e90473a2d",
        allowedTechnologies: ["bd5f6df6-a64c-4d60-9df2-8f29bb7944d5"],
      },
      {
        description: "Some description",
        name: "Family",
        levelId: "d1faef12-cf15-4b5e-9637-b4ffbd156954",
        upperLevelId: "e7a03934-90b9-405b-807b-3f748b15ae69",
        allowedTechnologies: [
          "bd5f6df6-a64c-4d60-9df2-8f29bb7944d5",
          "59fe15e7-59ad-46bf-a196-cbab81885d5b",
          "c220fb83-a0e4-4463-a28a-f21b260e609a",
        ],
      },
    ],
    entities: [
      {
        entityId: "f77a7d3f-fb7f-434e-8be3-32b74269083c",
        levelId: "5a93459f-f23d-44e6-a112-c41e90473a2d",
        upperEntityId: null,
        description: "Some description",
        name: "Aachen",
      },
      {
        entityId: "afd8874d-ac52-4508-8351-f35f8f7e28a0",
        levelId: "5a93459f-f23d-44e6-a112-c41e90473a2d",
        upperEntityId: null,
        description: "Some description",
        name: "Sinop",
      },
      {
        entityId: "0b38df2a-84f5-4066-9c0c-f447b93e8278",
        levelId: "e7a03934-90b9-405b-807b-3f748b15ae69",
        upperEntityId: "f77a7d3f-fb7f-434e-8be3-32b74269083c",
        description: "Some description",
        name: "Nizzaallee",
      },
      {
        entityId: "3d29c7aa-f422-41bc-99ae-35480a1f415e",
        levelId: "e7a03934-90b9-405b-807b-3f748b15ae69",
        upperEntityId: "f77a7d3f-fb7f-434e-8be3-32b74269083c",
        description: "Some description",
        name: "Mies van der Rohe Straße",
      },
      {
        entityId: "327ac9b8-ab56-47e0-a1c5-bd4c978645a0",
        levelId: "e7a03934-90b9-405b-807b-3f748b15ae69",
        upperEntityId: "afd8874d-ac52-4508-8351-f35f8f7e28a0",
        description: "Some description",
        name: "Atatürk Mahallesi",
      },
      {
        entityId: "b046cde7-4f18-4fc9-9b13-eb49c98f226c",
        levelId: "d1faef12-cf15-4b5e-9637-b4ffbd156954",
        upperEntityId: "0b38df2a-84f5-4066-9c0c-f447b93e8278",
        description: "Some description",
        name: "Eine 4er WG",
      },
    ],
    entityIdCurrentlyBeingEdited: null,
    entityModalIsDisplayed: false,
    levelIdOfEntityBeingCreated: null,

    levelIdCurrentlyBeingEdited: null,
    levelModalIsDisplayed: false,
  }),
  getters: {
    /* GENERIC GETTERS */
    getTechnologies: (state) => state.technologies,
    getTechnologyById: (state, getters) => (technologyId) =>
      getters.getTechnologies.find((e) => e.technologyId === technologyId),
    getEntities: (state) => state.entities,
    getLevels: (state) => state.levels, // not sorted. Use with care.
    getSortedLevels: (state, getters) =>
      getters.getLevels.sort((a, b) => getters.hierarchySort(a, b)),

    // used in the getter "getSortedLevels". Don't use directly outside of Vuex environment.
    hierarchySort: (state, getters) => (a, b) => {
      if (a.upperLevelId === null) return -1;
      if (b.upperLevelId === null) return 1;
      if (a.levelId === b.upperLevelId) return -1;
      return getters.hierarchySort(a, getters.getLevelById(b.upperLevelId));
    },

    getEntityById: (state, getters) => (entityId) =>
      getters.getEntities.find((e) => e.entityId === entityId),
    getLevelById: (state, getters) => (levelId) =>
      getters.getLevels.find((e) => e.levelId === levelId),
    getAllEntitiesOfLevelByHid: (state) => (levelId) =>
      state.entities
        .filter((e) => e.levelId === levelId)
        .sort((a, b) => a.entityId - b.entityId), // sort by entityId for consistency

    getUpperLevelById: (state, getters) => (levelId) => {
      const upperLevelId = getters.getLevelById(levelId).upperLevelId;
      return getters.getLevels.find((l) => l.entityId === upperLevelId);
    },

    /* VERTICAL CALCULATIONS */
    getVerticalOrderByEntityId: (state, getters) => (entityId, levelId) =>
      getters
        .getAllEntitiesOfLevelByHid(levelId)
        .findIndex((e) => e.entityId === entityId),

    getMaxVerticalOrderOfChildren: (state, getters) => (entityId, levelId) => {
      const allEntitiesInLowerLevel = getters.getAllEntitiesOfLevelByHid(
        getters.getLevels.find((l) => l.upperLevelId === levelId).levelId
      );
      const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
        (e) => e.upperEntityId === entityId
      );
      return lowerLevelContainsChildren
        ? allEntitiesInLowerLevel.length -
            allEntitiesInLowerLevel
              .reverse()
              .findIndex((e) => e.upperEntityId === entityId) -
            1
        : -1;
    },
    getMinVerticalOrderOfChildren: (state, getters) => (entityId, levelId) => {
      const allEntitiesInLowerLevel = getters.getAllEntitiesOfLevelByHid(
        getters.getLevels.find((l) => l.upperLevelId === levelId).levelId
      );
      const lowerLevelContainsChildren = allEntitiesInLowerLevel.some(
        (e) => e.upperEntityId === entityId
      );
      return lowerLevelContainsChildren
        ? allEntitiesInLowerLevel.findIndex((e) => e.upperEntityId === entityId)
        : -1;
    },

    getHasDescendants: (state, getters) => (entityId) =>
      getters.getEntities.some((e) => e.upperEntityId === entityId),
    getEntityHasParent: (state, getters) => (upperEntityId) => {
      return getters.getEntities.some((e) => e.entityId === upperEntityId);
    },

    /* returns "lines" with the schema {levelId, entityId, indentation, y0, y1} */
    getCalculatedLines: (state, getters) => {
      let lines = [];
      getters.getSortedLevels.forEach((h) => {
        const allParentsInLevel = getters
          .getAllEntitiesOfLevelByHid(h.levelId)
          .filter((e) => getters.getHasDescendants(e.entityId));
        allParentsInLevel.forEach((p, index) => {
          const parentVerticalOrder = getters.getVerticalOrderByEntityId(
            p.entityId,
            p.levelId
          );
          const newLine = {
            levelId: h.levelId,
            entityId: p.entityId,
            indentation: index,
            y0: Math.min(
              getters.getMinVerticalOrderOfChildren(p.entityId, h.levelId),
              parentVerticalOrder
            ),
            y1: Math.max(
              getters.getMaxVerticalOrderOfChildren(p.entityId, h.levelId),
              parentVerticalOrder
            ),
          };
          lines.push(newLine);
        });
      });
      return lines;
    },

    getCalculatedLinesByLevelId: (state, getters) => (levelId) =>
      getters.getCalculatedLines.filter(
        (li) =>
          getters.getLevels.find((le) => le.upperLevelId === li.levelId)
            .levelId === levelId
      ),
    getLineByEntityId: (state, getters) => (entityId) =>
      getters.getCalculatedLines.find((l) => l.entityId === entityId) || {
        indentation: 0,
      },
  },
  mutations: {
    addLevel: (state, payload) => {
      state.levels = state.levels.concat(payload);
    },
    injectNewLevel: (state, { levelId, upperLevelId }) => {
      state.levels = state.levels.map((e) =>
        e.upperLevelId === upperLevelId ? { ...e, upperLevelId: levelId } : e
      );
    },
    injectNewEntity: (
      state,
      { entityName, entityDescription, entityLevelId, entityUpperEntityId }
    ) => {
      state.entities = state.entities.concat({
        entityId: uuidv4(),
        levelId: entityLevelId,
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
        entityLevelId,
        entityUpperEntityId,
      }
    ) => {
      state.entities = state.entities.map((e) =>
        e.entityId === entityId
          ? {
              entityId,
              levelId: entityLevelId,
              upperEntityId: entityUpperEntityId,
              description: entityDescription,
              name: entityName,
            }
          : e
      );
    },
  },
};

export default entitiesModule;
