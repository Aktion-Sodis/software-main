import { PermissionType } from '../models/index.js';
import * as mutations from '../graphql/mutations.js';
import { API, graphqlOperation } from "aws-amplify";
import * as queries from '../graphql/queries.js';



// Creates a single user with default permissions, who is assigned to all migrated data.
const createMigrationUser = async (allowedEntities) => {
    // First, assign permissions to defaultUser.
    console.log("creating default user");
    let defaultUser = {
    id: "migrateUser",
    firstName : "migrateUser",
    lastName : "MigrationV1",
    bio : "auto-generated user linked to V1-data",
    
}
    defaultUser.permissions = [{
        allowedEntities: [],
        permissionType: PermissionType.ADMIN,
    }];
    console.log("default user created");
    try {
        console.log("now querying");
        const userQuery = await API.graphql({
            query: queries.getUser,
            variables: {
                id: defaultUser.id
            }
        });
        console.log("user query done");

        if(userQuery.data.getUser!=null) {
            console.log("creat user");
            defaultUser._version = userQuery.data.getUser._version;

            const newUserEntry = await API.graphql({
                query: mutations.updateUser,
                variables: {input: defaultUser}
            })
            return newUserEntry;
        }
        else {
            console.log("update user");
            const newUserEntry = await API.graphql({
                query: mutations.createUser,
                variables: {input: defaultUser}
            })
            
            return newUserEntry;
        }
        
    } catch (error) {
        console.log("error in user creation");
        console.log(error);

        
    }
}

export default createMigrationUser;