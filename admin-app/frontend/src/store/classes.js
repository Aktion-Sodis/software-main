import { v4 as uuidv4 } from 'uuid';
import {
  I18nString,
  Intervention,
  InterventionType,
  Level,
  Question,
  QuestionOption,
  QuestionType,
  Survey,
  SurveyType,
} from '../models';
import i18n from '../i18n';

const emptyIntervention = () => new Intervention({
  name: '',
  description: '',
  tags: [],
  type: InterventionType.TECHNOLOGY,
  questionIds: [],
  contents: [],
});

const emptyI18nString = () => new I18nString({
  languageKeys: i18n.availableLocales,
  languageTexts: Array(i18n.availableLocales.length).fill(''),
});

const emptySurvey = () => new Survey({
  name: '',
  description: '',
  questions: [],
  surveyType: SurveyType.DEFAULT,
});

const emptyQuestion = () => new Question({
  id: uuidv4(),
  text: emptyI18nString(),
  type: QuestionType.TEXT,
  questionOptions: [],
  isFollowUpQuestion: false,
});

const emptyQuestionOption = () => new QuestionOption({
  id: uuidv4(),
  text: emptyI18nString(),
  followUpQuestionID: null,
});

export const emptyLevel = () => {
  const level = new Level({
    name: emptyI18nString(),
    description: emptyI18nString(),
    parentLevelID: null,
    allowedInterventions: [],
  });
  return level;
};

export {
  emptyIntervention, emptyI18nString, emptySurvey, emptyQuestion, emptyQuestionOption,
};
