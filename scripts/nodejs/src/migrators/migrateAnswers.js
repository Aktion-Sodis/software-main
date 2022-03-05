import * as mutations from '../graphql/mutations.js';
import { InterventionType } from '../models/index.js';

const listSurveys = `
    SELECT
        survey_header.survey_name AS survey_name,
        survey_header.id AS survey_id,
        project.name AS intervention_name,
        project.id AS intervention_id
    FROM survey_header
    LEFT JOIN project
        ON project.id=survey_header.project_id;
    `;

    
async function getQuestionsBySurveyId(sqlPool, surveyId){
    var questions = [];
    const getQuestionsQuery = `
        SELECT 
            *
        FROM question
    `
    await sqlPool.query(getQuestionsQuery, function (err, result, fields) {
            if (err) throw err;
            Object.values(result).forEach(function(oldQuestion) {
                const newQuestion = {
                    id: oldQuestion.id,
                    text: oldQuestion.question_name,
                }
                questions.push(newQuestion);
            });
        }
    )
    return questions;
};
        
const migrateSurveys = async (sqlPool) => {
    await sqlPool.query(listSurveys, function (err, result, fields) {
        if (err) throw err;
        Object.values(result).forEach(function(oldSurvey) {
            const newSurvey = surveyTransformer(oldSurvey);
            try {
                const newSurveyEntry = await API.graphql({
                    query: mutations.createSurvey, // missing in graph-QL api?
                    variables: {input: newSurvey}
                })
                console.log("Created question option" + JSON.stringify(newSurveyEntry));
                
            } catch (error) {
                console.log("Error writing question option" + JSON.stringify(newSurvey) + error);
            }
        });
    });
    
}

const surveyTransformer = (oldSurvey) => {
    const newSurvey = {
        name: oldSurvey.survey_name,
        id: oldSurvey.survey_id,
        intervention: {
            name:oldSurvey.intervention_name,
            id: oldSurvey.intervention_id,
            interventionType: InterventionType.TECHNOLOGY,
        },
        questions: getQuestionsBySurveyId(oldSurvey.survey_id),
        // questionOptions: getQuestionOptionsBySurveyId(oldSurvey.survey_id),
    }
    return newSurvey;
}

export default migrateSurveys;