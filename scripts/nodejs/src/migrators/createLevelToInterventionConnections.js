import Amplify, { API, graphqlOperation } from "aws-amplify";
import * as mutations from "../graphql/mutations.js";
import * as queries from "../graphql/queries.js";
import * as schema from "../models/index.js";
import uuid from "uuid";
import mlString from "../utils/stringFormatter.js";

export default async function createLevelToInterventionConnections(level) {
  try {
    console.log("now querying interventionconnections");
    const connectionQuery = await API.graphql({
      query: queries.listLevelInterventionRelations,
    });
    console.log("connections queried");
    const connections =
      connectionQuery.data.listLevelInterventionRelations.items;
    for (const connection of connections) {
      if (!connection._deleted) {
        await API.graphql({
          query: mutations.deleteLevelInterventionRelation,
          variables: {
            id: connection.id,
            _version: connection._version,
          },
        });
      }
    }
    console.log("connections deleted");
    const interventionQuery = await API.graphql({
      query: queries.listInterventions,
    });
    console.log("interventionQuery");
    console.log(interventionQuery);
    const interventionList = interventionQuery.data.listInterventions.items;
    console.log(interventionList);
    for (const intervention of interventionList) {
      console.log("intervention");
      console.log(intervention);
      console.log(
        "creating levelInterventionConnection for " + intervention.id
      );
      await API.graphql({
        query: mutations.createLevelInterventionRelation,
        variables: {
          input: {
            levelID: level.id,
            interventionID: intervention.id,
          },
        },
      });
    }
  } catch (e) {
    console.log("error in drawing connections");
    console.log(e);
  }
}
