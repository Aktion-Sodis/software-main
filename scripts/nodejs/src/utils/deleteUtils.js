import { API, graphqlOperation } from "aws-amplify";
import * as mutations from '../graphql/mutations.js';
import * as queries from '../graphql/queries.js';
import { User } from "../models/index.js";
import uuid from 'uuid';


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

export async function deleteEntities() {
    try {
        console.log("querying entities");
        const entityQuery = await API.graphql({query: queries.listEntities});
        console.log("query successfull");
        const deleteEntities = entityQuery.data.listEntities.items.filter((obj) => !obj._deleted);
        console.log("filtering successfull: " + deleteEntities.length);
        for(const obj of deleteEntities) {
            await API.graphql(graphqlOperation(mutations.deleteEntity, {
                input: {
                    id: obj.id,
                    _version: obj._version
                }
            }));
        } 
    }catch(e) {
        console.log("error in delete Entities");
        console.log(e);
    }
    
    
}

export async function deleteLevels() {
    try {
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
                        id: obj.id,
                        _version: obj._version
                    }
                }
            )
        )
    });
    console.log("deleted Levels");
    const levelInterventionConnextion = await API.graphql(
        {
            query: queries.listLevelInterventionRelations
        }
    );
    console.log("result of level intervention call");
    console.log(levelInterventionConnextion.data.listLevelInterventionRelations);
    const deleteInterventionConnectionList = levelInterventionConnextion.data.listLevelInterventionRelations.items.filter((obj) => !obj._deleted);
    console.log("to delete connections: " + deleteInterventionConnectionList.length);
    for (const levelInterventionConnection of deleteInterventionConnectionList) {
        await API.graphql(graphqlOperation(mutations.deleteLevelInterventionRelation, {input: {
            id: obj.id,
            _version: obj._version
        }}));
    }
    
    console.log("deleted level intervention relations");
    }catch(e) {
        console.log("error in level and levelintervention deletion");
        console.log(e);
    }
    
}

