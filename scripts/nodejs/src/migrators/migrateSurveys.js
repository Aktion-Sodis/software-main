import * as mutations from "../graphql/mutations.js";
import { InterventionType, Question, QuestionType, SurveyType } from "../models/index.js";
import { getQuestionsBySurveyId } from "./getQuestionsBySurveyId.js";
import queryResult from "../utils/awaitableQuery.js";
import mlString from "../utils/stringFormatter.js";


import { API, graphqlOperation } from "aws-amplify";
import * as queries from "../graphql/queries.js";

const listSurveys = `
    SELECT
        survey_header.survey_name AS name,
        survey_header.id AS id,
        survey_header.project_id AS intervention_id
    FROM survey_header
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
  let surveys = await queryResult(sqlPool, listSurveys);
  var surveysToAdd = [];
  for(const rawSurvey of surveys) {
    
    const surveyToAdd = await surveyTransformer(sqlPool, rawSurvey);
    surveysToAdd.push(surveyToAdd);
  }
  //todo: save all surveys
  for(var uploadSurvey of surveysToAdd) {
      const onlineSurveyQuery = await API.graphql({
        query: queries.getSurvey,
        variables: {
          id: uploadSurvey.id,
        },
      });
      if(onlineSurveyQuery.data.getSurvey!==null) {
        uploadSurvey._version = onlineSurveyQuery.data.getSurvey._version;
        uploadSurvey = await API.graphql({
            query: mutations.updateSurvey,
            variables: {
                input: uploadSurvey
            }
        });
      }
      else {
        uploadSurvey = await API.graphql({
            query: mutations.createSurvey,
            variables: {
                input: uploadSurvey
            }
        });
      }
  }
  console.log("surveys successfully added/updated");
  return surveysToAdd;
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

const surveyTransformer = async (sqlPool, oldSurvey) => {
  //todo: hier einiges zu tun
  const questions = await getQuestions(sqlPool, oldSurvey);
  const newSurvey = {
    name: mlString(oldSurvey.name),
    description: mlString("Esta monitero fue transferida desde la antigua aplicación."),
    id: oldSurvey.id.toString(),
    interventionSurveysId: oldSurvey.intervention_id.toString(),
    archived: false,
    questions: questions,
    surveyType: SurveyType.DEFAULT,
  };
  return newSurvey;
};

const getQuestions = async(sqlPool, survey) => {
    const listQuestionsOfSurveyQuery = `
    SELECT 
        question.id AS id,
        question_name as name,
        dependent_question_id,
        dependent_question_option_id,
        question_images_id,
        input_type_name as input_type,
        url AS question_image_url
    FROM question
    LEFT JOIN survey_section
        ON survey_section.id=question.survey_section_id
    LEFT JOIN survey_header
        ON survey_header.id=survey_section.survey_header_id
    LEFT JOIN question_image
        ON question_image.id=question.question_images_id
    LEFT JOIN input_type
        ON input_type.id=question.input_type_id
    WHERE survey_header.id = ${survey.id};
    `;
    const listQuestionsOfSurvey = await queryResult(sqlPool, listQuestionsOfSurveyQuery);
    console.log("number of questions for survey:" + listQuestionsOfSurvey.length.toString());
    var allQuestions = [];
    for(const oldQuestion of listQuestionsOfSurvey) {
        const toAdd = await getQuestion(sqlPool, oldQuestion, listQuestionsOfSurvey, survey.id);
        allQuestions.push(toAdd);
    }
    return allQuestions;
}

const getQuestion = async (sqlPool, oldQuestion, allOldQuestions, surveyID) => {
    var newType;
    switch(oldQuestion.input_type) {
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
            const followUpQuestions = allOldQuestions.filter((element) => (element.dependent_question_id===oldQuestion.id)&&(element.dependent_question_option_id==questionOption.id));
            const followUpIDs = Array.from(followUpQuestions, e => e.id);
            const questionOptionToAdd = {
                id: questionOption.id.toString(),
                text: mlString(questionOption.text),
                followUpQuestionIDs: followUpIDs
            }
            questionOptionsToSet.push(questionOptionToAdd);
        }
        question = {
            id: oldQuestion.id.toString(),
            text: mlString(oldQuestion.name),
            type: newType,
            isFollowUpQuestion: isFollowUpQuestionBool,
            questionOptions: questionOptionsToSet
        };
    }
    else {
        question = {
            id: oldQuestion.id.toString(),
            text: mlString(oldQuestion.name),
            type: newType,
            isFollowUpQuestion: isFollowUpQuestionBool,
        }
    }
    //todo: copy pic from cloudstorage to s3
    return question;
}

export default migrateSurveys;
