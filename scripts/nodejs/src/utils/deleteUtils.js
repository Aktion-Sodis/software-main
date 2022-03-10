import { API, graphqlOperation } from "aws-amplify";
import * as mutations from '../graphql/mutations.js';
import * as queries from '../graphql/queries.js';
import { User } from "../models/index.js";

export async function deleteUsers() {
    const userQuery = await API.graphql({
        query: queries.listUsers
    });
    const deleteUsers = filterUndeleted(userQuery.data.listUsers.items);
    for (let deleteUser of deleteUsers) {
        await API.graphql(graphqlOperation(mutations.deleteUser, {
            input: {
                id: deleteUser.id
            }
        }));
    }
}

export async function deleteAppliedInterventions() {
    const appliedInterventionQuery = await API.graphql({query: queries.listAppliedInterventions});
    const deleteAppliedInterventions = appliedInterventionQuery.data.listAppliedInterventions.items.filter((obj) => !obj._deleted);
    deleteAppliedInterventions.foreach((obj) => {
        API.graphql(graphqlOperation(mutations.deleteAppliedIntervention, {
                input: {
                    id: obj.id
                }
            }))
    })
    

}

export async function deleteLevels() {
    const levelQuery = await API.graphql(
        {
            query: queries.listLevels
        }
    );
    const deleteLevelList = levelQuery.data.listLevels.items.filter((obj) => !obj._deleted);
    deleteLevelList.foreach((obj) => {
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

