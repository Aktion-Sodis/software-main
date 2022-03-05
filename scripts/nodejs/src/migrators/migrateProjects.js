import * as mutations from '../graphql/mutations.js';
import { InterventionType } from '../models/index.js';

const listProjectsQuery = `
    SELECT * 
    FROM project
    `;

const migrateProjects = async (sqlPool) => {
    const projects = await sqlPool.query(listProjectsQuery, function (err, result, fields) {
        if (err) throw err;
        console.log(result)
        console.log(fields)
        return result;
    });

    for (let project of projects){
        const newIntervention = {
            name: project.name,
            interventionType : InterventionType.TECHNOLOGY,
            tags: ["migrated"],
            id: project.id,
        }

        try {
            const newInterventionEntry = await API.graphql({
                query: mutations.createIntervention,
                variables: {input: newIntervention}
            })
            console.log("Created intervention" + JSON.stringify(newInterventionEntry));
            
        } catch (error) {
            console.log("Error writing project as intervention" + JSON.stringify(newIntervention) + error);
        }

    }   
}

export default migrateProjects;