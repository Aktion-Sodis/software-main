import * as mutations from '../graphql/mutations.js';

const listFamiliesQuery = `
    SELECT * 
    FROM interviewee;
    `;

const migrateFamilies = async (sqlPool, entityLevel) => {
    await sqlPool.query(listFamiliesQuery, function (err, result, fields) {
        if (err) throw err;
        Object.values(result).forEach(function(familyOld) {
            const familyNew = familyTransformer(familyOld, entityLevel)    
            try {
                const newFamilyEntry = await API.graphql({
                    query: mutations.createEntity,
                    variables: {input: familyNew}
                })
                console.log("Created family entity" + JSON.stringify(newFamilyEntry));
                
            } catch (error) {
                console.log("Error writing family" + JSON.stringify(familyNew) + error);
            }
        });
    });
    
}

const familyTransformer = (familyOld, entityLevel) => {
    const familyNew = {
        name: familyOld.name,
        id: familyOld.id,
        interventionsAreAllowed: true,
        parentEntityId: familyOld.village_id,
        level: entityLevel,
    }
    return familyNew;
}

export default migrateFamilies;