import { ModelInit, MutableModel, PersistentModelConstructor } from '@aws-amplify/datastore';

export enum PermissionType {
  READ = 'READ',
  CHANGEMASTERDATA = 'CHANGEMASTERDATA',
  CREATEINTERVENTIONS = 'CREATEINTERVENTIONS',
  EXECUTESURVEYS = 'EXECUTESURVEYS',
  CREATESUBENTITIES = 'CREATESUBENTITIES',
  ADMIN = 'ADMIN',
}

export enum InterventionType {
  TECHNOLOGY = 'TECHNOLOGY',
  EDUCATION = 'EDUCATION',
}

export enum QuestionType {
  TEXT = 'TEXT',
  SINGLECHOICE = 'SINGLECHOICE',
  MULTIPLECHOICE = 'MULTIPLECHOICE',
  PICTURE = 'PICTURE',
  PICTUREWITHTAGS = 'PICTUREWITHTAGS',
  AUDIO = 'AUDIO',
  INT = 'INT',
  DOUBLE = 'DOUBLE',
  RATING = 'RATING',
}

export enum SurveyType {
  INITIAL = 'INITIAL',
  DEFAULT = 'DEFAULT',
}

export enum Type {
  INT = 'INT',
  STRING = 'STRING',
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
  readonly highlight?: string;
  readonly secondaryHighlight?: string;
  readonly backgroundOneLight?: string;
  readonly backgroundTwoLight?: string;
  readonly backgroundOneDark?: string;
  readonly backgroundTwoDark?: string;
  constructor(init: ModelInit<ColorTheme>);
}

export declare class Question {
  readonly id: string;
  readonly text: I18nString;
  readonly type: QuestionType | keyof typeof QuestionType;
  readonly questionOptions?: QuestionOption[];
  readonly isFollowUpQuestion: boolean;
  constructor(init: ModelInit<Question>);
}

export declare class QuestionOption {
  readonly id: string;
  readonly text: I18nString;
  readonly followUpQuestionIDs?: string[] | null;
  constructor(init: ModelInit<QuestionOption>);
}

export declare class CustomData {
  readonly id: string;
  readonly name: I18nString;
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
  readonly name: I18nString;
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
  readonly intValue?: number;
  readonly doubleValue?: number;
  readonly rating?: number;
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
};

type ConfigMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type LevelMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type InterventionMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type ContentMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type ContentTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type SurveyMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type SurveyTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type InterventionTagMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type EntityMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type AppliedInterventionMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type ExecutedSurveyMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type TaskMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type SessionDataMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type LevelInterventionRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type InterventionContentRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type InterventionInterventionTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type ContentContentTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

type SurveySurveyTagRelationMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
};

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
  static copyOf(
    source: User,
    mutator: (draft: MutableModel<User, UserMetaData>) => MutableModel<User, UserMetaData> | void
  ): User;
}

export declare class Config {
  readonly id: string;
  readonly name: string;
  readonly colorTheme?: ColorTheme;
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Config, ConfigMetaData>);
  static copyOf(
    source: Config,
    mutator: (
      draft: MutableModel<Config, ConfigMetaData>
    ) => MutableModel<Config, ConfigMetaData> | void
  ): Config;
}

export declare class Level {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly parentLevelID?: string;
  readonly interventionsAreAllowed: boolean;
  readonly allowedInterventions?: LevelInterventionRelation[];
  readonly customData: CustomData[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Level, LevelMetaData>);
  static copyOf(
    source: Level,
    mutator: (
      draft: MutableModel<Level, LevelMetaData>
    ) => MutableModel<Level, LevelMetaData> | void
  ): Level;
}

export declare class Intervention {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly interventionType: InterventionType | keyof typeof InterventionType;
  readonly contents: InterventionContentRelation[];
  readonly surveys: Survey[];
  readonly tags: InterventionInterventionTagRelation[];
  readonly schemeVersion?: number;
  readonly levels: LevelInterventionRelation[];
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Intervention, InterventionMetaData>);
  static copyOf(
    source: Intervention,
    mutator: (
      draft: MutableModel<Intervention, InterventionMetaData>
    ) => MutableModel<Intervention, InterventionMetaData> | void
  ): Intervention;
}

