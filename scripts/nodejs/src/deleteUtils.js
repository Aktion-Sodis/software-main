import { API, graphqlOperation } from "aws-amplify";
import * as mutations from './graphql/mutations.js';
import * as queries from './graphql/queries.js';

export async function deleteVillageLevels() {
    const villageLevelQuery = await API.graphql({ query: queries.listLevels, variables: { filter: { name: { eq: "village" } } } });
    const deleteLevels = filterUndeleted(villageLevelQuery.data.listLevels.items);
    await deleteAll(deleteLevels);
}

export async function deleteFamilyLevels() {
    const familyLevelQuery = await API.graphql({ query: queries.listLevels, variables: { filter: { name: { eq: "family" } } } });   
    const deleteLevels = filterUndeleted(familyLevelQuery.data.listLevels.items);
    await deleteAll(deleteLevels);
}

export function filterUndeleted(queryEntries) {
    return queryEntries.filter(function (obj) {
        return obj._deleted === false;
    });
}

async function deleteAll(levels) {
    for (let level of levels) {
        try {
            let deteledObj = await API.graphql(graphqlOperation(mutations.deleteLevel,
                {
                    input: {
                        id: level.id,
                        _version: level._version,
                    }
                }
            ));
            console.log(`DELETED ${deteledObj.data.deleteLevel.name} id: ${deteledObj.data.deleteLevel.id} version: ${deteledObj.data.deleteLevel._version}`);
        } catch (error) {
            console.log(`FAILED TO DELETE ${level.name} id: ${level.id} version: ${level._version}`);
        }
    }
}
