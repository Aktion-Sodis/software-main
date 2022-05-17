import * as mutations from "../graphql/mutations.js";
import { InterventionType } from "../models/index.js";
import { API, graphqlOperation } from "aws-amplify";
import * as queries from "../graphql/queries.js";
import mlString from "../utils/stringFormatter.js";

export default async function createOrUpdateTags() {
  try {
    const universalTag = {
      text: mlString("Migrado"),
      id: "migration_tag",
    };
    console.log("querying survey Tag");

    var currentSurveyTag;
    try {
      const queryResult = await API.graphql({
        query: queries.getSurveyTag,
        input: {
          id: "migration_tag",
        },
      });
      currentSurveyTag = queryResult.data.getSurveyTag;
    } catch (e) {
      currentSurveyTag = null;
    }

    console.log("survey tag gotten");

    if (currentSurveyTag === null) {
      await API.graphql({
        query: mutations.createSurveyTag,
        variables: {
          input: universalTag,
        },
      });

      console.log("creating content Tag");
      await API.graphql({
        query: mutations.createContentTag,
        variables: {
          input: universalTag,
        },
      }).catch((e) => {
        console.log("error in content tag");
        console.log(e);
      });

      console.log("creating intervention tag");
      await API.graphql({
        query: mutations.createInterventionTag,
        variables: {
          input: universalTag,
        },
      }).catch((e) => {
        console.log("error in intervention tag");
        console.log(e);
      });
    }
  } catch (e) {
    console.log("error in tag creation");
    console.log(e);
  }
}
