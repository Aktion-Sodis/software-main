import { PermissionType } from '../models/index.js';
import * as mutations from '../graphql/mutations.js';
import { API, graphqlOperation } from "aws-amplify";
import * as queries from '../graphql/queries.js';

let defaultUser = {
    id: "migrateUser",
    firstName : "migrateUser",
    lastName : "MigrationV1",
    bio : "auto-generated user linked to V1-data",
    
}

// Creates a single user with default permissions, who is assigned to all migrated data.
const createMigrationUser = async (allowedEntities) => {
    // First, assign permissions to defaultUser.
    defaultUser.permissions = [{
        allowedEntities: [],
        permissionType: PermissionType.ADMIN,
    }];
    
    try {
        const newUserEntry = await API.graphql({
            query: mutations.createUser,
            variables: {input: defaultUser}
        })
        
        return newUserEntry;
        
    } catch (error) {
        const userQuery = await API.graphql({
            query: queries.getUser,
            variables: {
                id: defaultUser.id
            }
        });
        defaultUser._version = userQuery.data.getUser._version;

        const newUserEntry = await API.graphql({
            query: mutations.updateUser,
            variables: {input: defaultUser}
        })
        return newUserEntry;
    }
}

export default createMigrationUser;