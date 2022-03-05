import Amplify, { API, graphqlOperation } from "aws-amplify";
import * as mutations from '../graphql/mutations.js';
import * as schema from '../models/index.js';
import uuid from 'uuid';


const createBaseLevels = async () => {
    // First, create entity levels manually for village and family.
    const villageLevel = await API.graphql({
        query: mutations.createLevel, 
        variables: {input: {
            name: "village",
            interventionsAreAllowed: true,
            customData: [{
                name: "numHouseholds",
                type: schema.Type.INT,
                id: uuid.v4(),
            }],
        }},
    })
    console.log("Created villageLevel entry:");
    console.log(villageLevel);

    const familyLevel = await API.graphql({
        query: mutations.createLevel, 
        variables: {input: {
            name: "family",
            interventionsAreAllowed: true,
            parentLevelID: villageLevel.data.createLevel.id,
            customData: [{
                name: "numChildren",
                type: schema.Type.INT,
                id: uuid.v4(),
            }],
        }},
    })
    console.log("Created familyLevel entry:");
    console.log(familyLevel);
}

export default createBaseLevels;