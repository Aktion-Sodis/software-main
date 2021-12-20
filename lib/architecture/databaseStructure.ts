import {
  DocTagsEnum,
  Geoloc,
  SurveyTypesEnum,
  QuestionTypesEnum,
  Marking,
  UUID,
  shortText,
  longText,
} from "./utils";

interface Config {
  ID: UUID /* primary key */;
  name: shortText;
  verboseName: shortText;
  bannerPath: shortText;
  iconPath: shortText;
  locales: shortText[];
  colors: {
    primary: shortText;
    secondary: number;
    white: number;
    black: number;
    gray: number;
    lightGray: number;
  };
  databaseDerivableTemplates: {
    userImgPath: shortText;
    levelImgPath: shortText;
    levelMasterDataImgPath: shortText;
    entityAppliedMasterDataImgPath: shortText;
    technologyImgPath: shortText;
    technologyDocMdPath: shortText;
    appliedTechnologyImgPath: shortText;
    surveyImgPath: shortText;
    questionImgPath: shortText;
    questionOptionImgPath: shortText;
    entityImgPath: shortText;
    executedSurveyAnswerAudioPath: shortText;
    executedSurveyAnswerImgPath: shortText;
    taskImgPath: shortText;
    taskAudioPath: shortText;
  };
  creationDate: number;
  lastEditDate: number;
}

interface User {
  ID: UUID /* primary key */;
  firstName: shortText;
  lastName: shortText;
  bio: longText;
  permissions: {
    read: UUID[] /* foreign key */;
    createSubentities: UUID[] /* foreign key */;
  };
  creationDate: number;
  lastEditDate: number;
}

interface Level {
  ID: UUID /* primary key */;
  name: shortText;
  description: longText;
  upperLevelID: UUID /* foreign key */;
  customData: [{ ID: UUID /* primary key */; name: shortText }];
  creationDate: number;
  lastEditDate: number;
}

interface Technology {
  ID: UUID /* primary key */;
  description: longText;
  docs: [
    {
      ID: UUID /* primary key */;
      name: shortText;
      description: longText;
      tags: DocTagsEnum;
    }
  ];
  surveys: [{ surveyID: UUID /* foreign key */ }];
  creationDate: number;
  lastEditDate: number;
}

interface Entity {
  ID: UUID /* primary key */;
  parentEntityID: UUID /* foreign key */;
  name: shortText;
  geolocation: Geoloc;
  levelID: UUID /* foreign key */;
  appliedCustomData: [
    {
      ID: UUID /* foreign key */;
      customDataID: UUID /* foreign key */;
      name: shortText;
      value: number;
    }
  ];
  appliedTecnologies: [
    {
      ID: UUID /* primary key */;
      applierUserID: UUID /* foreign key */;
      technologyID: UUID /* foreign key */;
      geolocation: Geoloc;
      executedSurveys: UUID[];
    }
  ];
  creationDate: number;
  lastEditDate: number;
}

interface Question {
  ID: UUID /* primary key */;
  text: longText;
  type: QuestionTypesEnum;
  questionOptions: [{ ID: UUID; /* primary key */ text: longText }];
  followingQuestion: UUID /* foreign key */;
}

interface Survey {
  ID: UUID /* primary key */;
  description: longText;
  type: SurveyTypesEnum;
  questionIDs: UUID[];
  creationDate: number;
  lastEditDate: number;
}

interface executedSurvey {
  ID: UUID /* primary key */;
  surveyID: UUID /* foreign key */;
  executorUserID: UUID /* foreign key */;
  executionDate: number;
  geolocation: Geoloc;
  answers: [
    {
      ID: UUID /* primary key */;
      questionID: UUID /* foreign key */;
      answerTime: number;
      text: longText;
      markings: Marking[];
    }
  ];
  creationDate: number;
  lastEditDate: number;
}

interface Task {
  ID: UUID /* primary key */;
  title: shortText;
  text: longText;
  dueDate: number;
  finishedDate: number | null /* if null, not finished */;
  geolocation: Geoloc;
  executorUserID: UUID /* foreign key */;
  entityID: UUID /* foreign key */;
  appliedTechnologyID: UUID /* foreign key */;
  executedSurveyID: UUID /* foreign key */;
  creationDate: number;
  lastEditDate: number;
}
