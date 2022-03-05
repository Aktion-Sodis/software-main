import * as mutations from '../graphql/mutations.js';

const listVillagesQuery = "SELECT * FROM village;";

const migrateVillages = async (sqlPool, entityLevel) => {
    // First, create entity levels manually for village and family.
    const villagesOld = await sqlPool.query(listVillagesQuery, async function (err, result, fields) {
        if (err) throw err;
        return Object.values(result);
    });

    for (let villageOld of villagesOld){
        const villageEntity = villageTransformer(villageOld, entityLevel)    
        try {
            const newVillageEntity = await API.graphql({
                query: mutations.createEntity,
                variables: {input: villageEntity}
            })
            console.log("Created entity" + JSON.stringify(newVillageEntity));
            
        } catch (error) {
            console.log("Error writing" + JSON.stringify(villageEntity) + error);
        }
    }
}

const villageTransformer = (villageOld, entityLevel) => {
    const villageNew = {
        name: villageOld.name,
            id: villageOld.id,
            interventionsAreAllowed: true,
            level: entityLevel,
    }
    return villageNew;
}

export default migrateVillages;