import * as mutations from '../graphql/mutations.js';
import { InterventionType,  SurveyType, QuestionType, Type } from '../models/index.js';
import { API, graphqlOperation } from "aws-amplify";
import mlString from '../utils/stringFormatter.js';
import * as queries from '../graphql/queries.js';

export default async function createTestEntities(villageLevel, familyLevel) {
 
    const testEntities = [
        {
            id: "test_village_1",
            name: mlString("Developer Village"),
            description: mlString("Our village for testing purposes. Full of pissed of developers :D"),
            customData: [
                {
                    customDataID: villageLevel.customData[0].id,
                    type: villageLevel.customData[0].type,
                    name: villageLevel.customData[0].name,
                    intValue: (villageLevel.customData[0].type === Type.INT)?2:null,
                    stringValue: (villageLevel.customData[0].type === Type.STRING)?"test":null,
                }
            ],
            entityLevelId: villageLevel.id
        },
        {
            id: "test_developer_1",
            name: mlString("Benedikt Schindele"),
            description: mlString("Currently programming the entity view and creating test data."),
            customData: [
                {
                    customDataID: familyLevel.customData[0].id,
                    type: familyLevel.customData[0].type,
                    name: familyLevel.customData[0].name,
                    intValue: (familyLevel.customData[0].type === Type.INT)?2:null,
                    stringValue: (familyLevel.customData[0].type === Type.STRING)?"test":null,
                }
            ],
            entityLevelId: familyLevel.id,
            parentEntityID: "test_village_1",
        },
        {
            id: "test_developer_2",
            name: mlString("Ahmet Polat"),
            description: mlString("Currently programming admin app and reconsiders lean startup :D<3"),
            parentEntityID: "test_village_1",
            customData: [
                {
                    customDataID: familyLevel.customData[0].id,
                    type: familyLevel.customData[0].type,
                    name: familyLevel.customData[0].name,
                    intValue: (familyLevel.customData[0].type === Type.INT)?2:null,
                    stringValue: (familyLevel.customData[0].type === Type.STRING)?"test":null,
                }
            ],
            entityLevelId: familyLevel.id
        },
        {
            id: "test_village_2",
            name: mlString("Designer Village"),
            description: mlString("Our village for testing purposes. Full of happy designers (except notion)"),
            customData: [
                {
                    customDataID: villageLevel.customData[0].id,
                    type: villageLevel.customData[0].type,
                    name: villageLevel.customData[0].name,
                    intValue: (villageLevel.customData[0].type === Type.INT)?2:null,
                    stringValue: (villageLevel.customData[0].type === Type.STRING)?"test":null,
                }
            ],
            entityLevelId: villageLevel.id
        },
        {
            id: "test_designer_1",
            name: mlString("Kianna"),
            description: mlString("Currently vibin in Amsterdam"),
            parentEntityID: "test_village_2",
            customData: [
                {
                    customDataID: familyLevel.customData[0].id,
                    type: familyLevel.customData[0].type,
                    name: familyLevel.customData[0].name,
                    intValue: (familyLevel.customData[0].type === Type.INT)?2:null,
                    stringValue: (familyLevel.customData[0].type === Type.STRING)?"test":null,
                }
            ],
            entityLevelId: familyLevel.id
        },
    ];
    try {
        for(const entity of testEntities) {
            await API.graphql(
                {
                    query: mutations.createEntity,
                    variables: {
                        input: entity
                    }
                    }
            )
        }
    }
    catch(e) {
        console.log("error in creating test entities");
        console.log(e);
    }
}