/* Resolve the following "path"s by replacing the substrings with the strings given in the array "replace" in the back-end.
If cannot be resolved, use default values for images, and show an error message for audio, markdown etc.
The dollar signs are put so that it is more legible for the development. They are thought be replaced with the empty string
before replacing the other substrings. */

import { QuestionType, Type } from '../models';

export const databaseOntologies = Object.freeze({
  userPicPath: { path: 'userFiles/userID/pic.png', toBeReplaced: ['userID'] },
  levelPicPath: {
    path: 'levelFiles/levelID/pic.png',
    toBeReplaced: ['levelID'],
  },
  levelCustomDataPicPath: {
    path: 'levelFiles/levelID/customDataFiles/customDataID/pic.png',
    toBeReplaced: ['levelID', 'customDataID'],
  },
  interventionPicPath: {
    path: 'interventionFiles/interventionID/pic.png',
    toBeReplaced: ['interventionID'],
  },
  // interventionDocMdPath: {
  //   path: "interventionFiles/interventionID/documentFiles/documentID.md",
  //   toBeReplaced: ["interventionID", "documentID"],
  // },
  docPdfPath: {
    path: 'documentFiles/documentID/pdf.pdf',
    toBeReplaced: ['documentID'],
  },
  docPicPath: {
    path: 'documentFiles/documentID/pic.png',
    toBeReplaced: ['documentID'],
  },
  interventionSurveyPicPath: {
    path: 'interventionFiles/interventionID/surveyFiles/surveyID/pic.png',
    toBeReplaced: ['interventionID', 'surveyID'],
  },
  questionPicPath: {
    path: 'interventionFiles/interventionID/surveyFiles/surveyID/questionFiles/questionID/pic.png',
    toBeReplaced: ['interventionID', 'surveyID', 'questionID'],
  },
  questionOptionPicPath: {
    path: 'interventionFiles/interventionID/surveyFiles/surveyID/questionFiles/questionID/optionFiles/optionID/pic.png',
    toBeReplaced: ['interventionID', 'surveyID', 'questionID', 'optionID'],
  },
  questionPicAnswerPath: {
    path: 'appliedInterventionFiles/appliedInterventionID/executedSurveyFiles/executedSurveyID/questionFiles/questionID/pic.png',
    toBeReplaced: ['appliedInterventionID', 'executedSurveyID', 'questionID'],
  },
  questionAudioAnswerPath: {
    path: 'appliedInterventionFiles/appliedInterventionID/executedSurveyFiles/executedSurveyID/questionFiles/questionID/audio.mp3',
    toBeReplaced: ['appliedInterventionID', 'executedSurveyID', 'questionID'],
  },
  appliedInterventionPicPath: {
    path: 'appliedInterventionFiles/appliedInterventionID/pic.png',
    toBeReplaced: ['appliedInterventionID'],
  },
  entityPicPath: {
    path: 'entityFiles/entityID/pic.png',
    toBeReplaced: ['entityID'],
  },
  taskPicPath: { path: 'taskFiles/taskID/pic.png', toBeReplaced: ['taskID'] },
  taskAudioPath: {
    path: 'taskFiles/taskID/audio.mp3',
    toBeReplaced: ['taskID'],
  },
});

export const modalModesDict = Object.freeze({
  read: 'READ',
  edit: 'EDIT',
  create: 'CREATE',
});

export const questionTypesIconDict = Object.freeze({
  [QuestionType.TEXT]: 'mdi-text',
  [QuestionType.SINGLECHOICE]: 'mdi-radiobox-marked',
  [QuestionType.MULTIPLECHOICE]: 'mdi-checkbox-blank-outline',
  [QuestionType.PICTURE]: 'mdi-image',
  // [QuestionType.PICTUREWITHTAGS]: 'mdi-message-image',
  [QuestionType.AUDIO]: 'mdi-waveform',
});

export const customDataTypesIconDict = Object.freeze({
  [Type.INT]: 'mdi-numeric',
  [Type.STRING]: 'mdi-format-text',
});

export const dataTypesDict = Object.freeze({
  entity: 'ENTITY',
  survey: 'SURVEY',
  question: 'QUESTION',
  level: 'LEVEL',
  intervention: 'INTERVENTION',
});

export const dataModulesDict = Object.freeze({
  entity: `${dataTypesDict.entity}_Data`,
  survey: `${dataTypesDict.survey}_Data`,
  question: `${dataTypesDict.question}_Data`,
  level: `${dataTypesDict.level}_Data`,
  intervention: `${dataTypesDict.intervention}_Data`,
});

export const syncStatusDict = Object.freeze({
  inSync: 'inSync',
  synched: 'synched',
  synchronizing: 'synchronizing',
});

export const allowedFileUploadTypes = Object.freeze(['image/png', 'audio/mpeg', 'application/pdf']);

export const typesDictionary = Object.freeze({
  success: 'success',
  info: 'info',
  warning: 'warning',
  error: 'error',
});