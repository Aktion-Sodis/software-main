import Amplify, { API, graphqlOperation } from "aws-amplify";
import * as mutations from "../graphql/mutations.js";
import * as schema from "../models/index.js";
import uuid from "uuid";
import mlString from "../utils/stringFormatter.js";

const createBaseLevels = async () => {
  try {
    console.log("creating pueblo");
    let response = await API.graphql({
      query: mutations.createLevel,
      variables: {
        input: {
          name: mlString("Pueblo"),
          description: mlString("Pequenos pueblos en Micani"),
          interventionsAreAllowed: false,
          customData: [
            {
              name: mlString("Residentes"),
              type: schema.Type.INT,
              id: uuid.v4(),
            },
          ],
        },
      },
    });
    const villageLevel = response.data.createLevel;
    console.log("created pueblo");

    console.log("Created villageLevel entry:");
    console.log(villageLevel);

    response = await API.graphql({
      query: mutations.createLevel,
      variables: {
        input: {
          name: mlString("Familia"),
          description: mlString("Una familia en un pueblo"),
          interventionsAreAllowed: true,
          parentLevelID: villageLevel.id,
          customData: [
            {
              name: mlString("Niños"),
              type: schema.Type.INT,
              id: uuid.v4(),
            },
          ],
        },
      },
    });
    const familyLevel = response.data.createLevel;
    console.log("Created familyLevel entry:");
    console.log(familyLevel);
    return { villageLevel, familyLevel };
  } catch (e) {
    console.log("error in level creation");
    console.log(e);
  }
  // First, create entity levels manually for village and family.
};

export default createBaseLevels;