export declare class Content {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly interventions: InterventionContentRelation[];
  readonly tags: ContentContentTagRelation[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Content, ContentMetaData>);
  static copyOf(
    source: Content,
    mutator: (
      draft: MutableModel<Content, ContentMetaData>
    ) => MutableModel<Content, ContentMetaData> | void
  ): Content;
}

export declare class ContentTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number;
  readonly contents: ContentContentTagRelation[];
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<ContentTag, ContentTagMetaData>);
  static copyOf(
    source: ContentTag,
    mutator: (
      draft: MutableModel<ContentTag, ContentTagMetaData>
    ) => MutableModel<ContentTag, ContentTagMetaData> | void
  ): ContentTag;
}

export declare class Survey {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
  readonly intervention?: Intervention;
  readonly questions: Question[];
  readonly tags: SurveySurveyTagRelation[];
  readonly surveyType: SurveyType | keyof typeof SurveyType;
  readonly schemeVersion?: number;
  readonly archived?: boolean;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Survey, SurveyMetaData>);
  static copyOf(
    source: Survey,
    mutator: (
      draft: MutableModel<Survey, SurveyMetaData>
    ) => MutableModel<Survey, SurveyMetaData> | void
  ): Survey;
}

export declare class SurveyTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number;
  readonly surveys: SurveySurveyTagRelation[];
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<SurveyTag, SurveyTagMetaData>);
  static copyOf(
    source: SurveyTag,
    mutator: (
      draft: MutableModel<SurveyTag, SurveyTagMetaData>
    ) => MutableModel<SurveyTag, SurveyTagMetaData> | void
  ): SurveyTag;
}

export declare class InterventionTag {
  readonly id: string;
  readonly text: I18nString;
  readonly schemeVersion?: number;
  readonly interventions: InterventionInterventionTagRelation[];
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<InterventionTag, InterventionTagMetaData>);
  static copyOf(
    source: InterventionTag,
    mutator: (
      draft: MutableModel<InterventionTag, InterventionTagMetaData>
    ) => MutableModel<InterventionTag, InterventionTagMetaData> | void
  ): InterventionTag;
}

export declare class Entity {
  readonly id: string;
  readonly name: I18nString;
  readonly description: I18nString;
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
  static copyOf(
    source: Entity,
    mutator: (
      draft: MutableModel<Entity, EntityMetaData>
    ) => MutableModel<Entity, EntityMetaData> | void
  ): Entity;
}

export declare class AppliedIntervention {
  readonly id: string;
  readonly whoDidIt: User;
  readonly intervention: Intervention;
  readonly location?: Location;
  readonly isOkay: boolean;
  readonly executedSurveys: ExecutedSurvey[];
  readonly schemeVersion?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly entityAppliedInterventionsId?: string;
  readonly appliedInterventionWhoDidItId: string;
  readonly appliedInterventionInterventionId: string;
  constructor(init: ModelInit<AppliedIntervention, AppliedInterventionMetaData>);
  static copyOf(
    source: AppliedIntervention,
    mutator: (
      draft: MutableModel<AppliedIntervention, AppliedInterventionMetaData>
    ) => MutableModel<AppliedIntervention, AppliedInterventionMetaData> | void
  ): AppliedIntervention;
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
  static copyOf(
    source: ExecutedSurvey,
    mutator: (
      draft: MutableModel<ExecutedSurvey, ExecutedSurveyMetaData>
    ) => MutableModel<ExecutedSurvey, ExecutedSurveyMetaData> | void
  ): ExecutedSurvey;
}

