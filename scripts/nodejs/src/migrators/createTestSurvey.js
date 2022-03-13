import * as mutations from '../graphql/mutations.js';
import { InterventionType,  SurveyType, QuestionType } from '../models/index.js';
import { API, graphqlOperation } from "aws-amplify";
import mlString from '../utils/stringFormatter.js';
import * as queries from '../graphql/queries.js';

export default async function createTestSurvey() {
    const testSurvey = {
        id: "test_survey",
        interventionSurveysId: "6",
        name: mlString("TestSurvey"),
        description: mlString("This is a test survey"),
        surveyType: SurveyType.DEFAULT,
        questions: [
            {
                id: "question_1",
                text: mlString("Is this a good question?"),
                type: QuestionType.SINGLECHOICE,
                questionOptions: [
                    {
                        id: "question_1_option_1",
                        text: mlString("Yes"),
                    },
                    {
                        id: "question_1_option_2",
                        text: mlString("No (has follow up -> test follow up function)"),
                        followUpQuestionID: "question_1_fu_1"
                    }
                ],
                isFollowUpQuestion: false
            },
            {
                id: "question_1_fu_1",
                text: mlString("Why didn't you like it?"),
                type: QuestionType.TEXT,
                isFollowUpQuestion: true
            },
            {
                id: "question_2",
                text: mlString("Try those multiple choice boxes!"),
                type: QuestionType.MULTIPLECHOICE,
                questionOptions: [
                    {
                        id: "question_1_option_1",
                        text: mlString("Box 1")
                    },
                    {
                        id: "question_1_option_2",
                        text: mlString("Box 2")
                    },
                    {
                        id: "question_1_option_3",
                        text: mlString("Box 3")
                    },
                ],
                isFollowUpQuestion: false
            },
            {
                id: "question_3",
                text: mlString("Take a pic of big chungus for testing reasons and upload ist :D <3"),
                type: QuestionType.PICTURE,
                isFollowUpQuestion: false
            }
        ],
    }
    try {
       await API.graphql(
            {
            query: mutations.createSurvey,
            variables: {
                input: testSurvey
            }
            }
        );
        
     
    } catch(e) {
        console.log("error in surveycreation");
        console.log(e);
    }

    try {
await API.graphql({
            query: mutations.createSurveySurveyTagRelation,
            variables: {
                input: {
                    surveyID: "test_survey",
                    surveyTagID: "migration_tag"
                }
            }
        });
    }catch(e) {
        console.log("error in creating surveytagconnection");
        console.log(e);
    }

     
}