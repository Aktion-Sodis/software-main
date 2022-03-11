import { v4 as uuidv4 } from 'uuid';
import { API, graphqlOperation } from 'aws-amplify';
import { listEntities } from '../../graphql/queries';
import { createEntity, updateEntity, deleteEntity } from '../../graphql/mutations';

export class EmptyEntity {
  constructor() {
    this.id = uuidv4();
    this.name = { languageKeys: ['en-US', 'es-ES', 'tr-TR'], languageTexts: ['', '', ''] };
    this.description = { languageKeys: ['en-US', 'es-ES', 'tr-TR'], languageTexts: ['', '', ''] };
    this.entityLevelId = '';
    this.parentEntityID = null;
    this._version = 1;
  }
}

export class Entity {
  constructor({
    id, name, description, entityLevelId, parentEntityID, _version,
  }) {
    this.id = id ?? uuidv4();
    this.name = name;
    this.description = description;
    this.entityLevelId = entityLevelId;
    this.parentEntityID = parentEntityID;
    this._version = _version;
  }
}

export const postEntityController = async (entityDraft) => API.graphql(
  graphqlOperation(createEntity, {
    input: {
      name: entityDraft.name,
      description: entityDraft.description,
      parentEntityID: entityDraft.parentEntityID,
      id: entityDraft.id,
      customData: [],
      entityLevelId: entityDraft.entityLevelId,
    },
  }),
);
export const putEntityController = async (entityDraft) => API.graphql(
  graphqlOperation(updateEntity, {
    input: {
      name: entityDraft.name,
      description: entityDraft.description,
      parentEntityID: entityDraft.parentEntityID,
      id: entityDraft.id,
      customData: entityDraft.customData,
      entityLevelId: entityDraft.entityLevelId,
      _version: entityDraft._version,
    },
  }),
);
export const deleteEntityController = async (entityDraft) => API.graphql(
  graphqlOperation(deleteEntity, {
    input: { id: entityDraft.id, _version: entityDraft._version },
  }),
);
export const getAllEntities = async () => API.graphql(graphqlOperation(listEntities));