export declare class Task {
  readonly id: string;
  readonly title: string;
  readonly text?: string;
  readonly dueDate?: string;
  readonly finishedDate?: string;
  readonly location?: Location;
  readonly user: User;
  readonly userID: string;
  readonly entity?: Entity;
  readonly appliedIntervention?: AppliedIntervention;
  readonly executedSurvey?: ExecutedSurvey;
  readonly schemeVersion?: number;
  readonly picIDs: number[];
  readonly audioIDs: number[];
  readonly createdAt?: string;
  readonly updatedAt?: string;
  readonly taskUserId: string;
  readonly taskEntityId?: string;
  readonly taskAppliedInterventionId?: string;
  readonly taskExecutedSurveyId?: string;
  constructor(init: ModelInit<Task, TaskMetaData>);
  static copyOf(
    source: Task,
    mutator: (draft: MutableModel<Task, TaskMetaData>) => MutableModel<Task, TaskMetaData> | void
  ): Task;
}

export declare class SessionData {
  readonly id: string;
  readonly date: string;
  readonly userID?: string;
  readonly app?: string;
  readonly version?: string;
  readonly buildNumber?: string;
  readonly remoteConfig?: string;
  readonly platform?: string;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<SessionData, SessionDataMetaData>);
  static copyOf(
    source: SessionData,
    mutator: (
      draft: MutableModel<SessionData, SessionDataMetaData>
    ) => MutableModel<SessionData, SessionDataMetaData> | void
  ): SessionData;
}

export declare class LevelInterventionRelation {
  readonly id: string;
  readonly level: Level;
  readonly intervention: Intervention;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<LevelInterventionRelation, LevelInterventionRelationMetaData>);
  static copyOf(
    source: LevelInterventionRelation,
    mutator: (
      draft: MutableModel<LevelInterventionRelation, LevelInterventionRelationMetaData>
    ) => MutableModel<LevelInterventionRelation, LevelInterventionRelationMetaData> | void
  ): LevelInterventionRelation;
}

export declare class InterventionContentRelation {
  readonly id: string;
  readonly intervention: Intervention;
  readonly content: Content;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<InterventionContentRelation, InterventionContentRelationMetaData>);
  static copyOf(
    source: InterventionContentRelation,
    mutator: (
      draft: MutableModel<InterventionContentRelation, InterventionContentRelationMetaData>
    ) => MutableModel<InterventionContentRelation, InterventionContentRelationMetaData> | void
  ): InterventionContentRelation;
}

export declare class InterventionInterventionTagRelation {
  readonly id: string;
  readonly intervention: Intervention;
  readonly interventionTag: InterventionTag;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(
    init: ModelInit<
      InterventionInterventionTagRelation,
      InterventionInterventionTagRelationMetaData
    >
  );
  static copyOf(
    source: InterventionInterventionTagRelation,
    mutator: (
      draft: MutableModel<
        InterventionInterventionTagRelation,
        InterventionInterventionTagRelationMetaData
      >
    ) => MutableModel<
      InterventionInterventionTagRelation,
      InterventionInterventionTagRelationMetaData
    > | void
  ): InterventionInterventionTagRelation;
}

export declare class ContentContentTagRelation {
  readonly id: string;
  readonly content: Content;
  readonly contentTag: ContentTag;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<ContentContentTagRelation, ContentContentTagRelationMetaData>);
  static copyOf(
    source: ContentContentTagRelation,
    mutator: (
      draft: MutableModel<ContentContentTagRelation, ContentContentTagRelationMetaData>
    ) => MutableModel<ContentContentTagRelation, ContentContentTagRelationMetaData> | void
  ): ContentContentTagRelation;
}

export declare class SurveySurveyTagRelation {
  readonly id: string;
  readonly survey: Survey;
  readonly surveyTag: SurveyTag;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData>);
  static copyOf(
    source: SurveySurveyTagRelation,
    mutator: (
      draft: MutableModel<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData>
    ) => MutableModel<SurveySurveyTagRelation, SurveySurveyTagRelationMetaData> | void
  ): SurveySurveyTagRelation;
}
