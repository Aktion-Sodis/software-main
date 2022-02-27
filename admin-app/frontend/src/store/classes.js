import { v4 as uuidv4 } from 'uuid';

class EmptyEntity {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.levelId = '';
    this.upperEntityId = null;
    this.tagIds = [];
  }
}

class Entity {
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

class EmptyIntervention {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.tagIds = [];
    this.contents = [];
    this.isEmptyIntervention = true;
  }
}

class Intervention {
  constructor({
    id, name, description, tagIds, contents,
  }) {
    this.id = id ?? uuidv4();
    this.name = name ?? '';
    this.description = description ?? '';
    this.tagIds = tagIds ?? [];
    this.contents = contents ?? [];
    this.isEmptyIntervention = false;
  }
}

class EmptyLevel {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.upperLevelId = null;
    this.tagIds = [];
    this.allowedInterventions = [];
  }
}

class Level {
  constructor({
    id, name, upperLevelId, tagIds, allowedInterventions, description,
  }) {
    this.id = id ?? uuidv4();
    this.name = name;
    this.description = description;
    this.upperLevelId = upperLevelId;
    this.tagIds = tagIds;
    this.allowedInterventions = allowedInterventions;
  }
}

class EmptyQuestion {
  constructor() {
    this.questionText = '';
    this.questionType = 'text';
    this.answers = [{ answerText: '' }];
    this.isEmptyQuestion = true;
  }
}

class EmptyAnswer {
  constructor() {
    this.answerText = '';
    this.isEmptyAnswer = true;
  }
}

class Question {
  constructor({ questionText, questionType }) {
    this.questionText = questionText;
    this.questionType = questionType;
  }
}

class Answer {
  constructor({ answerText }) {
    this.answerText = answerText;
  }
}

class EmptySurvey {
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

class Survey {
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

export {
  EmptyEntity,
  Entity,
  EmptyIntervention,
  Intervention,
  EmptyLevel,
  Level,
  EmptyQuestion,
  EmptyAnswer,
  Question,
  Answer,
  EmptySurvey,
  Survey,
};
