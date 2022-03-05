import Amplify, { API, graphqlOperation } from "aws-amplify";
import * as mutations from '../graphql/mutations.js';
import * as schema from '../models/index.js';
import uuid from 'uuid';


const createBaseLevels = async () => {
    // First, create entity levels manually for village and family.
    let response = await API.graphql({
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
    const villageLevel = response.data.createLevel;

    console.log("Created villageLevel entry:");
    console.log(villageLevel);

    response = await API.graphql({
        query: mutations.createLevel, 
        variables: {input: {
            name: "family",
            interventionsAreAllowed: true,
            parentLevelID: villageLevel.id,
            customData: [{
                name: "numChildren",
                type: schema.Type.INT,
                id: uuid.v4(),
            }],
        }},
    })
    const familyLevel = response.data.createLevel;
    console.log("Created familyLevel entry:");
    console.log(familyLevel);
    return {villageLevel, familyLevel}
}

export default createBaseLevels;