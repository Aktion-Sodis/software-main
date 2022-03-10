import * as mutations from '../graphql/mutations.js';
import { InterventionType } from '../models/index.js';
import { API, graphqlOperation } from "aws-amplify";
import * as queries from '../graphql/queries.js';
import mlString from '../utils/stringFormatter.js';
import queryResult from '../utils/awaitableQuery.js';

const listProjectsQuery = `
    SELECT * 
    FROM project
    `;

const migrateProjects = async (sqlPool) => {
    const projects = await queryResult(sqlPool, listProjectsQuery);

    console.log(projects);

    for (let project of projects){
        //todo: update tags
        let newIntervention = {
            name: mlString(project.name),
            description: mlString(""),
            interventionType : InterventionType.TECHNOLOGY,
            id: project.id,

        }

        let interventionTagRelation = {

        }

        try {
            const newInterventionEntry = await API.graphql({
                query: mutations.createIntervention,
                variables: {input: newIntervention}
            });
            
        } catch (error) {
            console.log(error);
            const oldInterventionEntry = await API.graphql({
                query: queries.getIntervention,
                variables: {
                    id: newIntervention.id
                }
            });
            console.log("old Intervention");
            console.log(oldInterventionEntry.tags);
            newIntervention._version = oldInterventionEntry.data.getIntervention._version
            await API.graphql({
                query: mutations.updateIntervention,
                variables: {
                    input: newIntervention
                }
            });
        }

    }   
}

export default migrateProjects;