import * as mutations from "../graphql/mutations.js";
import { InterventionType } from "../models/index.js";
import { API, graphqlOperation } from "aws-amplify";
import * as queries from "../graphql/queries.js";
import mlString from "../utils/stringFormatter.js";
import queryResult from "../utils/awaitableQuery.js";

const listProjectsQuery = `
    SELECT * 
    FROM project
    `;

const migrateProjects = async (sqlPool) => {
  const projects = await queryResult(sqlPool, listProjectsQuery);

  console.log(projects);

  const interventionTagQuery = await API.graphql({
    query: queries.listInterventionInterventionTagRelations,
  });
  for (const interventionTag in interventionTagQuery.data
    .listInterventionInterventionTagRelations.list) {
    await API.graphql({
      query: mutations.deleteInterventionInterventionTagRelation,
      variables: {
        input: {
          id: interventionTag.id,
          _version: interventionTag._version,
        },
      },
    });
  }
  var listToReturn = [];
  for (let project of projects) {
    console.log("dealing with project: " + project.name);
    //todo: update tags
    let newIntervention = {
      name: mlString(project.name),
      description: mlString(""),
      interventionType: InterventionType.TECHNOLOGY,
      id: project.id,
    };

    try {
      const newInterventionEntry = await API.graphql({
        query: mutations.createIntervention,
        variables: { input: newIntervention },
      });
      const newInterventionTagConnection = await API.graphql({
        query: mutations.createInterventionInterventionTagRelation,
        variables: {
          input: {
            interventionID: newIntervention.id,
            interventionTagID: "migration_tag",
          },
        },
      });
      listToReturn.push(newInterventionEntry.data.createIntervention);
    } catch (error) {
      const oldInterventionEntry = await API.graphql({
        query: queries.getIntervention,
        variables: {
          id: newIntervention.id,
        },
      });

      newIntervention._version =
        oldInterventionEntry.data.getIntervention._version;
      const updateResult = await API.graphql({
        query: mutations.updateIntervention,
        variables: {
          input: newIntervention,
        },
      });
      const newInterventionTagConnection = await API.graphql({
        query: mutations.createInterventionInterventionTagRelation,
        variables: {
          input: {
            interventionID: newIntervention.id,
            interventionTagID: "migration_tag",
          },
        },
      });
      listToReturn.push(updateResult.data.updateIntervention);
    }
  }
  return listToReturn;
};

export default migrateProjects;
