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
  AUDIO = "AUDIO"
}

export enum Type {
  INT = "INT",
  STRING = "STRING"
}

export enum SurveyType {
  INITIAL = "INITIAL",
  DEFAULT = "DEFAULT"
}

export declare class Permission {
  readonly permissionType: PermissionType | keyof typeof PermissionType;
  readonly allowedEntities: string[];
  constructor(init: ModelInit<Permission>);
}

export declare class ColorTheme {
  readonly highlight?: string;
  readonly secondaryHighlight?: string;
  readonly backgroundOneLight?: string;
  readonly backgroundTwoLight?: string;
  readonly backgroundOneDark?: string;
  readonly backgroundTwoDark?: string;
  constructor(init: ModelInit<ColorTheme>);
}

export declare class StoragePaths {
  readonly ownerPic?: string;
  readonly ownerIcon?: string;
  constructor(init: ModelInit<StoragePaths>);
}

export declare class Question {
  readonly id: string;
  readonly text: string;
  readonly type: QuestionType | keyof typeof QuestionType;
  readonly questionOptions?: QuestionOption[];
  constructor(init: ModelInit<Question>);
}

export declare class QuestionOption {
  readonly id: string;
  readonly text: string;
  readonly followUpQuestion?: Question;
  constructor(init: ModelInit<QuestionOption>);
}

export declare class CustomData {
  readonly id: string;
  readonly name: string;
  readonly type: Type | keyof typeof Type;
  constructor(init: ModelInit<CustomData>);
}

export declare class Location {
  readonly latitude?: number;
  readonly longitude?: number;
  constructor(init: ModelInit<Location>);
}

export declare class AppliedCustomData {
  readonly customDataID: string;
  readonly type: Type | keyof typeof Type;
  readonly name: string;
  readonly intValue?: number;
  readonly stringValue?: string;
  constructor(init: ModelInit<AppliedCustomData>);
}

export declare class QuestionAnswer {
  readonly id: string;
  readonly questionID: string;
  readonly date: string;
  readonly type: QuestionType | keyof typeof QuestionType;
  readonly text?: string;
  readonly questionOptions?: QuestionOption[];
  readonly markings?: Marking[];
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

type SurveyMetaData = {
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

type InterventionContentRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

export declare class User {
  readonly id: string;
  readonly firstName: string;
  readonly lastName: string;
  readonly bio?: string;
  readonly permissions: Permission[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<User, UserMetaData>);
  static copyOf(source: User, mutator: (draft: MutableModel<User, UserMetaData>) => MutableModel<User, UserMetaData> | void): User;
}

export declare class Config {
  readonly id: string;
  readonly name: string;
  readonly colorTheme?: ColorTheme;
  readonly storagePaths: StoragePaths;
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Config, ConfigMetaData>);
  static copyOf(source: Config, mutator: (draft: MutableModel<Config, ConfigMetaData>) => MutableModel<Config, ConfigMetaData> | void): Config;
}

export declare class Level {
  readonly id: string;
  readonly name: string;
  readonly description?: string;
  readonly parentLevelID?: string;
  readonly interventionsAreAllowed: boolean;
  readonly allowedInterventions?: Intervention[];
  readonly customData: CustomData[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Level, LevelMetaData>);
  static copyOf(source: Level, mutator: (draft: MutableModel<Level, LevelMetaData>) => MutableModel<Level, LevelMetaData> | void): Level;
}

export declare class Intervention {
  readonly id: string;
  readonly name: string;
  readonly description?: string;
  readonly interventionType: InterventionType | keyof typeof InterventionType;
  readonly contents: InterventionContentRelation[];
  readonly surveys: Survey[];
  readonly tags: string[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly levelAllowedInterventionsId?: string;
  constructor(init: ModelInit<Intervention, InterventionMetaData>);
  static copyOf(source: Intervention, mutator: (draft: MutableModel<Intervention, InterventionMetaData>) => MutableModel<Intervention, InterventionMetaData> | void): Intervention;
}

export declare class Content {
  readonly id: string;
  readonly name: string;
  readonly description?: string;
  readonly interventions: InterventionContentRelation[];
  readonly tags: string[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Content, ContentMetaData>);
  static copyOf(source: Content, mutator: (draft: MutableModel<Content, ContentMetaData>) => MutableModel<Content, ContentMetaData> | void): Content;
}

export declare class Survey {
  readonly id: string;
  readonly name: string;
  readonly description?: string;
  readonly intervention?: Intervention;
  readonly questions: Question[];
  readonly tags: string[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Survey, SurveyMetaData>);
  static copyOf(source: Survey, mutator: (draft: MutableModel<Survey, SurveyMetaData>) => MutableModel<Survey, SurveyMetaData> | void): Survey;
}

export declare class Entity {
  readonly id: string;
  readonly name: string;
  readonly description?: string;
  readonly parentEntityID?: string;
  readonly level: Level;
  readonly location?: Location;
  readonly customData: (AppliedCustomData | null)[];
  readonly appliedInterventions: AppliedIntervention[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly entityLevelId: string;
  constructor(init: ModelInit<Entity, EntityMetaData>);
  static copyOf(source: Entity, mutator: (draft: MutableModel<Entity, EntityMetaData>) => MutableModel<Entity, EntityMetaData> | void): Entity;
}

export declare class AppliedIntervention {
  readonly id: string;
  readonly whoDidIt: User;
  readonly intervention: Intervention;
  readonly location?: Location;
  readonly executedSurveys: ExecutedSurvey[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly entityAppliedInterventionsId?: string;
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
  readonly location?: Location;
  readonly answers: QuestionAnswer[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly executedSurveySurveyId: string;
  readonly executedSurveyWhoExecutedItId: string;
  constructor(init: ModelInit<ExecutedSurvey, ExecutedSurveyMetaData>);
  static copyOf(source: ExecutedSurvey, mutator: (draft: MutableModel<ExecutedSurvey, ExecutedSurveyMetaData>) => MutableModel<ExecutedSurvey, ExecutedSurveyMetaData> | void): ExecutedSurvey;
}

export declare class Task {
  readonly id: string;
  readonly title: string;
  readonly text?: string;
  readonly dueDate?: string;
  readonly finishedDate?: string;
  readonly location?: Location;
  readonly user: User;
  readonly entity?: Entity;
  readonly appliedIntervention?: AppliedIntervention;
  readonly executedSurvey?: ExecutedSurvey;
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly taskUserId: string;
  readonly taskEntityId?: string;
  readonly taskAppliedInterventionId?: string;
  readonly taskExecutedSurveyId?: string;
  constructor(init: ModelInit<Task, TaskMetaData>);
  static copyOf(source: Task, mutator: (draft: MutableModel<Task, TaskMetaData>) => MutableModel<Task, TaskMetaData> | void): Task;
}

export declare class InterventionContentRelation {
  readonly id: string;
  readonly intervention: Intervention;
  readonly content: Content;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<InterventionContentRelation, InterventionContentRelationMetaData>);
  static copyOf(source: InterventionContentRelation, mutator: (draft: MutableModel<InterventionContentRelation, InterventionContentRelationMetaData>) => MutableModel<InterventionContentRelation, InterventionContentRelationMetaData> | void): InterventionContentRelation;
}