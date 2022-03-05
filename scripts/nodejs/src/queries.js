export const listUsersQuery = "SELECT * from user;";

export const listIntervieweesQuery = `SELECT *, GROUP_CONCAT(interviewee.id) as allowedEntities
    FROM user
    JOIN interviewee ON interviewee.user_id=user.id
    GROUP BY user.id;
    `;

export const listInterventionsQuery = "SELECT * FROM project";

export const listSurveysQuery = "SELECT * FROM survey_header";