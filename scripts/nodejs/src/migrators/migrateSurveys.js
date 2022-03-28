import * as mutations from "../graphql/mutations.js";
import { InterventionType, SurveyType } from "../models/index.js";
import { getQuestionsBySurveyId } from "./getQuestionsBySurveyId.js";
import queryResult from "../utils/awaitableQuery.js";

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

export default migrateSurveys;
