// @ts-check
import { initSchema } from '@aws-amplify/datastore';
import { schema } from './schema';

const PermissionType = {
  "READ": "READ",
  "CHANGEMASTERDATA": "CHANGEMASTERDATA",
  "CREATEINTERVENTIONS": "CREATEINTERVENTIONS",
  "EXECUTESURVEYS": "EXECUTESURVEYS",
  "CREATESUBENTITIES": "CREATESUBENTITIES",
  "ADMIN": "ADMIN"
};

const InterventionType = {
  "TECHNOLOGY": "TECHNOLOGY",
  "EDUCATION": "EDUCATION"
};

const QuestionType = {
  "TEXT": "TEXT",
  "SINGLECHOICE": "SINGLECHOICE",
  "MULTIPLECHOICE": "MULTIPLECHOICE",
  "PICTURE": "PICTURE",
  "PICTUREWITHTAGS": "PICTUREWITHTAGS",
  "AUDIO": "AUDIO"
};

const SurveyType = {
  "INITIAL": "INITIAL",
  "DEFAULT": "DEFAULT"
};

const Type = {
  "INT": "INT",
  "STRING": "STRING"
};

const { User, Config, Level, Intervention, Content, ContentTag, Survey, SurveyTag, InterventionTag, Entity, AppliedIntervention, ExecutedSurvey, Task, SessionData, LevelInterventionRelation, InterventionContentRelation, InterventionInterventionTagRelation, ContentContentTagRelation, SurveySurveyTagRelation, I18nString, Permission, ColorTheme, Question, QuestionOption, CustomData, Location, AppliedCustomData, QuestionAnswer, Marking } = initSchema(schema);

export {
  User,
  Config,
  Level,
  Intervention,
  Content,
  ContentTag,
  Survey,
  SurveyTag,
  InterventionTag,
  Entity,
  AppliedIntervention,
  ExecutedSurvey,
  Task,
  SessionData,
  LevelInterventionRelation,
  InterventionContentRelation,
  InterventionInterventionTagRelation,
  ContentContentTagRelation,
  SurveySurveyTagRelation,
  PermissionType,
  InterventionType,
  QuestionType,
  SurveyType,
  Type,
  I18nString,
  Permission,
  ColorTheme,
  Question,
  QuestionOption,
  CustomData,
  Location,
  AppliedCustomData,
  QuestionAnswer,
  Marking
};