export const listUsersQuery = "SELECT * from user;";

export const listIntervieweesQuery = `
    SELECT *, GROUP_CONCAT(interviewee.id) as allowedEntities
    FROM user
    JOIN interviewee 
        ON interviewee.user_id=user.id
    GROUP BY user.id;
    `;

export const listInterventionsQuery = "SELECT * FROM project";

export const listSurveysQuery = "SELECT * FROM survey_header";

export const listAppliedInterventionsQuery = `
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
    GROUP BY 
        interviewee_id, 
        intervention_name;
    `;

export const listExecutedSurveys = `
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