import { inferQuestionType } from "./inferQuestionType.js";

export async function getQuestionsBySurveyId(sqlPool, surveyId) {
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
    WHERE survey_header.id = ${surveyId}
    `;
  await sqlPool.query(getQuestionsQuery, function (err, result, fields) {
    if (err) throw err;
    Object.values(result).forEach(function (oldQuestion) {
      const newQuestion = {
        id: oldQuestion.id,
        text: oldQuestion.question_name,
        type: inferQuestionType(oldQuestion),
      };
      questions.push(newQuestion);
    });
  });
  return questions;
}
