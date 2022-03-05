import * as mutations from '../graphql/mutations.js';
import { QuestionType } from '../models/index.js';

const listExecutedSurveys = `
    SELECT
        completed_survey.id AS executed_survey_id,
        project.name as intervention_name, 
        project.id as intervention_id,
        interviewee.id AS interviewee_id, 
        interviewee.name AS interviewee_name,
        latitude,
        longitude,
        creation_date,
        survey_name,
        survey_header.id as survey_id
    FROM completed_survey
    LEFT JOIN interviewee 
        ON interviewee.id=completed_survey.interviewee_id
    LEFT JOIN survey_header
        ON survey_header.id=completed_survey.survey_header_id
    LEFT JOIN project
        ON project.id=survey_header.project_id
    GROUP BY 
        interviewee_id, 
        intervention_name;
    `;

async function getAnswersForSurveyId(sqlPool, surveyId){
    var answers = [];
    const getAnswerQuery = `
        SELECT 
            answer_text,
            question_id,
            question_option_id,
            answers.id AS answer_id
        FROM answers
        WHERE completed_survey_id = ${surveyId}
    `
    await sqlPool.query(getAnswerQuery, function (err, result, fields) {
            if (err) throw err;
            Object.values(result).forEach(function(oldAnswer) {
                const newAnswer = {
                    id: oldAnswer.answer_id,
                    questionID: oldAnswer.question_id,
                    type: oldAnswer.answer_text != null ? QuestionType.TEXT : QuestionType.MULTIPLECHOICE,
                    text: oldAnswer.answer_text
                }
                answers.push(newAnswer);
            });
        }
    )
    return answers;
};

        
const migrateExecutedSurveys = async (sqlPool, defaultUser) => {
    await sqlPool.query(listExecutedSurveys, function (err, result, fields) {
        if (err) throw err;
        Object.values(result).forEach(function(executedSurveyData) {
            const answers = getAnswersForSurveyId(sqlPool, executedSurveyData.executed_survey_id)
            const newExecutedSurvey = executedSurveysTransformer(executedSurveyData, defaultUser, answers)    
            try {
                const newExecutedSurveyEntry = await API.graphql({
                    query: mutations.createExecutedSurvey,
                    variables: {input: newExecutedSurvey}
                })
                console.log("Created executed survey" + JSON.stringify(newExecutedSurveyEntry));
                
            } catch (error) {
                console.log("Error writing survey" + JSON.stringify(newExecutedSurvey) + error);
            }
        });
    });
    
}

const executedSurveysTransformer = (executedSurveyData, defaultUser, answers) => {
    const newExecutedSurvey = {
        whoDidIt: defaultUser,
        appliedIntervention: {
            name: executedSurveyData.intervention_name,
            id: executedSurveyData.intervention_id,
            interventionType: InterventionType.TECHNOLOGY,
            appliedInterventionWhoDidItId: defaultUser.id,
        },
        whoExecutedIt: defaultUser,
        survey: {
            name: executedSurveyData.survey_name,
            id: executedSurveyData.survey_id,
            tags: ["migrated"],
            createdAt: executedSurveyData.creation_date,
        },
        date: executedSurveyData.creation_date,
        location: {
            latitude: executedSurveyData.latitude,
            longitude: executedSurveyData.longitude,
        },
        answers : answers,
        id: executedSurveyData.executed_survey_id,
    }
    return newExecutedSurvey;
}

export default migrateExecutedSurveys;