import * as mutations from './graphql/mutations.js';

const listUsersQuery = `
    SELECT *, GROUP_CONCAT(interviewee.id) as allowedEntities 
    FROM user JOIN 
    interviewee ON interviewee.user_id=user.id 
    GROUP BY user.id;
    `;

const migrateUsers = async (sqlPool, permissions) => {
    // First, create entity levels manually for village and family.
    await sqlPool.query(listUsersQuery, function (err, result, fields) {
        if (err) throw err;
        Object.values(result).forEach(function(userOld) {
            const userNew = userTransformer(userOld, permissions)    
            try {
                const newUserEntry = await API.graphql({
                    query: mutations.createUser,
                    variables: {input: userNew}
                })
                console.log("Created entity" + JSON.stringify(newUserEntry));
                
            } catch (error) {
                console.log("Error writing" + JSON.stringify(userNew) + error);
            }
        });
    });
}

const userTransformer = (userOld, permissions) => {
    const userNew = {
        firstName : userOld.first_name,
        lastName : userOld.last_name,
        permissions : permissions,
    }
    return userNew;
}

export default migrateUsers;