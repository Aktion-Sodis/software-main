import Amplify, { API, graphqlOperation } from "aws-amplify";
import * as mutations from "../graphql/mutations.js";
import * as schema from "../models/index.js";
import * as queries from "../graphql/queries.js";
import uuid from "uuid";
import mlString from "../utils/stringFormatter.js";

const createBaseLevels = async () => {
  try {
    console.log("dealing pueblo");
    var villageLevel;
    var villageQuery = await API.graphql({
      query: queries.getLevel,
      variables: {
        id: "pueblo_level"
      }
    });
    villageLevel = villageQuery.data.getLevel;
    if(villageLevel === null) {
      const villageCreate = await API.graphql({
        query: mutations.createLevel,
        variables: {
          input: {
            id: "pueblo_level",
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
      villageLevel = villageCreate.data.createLevel;
    }
    console.log("dealing family level");
    var familyLevel;
    var familyQuery = await API.graphql({
      query: queries.getLevel,
      variables: {
        id: "familia_level"
      }
    });
    familyLevel = familyQuery.data.getLevel;
    if(familyLevel === null) {
      const familyCreate = await API.graphql({
        query: mutations.createLevel,
        variables: {
          input: {
            id: "familia_level",
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
      familyLevel = familyCreate.data.createLevel;
    }
    return { villageLevel, familyLevel };
  } catch (e) {
    console.log("error in level creation");
    console.log(e);
  }
  // First, create entity levels manually for village and family.
};

export default createBaseLevels;
