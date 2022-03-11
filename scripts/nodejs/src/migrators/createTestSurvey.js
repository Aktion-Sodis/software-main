import * as mutations from '../graphql/mutations.js';
import { InterventionType } from '../models/index.js';
import { API, graphqlOperation } from "aws-amplify";
import mlString from '../utils/stringFormatter.js';

export default async function createTestSurvey() {
    const testSurvey = {
        id: "test_survey",
        name: mlString("TestSurvey"),
        description: mlString("This is a test survey"),
        
    }

    await API.graphql(
        {
            query: mutations.createSurvey,
            variables: {
                input: testSurvey
            }
        }
    )
}