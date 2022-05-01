import * as mutations from "../graphql/mutations.js";
import { InterventionType, Question, QuestionType, SurveyType } from "../models/index.js";
import { getQuestionsBySurveyId } from "./getQuestionsBySurveyId.js";
import queryResult from "../utils/awaitableQuery.js";
import mlString from "../utils/stringFormatter.js";

const listSurveys = `
    SELECT
        survey_header.survey_name AS survey_name,
        survey_header.id AS survey_id,
        project.name AS intervention_name,
        project.id AS intervention_id,
        project.sectionid
    FROM survey_header
    LEFT JOIN project
        ON project.id=survey_header.project_id;
    `;

const listQuestionOptions = `
    SELECT
        question_option.id AS id,
        option_choice_name AS text,
        dependent_question_id,
    FROM question_option
    JOIN option_choice
        ON option_choice.id=question_option.option_choice_id;
    `;

const listQuestionTypes = `
        SELECT 
            input_type.id as id,
            input_type.input_type_name,
        FROM input_type
    `;

const migrateSurveys = async (sqlPool) => {
  //const oldSurveys = await queryResult(sqlPool, listSurveys);
  //const oldQuestionOptions = await queryResult(sqlPool, listQuestionOptions);
  let listQuestionTypeQuery = await queryResult(sqlPool, listQuestionTypes);
  console.log(listQuestionTypeQuery);
  return "";
  /*
    for (let oldSurvey of oldSurvies){
        const newSurvey = surveyTransformer(oldSurvey, oldQuestionOptions);
        try {
            const newSurveyEntry = await API.graphql({
                query: mutations.createSurvey,
                variables: {input: newSurvey}
            })
            console.log("Created question option" + JSON.stringify(newSurveyEntry));
            
        } catch (error) {
            console.log("Error writing question option" + JSON.stringify(newSurvey) + error);
        }
    }*/
};

const surveyTransformer = (oldSurvey, oldQuestionOptions) => {
  //todo: hier einiges zu tun
  const newSurvey = {
    name: oldSurvey.survey_name,
    id: oldSurvey.survey_id,
    intervention: {
      name: oldSurvey.intervention_name,
      description: "",
      id: oldSurvey.intervention_id,
      interventionType: InterventionType.TECHNOLOGY,
    },
    questions: getQuestionsBySurveyId(oldSurvey.survey_id),
    surveyType: SurveyType.DEFAULT,
  };
  return newSurvey;
};

const getQuestions = async(sqlPool, survey) => {
    //todo: implement
    var questions = [];
  const getQuestionsQuery = `
    SELECT 
        question.id as id,
        question.question_name as question_name,
    FROM question
    LEFT JOIN survey_section
        ON survey_section.id=question.survey_section_id
    LEFT JOIN survey_header
        ON survey_header.id=survey_section.survey_header_id
    WHERE survey_header.id = ${survey.id}
    `;
}

const getQuestion = async (sqlPool, oldQuestion, allOldQuestions, surveyID) => {
    var newType;
    switch(oldQuestion.input_type.input_type_name) {
        case "image":
            newType = QuestionType.PICTURE;
            break;
        case "numeric":
            newType = QuestionType.DOUBLE;
            break;
        case "single choice":
            newType = QuestionType.SINGLECHOICE;
            break;
        case "text":
            newType = QuestionType.TEXT;
            break;
    }
    //new type setted
    const isFollowUpQuestionBool = oldQuestion.dependent_question_id !== null;
    var question;
    const questionImageID = oldQuestion.question_images_id;
    if(newType === QuestionType.SINGLECHOICE) {
        const questionOptionQuery = `
        SELECT 
            question_option.id as id,
            option_choice.option_choice_name as text
        FROM question_option
        LEFT JOIN option_choice
            ON question_option.option_choice_id=option_choice.id
        WHERE question_id=${oldQuestion.id}
        ;
        `;
        var questionOptions = await queryResult(sqlPool, questionOptionQuery);
        var questionOptionsToSet = [];
        //question options prinzipiell da -> jetzt noch folgefragen zuordnen
        for(var questionOption of questionOptions) {
            //potenzielle folgefragen suchen
            const followUpQuestions = allOldQuestions.where((element) => (element.dependent_question_id===oldQuestion.id)&&(element.dependent_question_option_id==questionOption.id));
            const followUpIDs = Array.from(followUpQuestions, e => element.id);
            const questionOptionToAdd = {
                id: questionOption.id,
                text: mlString(questionOption.text),
                followUpQuestionIDs: followUpIDs
            }
            questionOptionsToSet.push(questionOptionToAdd);
        }
        question = {
            id: oldQuestion.id,
            text: mlString(oldQuestion.question_name),
            type: newType,
            isFollowUpQuestion: isFollowUpQuestionBool,
            questionOptions: questionOptionsToSet
        };
    }
    else {
        question = {
            id: oldQuestion.id,
            text: mlString(oldQuestion.question_name),
            type: newType,
            isFollowUpQuestion: isFollowUpQuestionBool,
        }
    }
    //todo: copy pic from cloudstorage to s3
    return question;
}

export default migrateSurveys;
