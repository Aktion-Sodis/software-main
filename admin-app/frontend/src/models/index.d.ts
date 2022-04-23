import { ModelInit, MutableModel, PersistentModelConstructor } from "@aws-amplify/datastore";

export enum PermissionType {
  READ = "READ",
  CHANGEMASTERDATA = "CHANGEMASTERDATA",
  CREATEINTERVENTIONS = "CREATEINTERVENTIONS",
  EXECUTESURVEYS = "EXECUTESURVEYS",
  CREATESUBENTITIES = "CREATESUBENTITIES",
  ADMIN = "ADMIN"
}

export enum InterventionType {
  TECHNOLOGY = "TECHNOLOGY",
  EDUCATION = "EDUCATION"
}

export enum QuestionType {
  TEXT = "TEXT",
  SINGLECHOICE = "SINGLECHOICE",
  MULTIPLECHOICE = "MULTIPLECHOICE",
  PICTURE = "PICTURE",
  PICTUREWITHTAGS = "PICTUREWITHTAGS",
  AUDIO = "AUDIO",
  INT = "INT",
  DOUBLE = "DOUBLE",
  RATING = "RATING"
}

export enum SurveyType {
  INITIAL = "INITIAL",
  DEFAULT = "DEFAULT"
}

export enum Type {
  INT = "INT",
  STRING = "STRING"
}

export declare class I18nString {
  readonly languageKeys: string[];
  readonly languageTexts: string[];
  constructor(init: ModelInit<I18nString>);
}

export declare class Permission {
  readonly permissionType: PermissionType | keyof typeof PermissionType;
  readonly allowedEntities: string[];
  constructor(init: ModelInit<Permission>);
}

export declare class ColorTheme {
  readonly highlight?: string | null;
  readonly secondaryHighlight?: string | null;
  readonly backgroundOneLight?: string | null;
  readonly backgroundTwoLight?: string | null;
  readonly backgroundOneDark?: string | null;
  readonly backgroundTwoDark?: string | null;
  constructor(init: ModelInit<ColorTheme>);
}

export declare class Question {
  readonly id: string;
  readonly text: I18nString;
  readonly type: QuestionType | keyof typeof QuestionType;
  readonly questionOptions?: QuestionOption[] | null;
  readonly isFollowUpQuestion: boolean;
  constructor(init: ModelInit<Question>);
}

export declare class QuestionOption {
  readonly id: string;
  readonly text: I18nString;
  readonly followUpQuestionID?: string | null;
  constructor(init: ModelInit<QuestionOption>);
}

export declare class CustomData {
  readonly id: string;
  readonly name: I18nString;
  readonly type: Type | keyof typeof Type;
  constructor(init: ModelInit<CustomData>);
}

export declare class Location {
  readonly latitude?: number | null;
  readonly longitude?: number | null;
  constructor(init: ModelInit<Location>);
}

export declare class AppliedCustomData {
  readonly customDataID: string;
  readonly type: Type | keyof typeof Type;
  readonly name: I18nString;
  readonly intValue?: number | null;
  readonly stringValue?: string | null;
  constructor(init: ModelInit<AppliedCustomData>);
}

export declare class QuestionAnswer {
  readonly id: string;
  readonly questionID: string;
  readonly date: string;
  readonly type: QuestionType | keyof typeof QuestionType;
  readonly text?: string | null;
  readonly int?: number | null;
  readonly double?: number | null;
  readonly rating?: number | null;
  readonly questionOptions?: QuestionOption[] | null;
  readonly markings?: Marking[] | null;
  constructor(init: ModelInit<QuestionAnswer>);
}

export declare class Marking {
  readonly x: number;
  readonly y: number;
  readonly rx: number;
  readonly ry: number;
  readonly text: string;
  constructor(init: ModelInit<Marking>);
}

type UserMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ConfigMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type LevelMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type InterventionMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ContentMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ContentTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type SurveyMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type SurveyTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type InterventionTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type EntityMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type AppliedInterventionMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ExecutedSurveyMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type TaskMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type SessionDataMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type LevelInterventionRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type InterventionContentRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type InterventionInterventionTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ContentContentTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type SurveySurveyTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

export declare class User {
  readonly id: string;
  readonly firstName: string;
  readonly lastName: string;
  readonly bio?: string | null;
  readonly permissions: Permission[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<User, UserMetaData>);
  static copyOf(source: User, mutator: (draft: MutableModel<User, UserMetaData>) => MutableModel<User, UserMetaData> | void): User;
}

