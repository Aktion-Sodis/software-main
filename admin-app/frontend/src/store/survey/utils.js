import { v4 as uuidv4 } from 'uuid';

export class EmptySurvey {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.type = 'Default';
    this.questionIds = [];
    this.creationDate = Date.now();
    this.lastEditDate = null;
    this.tags = [];
    this.isEmptySurvey = true;
  }
}

export class Survey {
  constructor({
    id, name, description, type, questionIds, creationDate, lastEditDate, tags,
  }) {
    this.id = id ?? uuidv4();
    this.name = name ?? '';
    this.description = description ?? '';
    this.type = type ?? 'Default';
    this.tags = tags ?? [];
    this.questionIds = questionIds ?? [];
    this.creationDate = creationDate ?? Date.now();
    this.lastEditDate = lastEditDate ?? null;
    this.isEmptySurvey = false;
  }
}
