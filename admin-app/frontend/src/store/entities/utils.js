import { v4 as uuidv4 } from 'uuid';

export class EmptyEntity {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.levelId = '';
    this.upperEntityId = null;
    this.tagIds = [];
  }
}

export class Entity {
  constructor({
    id, name, description, levelId, upperEntityId, tagIds,
  }) {
    this.id = id ?? uuidv4();
    this.name = name;
    this.description = description;
    this.levelId = levelId;
    this.upperEntityId = upperEntityId;
    this.tagIds = tagIds;
  }
}

// Mock API calls
export const postNewEntity = async (x) => x;
export const putEntity = async (x) => x;
export const deleteEntity = async () => ({ errors: [] });