export declare class Config {
  readonly id: string;
  readonly name: string;
  readonly colorTheme?: ColorTheme | null;
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<Config, ConfigMetaData>);
  static copyOf(source: Config, mutator: (draft: MutableModel<Config, ConfigMetaData>) => MutableModel<Config, ConfigMetaData> | void): Config;
}

export declare class Level {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly parentLevelID?: string | null;
  readonly interventionsAreAllowed: boolean;
  readonly allowedInterventions?: LevelInterventionRelation[] | null;
  readonly customData: CustomData[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<Level, LevelMetaData>);
  static copyOf(source: Level, mutator: (draft: MutableModel<Level, LevelMetaData>) => MutableModel<Level, LevelMetaData> | void): Level;
}

export declare class Intervention {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly interventionType: InterventionType | keyof typeof InterventionType;
  readonly contents: InterventionContentRelation[];
  readonly surveys: Survey[];
  readonly tags: InterventionInterventionTagRelation[];
  readonly schemeVersion?: number | null;
  readonly levels: LevelInterventionRelation[];
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<Intervention, InterventionMetaData>);
  static copyOf(source: Intervention, mutator: (draft: MutableModel<Intervention, InterventionMetaData>) => MutableModel<Intervention, InterventionMetaData> | void): Intervention;
}

export declare class Content {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly interventions: InterventionContentRelation[];
  readonly tags: ContentContentTagRelation[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<Content, ContentMetaData>);
  static copyOf(source: Content, mutator: (draft: MutableModel<Content, ContentMetaData>) => MutableModel<Content, ContentMetaData> | void): Content;
}

export declare class ContentTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number | null;
  readonly contents: ContentContentTagRelation[];
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<ContentTag, ContentTagMetaData>);
  static copyOf(source: ContentTag, mutator: (draft: MutableModel<ContentTag, ContentTagMetaData>) => MutableModel<ContentTag, ContentTagMetaData> | void): ContentTag;
}

export declare class Survey {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly intervention?: Intervention | null;
  readonly questions: Question[];
  readonly tags: SurveySurveyTagRelation[];
  readonly surveyType: SurveyType | keyof typeof SurveyType;
  readonly schemeVersion?: number | null;
  readonly archived?: boolean | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<Survey, SurveyMetaData>);
  static copyOf(source: Survey, mutator: (draft: MutableModel<Survey, SurveyMetaData>) => MutableModel<Survey, SurveyMetaData> | void): Survey;
}

export declare class SurveyTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number | null;
  readonly surveys: SurveySurveyTagRelation[];
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<SurveyTag, SurveyTagMetaData>);
  static copyOf(source: SurveyTag, mutator: (draft: MutableModel<SurveyTag, SurveyTagMetaData>) => MutableModel<SurveyTag, SurveyTagMetaData> | void): SurveyTag;
}

export declare class InterventionTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number | null;
  readonly interventions: InterventionInterventionTagRelation[];
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<InterventionTag, InterventionTagMetaData>);
  static copyOf(source: InterventionTag, mutator: (draft: MutableModel<InterventionTag, InterventionTagMetaData>) => MutableModel<InterventionTag, InterventionTagMetaData> | void): InterventionTag;
}

