import { PermissionType } from '../models/index.js';
import * as mutations from './graphql/mutations.js';

const defaultUser = {
    firstName : "defaultUser",
    lastName : "MigrationV1",
    bio : "auto-generated user linked to V1-data",
    
}

// Creates a single user with default permissions, who is assigned to all migrated data.
const createMigrationUser = async (allowedEntities) => {
    // First, assign permissions to defaultUser.
    defaultUser.permissions = [{
        allowedEntities: allowedEntities,
        permissionType: PermissionType.READ,
    }];
    
    try {
        const newUserEntry = await API.graphql({
            query: mutations.createUser,
            variables: {input: defaultUser}
        })
        console.log("Created entity" + JSON.stringify(newUserEntry));
        return newUserEntry;
        
    } catch (error) {
        console.log("Error writing" + JSON.stringify(defaultUser) + error);
    }
}

export default createMigrationUser;