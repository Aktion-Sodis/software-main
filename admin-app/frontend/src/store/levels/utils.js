import { v4 as uuidv4 } from 'uuid';
import { API, graphqlOperation } from 'aws-amplify';
import { listLevels } from '../../graphql/queries';
import { createLevel } from '../../graphql/mutations';

export class EmptyLevel {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.parentLevelID = null;
    this.allowedInterventions = [];
    this.levelAllowedInterventionsId = [];
  }
}

export class Level {
  constructor({
    id,
    name,
    parentLevelID,
    allowedInterventions,
    description,
    _version,
    levelAllowedInterventionsId,
  }) {
    this.id = id ?? uuidv4();
    this.name = name;
    this.description = description;
    this.parentLevelID = parentLevelID;
    this.allowedInterventions = allowedInterventions;
    this._version = _version;
    this.levelAllowedInterventionsId = levelAllowedInterventionsId;
  }
}

// Mock API calls
export const postNewLevel = async (levelDraft) => API.graphql(
  graphqlOperation(createLevel, {
    input: {
      name: levelDraft.name,
      description: levelDraft.description,
      parentLevelID: levelDraft.parentLevelID,
      id: levelDraft.id,
      interventionsAreAllowed: true,
      customData: [],
      levelAllowedInterventionsId: levelDraft.allowedInterventions,
    },
  }),
);
export const putLevel = async (levelDraft) => levelDraft;
export const deleteLevel = async () => ({ errors: [] });
export const getAllLevels = async () => API.graphql(graphqlOperation(listLevels));