export declare class Entity {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly parentEntityID?: string | null;
  readonly level: Level;
  readonly location?: Location | null;
  readonly customData: (AppliedCustomData | null)[];
  readonly appliedInterventions: AppliedIntervention[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  readonly entityLevelId: string;
  constructor(init: ModelInit<Entity, EntityMetaData>);
  static copyOf(source: Entity, mutator: (draft: MutableModel<Entity, EntityMetaData>) => MutableModel<Entity, EntityMetaData> | void): Entity;
}

export declare class AppliedIntervention {
  readonly id: string;
  readonly whoDidIt: User;
  readonly intervention: Intervention;
  readonly location?: Location | null;
  readonly isOkay: boolean;
  readonly executedSurveys: ExecutedSurvey[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  readonly entityAppliedInterventionsId?: string | null;
  readonly appliedInterventionWhoDidItId: string;
  readonly appliedInterventionInterventionId: string;
  constructor(init: ModelInit<AppliedIntervention, AppliedInterventionMetaData>);
  static copyOf(source: AppliedIntervention, mutator: (draft: MutableModel<AppliedIntervention, AppliedInterventionMetaData>) => MutableModel<AppliedIntervention, AppliedInterventionMetaData> | void): AppliedIntervention;
}

export declare class ExecutedSurvey {
  readonly id: string;
  readonly appliedIntervention: AppliedIntervention;
  readonly survey: Survey;
  readonly whoExecutedIt: User;
  readonly date: string;
  readonly location?: Location | null;
  readonly answers: QuestionAnswer[];
  readonly schemeVersion?: number | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  readonly executedSurveySurveyId: string;
  readonly executedSurveyWhoExecutedItId: string;
  constructor(init: ModelInit<ExecutedSurvey, ExecutedSurveyMetaData>);
  static copyOf(source: ExecutedSurvey, mutator: (draft: MutableModel<ExecutedSurvey, ExecutedSurveyMetaData>) => MutableModel<ExecutedSurvey, ExecutedSurveyMetaData> | void): ExecutedSurvey;
}

export declare class Task {
  readonly id: string;
  readonly title: string;
  readonly text?: string | null;
  readonly dueDate?: string | null;
  readonly finishedDate?: string | null;
  readonly location?: Location | null;
  readonly user: User;
  readonly userID: string;
  readonly entity?: Entity | null;
  readonly appliedIntervention?: AppliedIntervention | null;
  readonly executedSurvey?: ExecutedSurvey | null;
  readonly schemeVersion?: number | null;
  readonly picIDs: number[];
  readonly audioIDs: number[];
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  readonly taskUserId: string;
  readonly taskEntityId?: string | null;
  readonly taskAppliedInterventionId?: string | null;
  readonly taskExecutedSurveyId?: string | null;
  constructor(init: ModelInit<Task, TaskMetaData>);
  static copyOf(source: Task, mutator: (draft: MutableModel<Task, TaskMetaData>) => MutableModel<Task, TaskMetaData> | void): Task;
}

export declare class SessionData {
  readonly id: string;
  readonly date: string;
  readonly userID?: string | null;
  readonly app?: string | null;
  readonly version?: string | null;
  readonly buildNumber?: string | null;
  readonly remoteConfig?: string | null;
  readonly platform?: string | null;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<SessionData, SessionDataMetaData>);
  static copyOf(source: SessionData, mutator: (draft: MutableModel<SessionData, SessionDataMetaData>) => MutableModel<SessionData, SessionDataMetaData> | void): SessionData;
}

export declare class LevelInterventionRelation {
  readonly id: string;
  readonly level: Level;
  readonly intervention: Intervention;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<LevelInterventionRelation, LevelInterventionRelationMetaData>);
  static copyOf(source: LevelInterventionRelation, mutator: (draft: MutableModel<LevelInterventionRelation, LevelInterventionRelationMetaData>) => MutableModel<LevelInterventionRelation, LevelInterventionRelationMetaData> | void): LevelInterventionRelation;
}

export declare class InterventionContentRelation {
  readonly id: string;
  readonly intervention: Intervention;
  readonly content: Content;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<InterventionContentRelation, InterventionContentRelationMetaData>);
  static copyOf(source: InterventionContentRelation, mutator: (draft: MutableModel<InterventionContentRelation, InterventionContentRelationMetaData>) => MutableModel<InterventionContentRelation, InterventionContentRelationMetaData> | void): InterventionContentRelation;
}

export declare class InterventionInterventionTagRelation {
  readonly id: string;
  readonly intervention: Intervention;
  readonly interventionTag: InterventionTag;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<InterventionInterventionTagRelation, InterventionInterventionTagRelationMetaData>);
  static copyOf(source: InterventionInterventionTagRelation, mutator: (draft: MutableModel<InterventionInterventionTagRelation, InterventionInterventionTagRelationMetaData>) => MutableModel<InterventionInterventionTagRelation, InterventionInterventionTagRelationMetaData> | void): InterventionInterventionTagRelation;
}

export declare class ContentContentTagRelation {
  readonly id: string;
  readonly content: Content;
  readonly contentTag: ContentTag;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<ContentContentTagRelation, ContentContentTagRelationMetaData>);
  static copyOf(source: ContentContentTagRelation, mutator: (draft: MutableModel<ContentContentTagRelation, ContentContentTagRelationMetaData>) => MutableModel<ContentContentTagRelation, ContentContentTagRelationMetaData> | void): ContentContentTagRelation;
}

export declare class SurveySurveyTagRelation {
  readonly id: string;
  readonly survey: Survey;
  readonly surveyTag: SurveyTag;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
  constructor(init: ModelInit<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData>);
  static copyOf(source: SurveySurveyTagRelation, mutator: (draft: MutableModel<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData>) => MutableModel<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData> | void): SurveySurveyTagRelation;
}