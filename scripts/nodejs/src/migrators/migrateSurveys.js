import * as mutations from '../graphql/mutations.js';
import { InterventionType, SurveyType } from '../models/index.js';
import { getQuestionsBySurveyId } from './getQuestionsBySurveyId.js';

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
  
    
const migrateSurveys = async (sqlPool) => {
    const oldSurvies = await sqlPool.query(listSurveys, function (err, result, fields) {
        if (err) throw err;
        return Object.values(result);
    });
    for (let oldSurvey of oldSurvies){
        const newSurvey = surveyTransformer(oldSurvey);
        try {
            const newSurveyEntry = await API.graphql({
                query: mutations.createSurvey,
                variables: {input: newSurvey}
            })
            console.log("Created question option" + JSON.stringify(newSurveyEntry));
            
        } catch (error) {
            console.log("Error writing question option" + JSON.stringify(newSurvey) + error);
        }
    }
}

const surveyTransformer = (oldSurvey) => {
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
    }
    return newSurvey;
}

export default migrateSurveys;