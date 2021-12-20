import {
  DocTagsEnum,
  Geoloc,
  SurveyTypesEnum,
  QuestionTypesEnum,
  Marking,
  UUID,
} from "./utils";

interface Config {
  ID: UUID /* primary key */;
  name: string;
  verboseName: string;
  bannerPath: string;
  iconPath: string;
  locales: string[];
  colors: {
    primary: string;
    secondary: number;
    white: number;
    black: number;
    gray: number;
    lightGray: number;
  };
  databaseDerivableTemplates: {
    userImgPath: string;
    levelImgPath: string;
    levelMasterDataImgPath: string;
    entityAppliedMasterDataImgPath: string;
    technologyImgPath: string;
    technologyDocMdPath: string;
    appliedTechnologyImgPath: string;
    surveyImgPath: string;
    questionImgPath: string;
    questionOptionImgPath: string;
    entityImgPath: string;
    executedSurveyAnswerAudioPath: string;
    executedSurveyAnswerImgPath: string;
    taskImgPath: string;
    taskAudioPath: string;
  };
  creationDate: number;
  lastEditDate: number;
}

interface User {
  ID: UUID /* primary key */;
  firstName: string;
  lastName: string;
  permissions: {
    read: UUID[];
    createSubentities: UUID[];
  };
  creationDate: number;
  lastEditDate: number;
}

interface Level {
  ID: UUID /* primary key */;
  name: string;
  upperLevelID: UUID /* foreign key */;
  customData: [{ ID: UUID /* primary key */; name: string }];
  creationDate: number;
  lastEditDate: number;
}

interface Technology {
  ID: UUID /* primary key */;
  description: string;
  docs: [
    {
      ID: UUID /* primary key */;
      name: string;
      description: string;
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
  name: string;
  geolocation: Geoloc;
  levelID: UUID /* foreign key */;
  appliedCustomData: [
    {
      ID: UUID /* foreign key */;
      customDataID: UUID /* foreign key */;
      name: string;
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
  text: string;
  type: QuestionTypesEnum;
  questionOptions: [{ ID: UUID; /* primary key */ text: string }];
  followingQuestion: string;
}

interface Survey {
  ID: UUID /* primary key */;
  description: string;
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
      text: string;
      markings: Marking[];
    }
  ];
  creationDate: number;
  lastEditDate: number;
}

interface Task {
  ID: UUID /* primary key */;
  title: string;
  text: string;
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
