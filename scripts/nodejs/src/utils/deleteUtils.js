import { API, graphqlOperation } from "aws-amplify";
import * as mutations from '../graphql/mutations.js';
import * as queries from '../graphql/queries.js';
import { User } from "../models/index.js";


export async function deleteAppliedInterventions() {
    const appliedInterventionQuery = await API.graphql({query: queries.listAppliedInterventions});
    const deleteAppliedInterventions = appliedInterventionQuery.data.listAppliedInterventions.items.filter((obj) => !obj._deleted);
    deleteAppliedInterventions.forEach((obj) => {
        API.graphql(graphqlOperation(mutations.deleteAppliedIntervention, {
                input: {
                    id: obj.id
                }
            }))
    });
    

}

export async function deleteLevels() {
    const levelQuery = await API.graphql(
        {
            query: queries.listLevels
        }
    );
    console.log("levelQuery");
    console.log(levelQuery);
    const deleteLevelList = levelQuery.data.listLevels.items.filter((obj) => !obj._deleted);
    console.log("deleteLevelList");
    console.log(deleteLevelList)
    deleteLevelList.forEach(
    (obj) => {
        API.graphql(
            graphqlOperation(
                mutations.deleteLevel,
                {
                    input: {
                        id: obj.id
                    }
                }
            )
        )
    });
}

