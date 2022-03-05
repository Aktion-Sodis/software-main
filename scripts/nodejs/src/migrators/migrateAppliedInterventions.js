import * as mutations from '../graphql/mutations.js';

const listAppliedInterventionsQuery = `
    SELECT 
        completed_survey.id AS executed_survey_id,
        project.name as intervention_name, 
        project.id as intervention_id,
        interviewee.id AS interviewee_id, 
        interviewee.name AS interviewee_name,
        latitude,
        longitude    
    FROM completed_survey
    LEFT JOIN interviewee 
    ON interviewee.id=completed_survey.interviewee_id
    LEFT JOIN survey_header
    ON survey_header.id=completed_survey.survey_header_id
    LEFT JOIN project
    ON project.id=survey_header.project_id
    GROUP BY interviewee_id, intervention_name;
    `;
        
const migrateAppliedInterventions = async (sqlPool, defaultUser) => {
    await sqlPool.query(listAppliedInterventionsQuery, function (err, result, fields) {
        if (err) throw err;
        Object.values(result).forEach(function(executedSurveyData) {
            const newAppliedIntervention = appliedInterventionTransformer(executedSurveyData, defaultUser)    
            try {
                const newAppliedInterventionEntry = await API.graphql({
                    query: mutations.createAppliedIntervention,
                    variables: {input: newAppliedIntervention}
                })
                console.log("Created family entity" + JSON.stringify(newAppliedInterventionEntry));
                
            } catch (error) {
                console.log("Error writing family" + JSON.stringify(newAppliedIntervention) + error);
            }
        });
    });
    
}

const appliedInterventionTransformer = (executedSurveyData, defaultUser) => {
    const newAppliedIntervention = {
        whoDidIt: defaultUser,
        intervention: {
            name: executedSurveyData.intervention_name,
            id: executedSurveyData.intervention_id,
            interventionType: InterventionType.TECHNOLOGY,
        },
        location: {
            latitude: executedSurveyData.latitude,
            longitude: executedSurveyData.longitude,
        }
        // excecutedSurvey: {
        // ... : executedSurveyData.executed_survey_id
        // }
    }
    return newAppliedIntervention;
}

export default migrateAppliedInterventions;