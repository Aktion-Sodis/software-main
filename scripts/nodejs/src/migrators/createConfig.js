import * as mutations from "../graphql/mutations.js";
import { API, graphqlOperation } from "aws-amplify";
import * as queries from "../graphql/queries.js";

const createConfigMigrator = async () => {
  let config = {
    id: "sodis_config",
    name: "Fundación Sodis/Aktion Sodis e.V.",
    colorTheme: {
      highlight: "test",
      secondaryHighlight: "test",
      backgroundOneLight: "test",
      backgroundTwoLight: "test",
      backgroundOneDark: "test",
      backgroundTwoDark: "test",
    },
  };

  try {
    console.log("trying to create config");
    var createdConfig = await API.graphql({
      query: mutations.createConfig,
      variables: {
        input: config,
      },
    });
    console.log("created config: ");
    console.log(createdConfig);
    return createdConfig.data.createConfig;
  } catch (e) {
    console.log("updates currentConfig");
    console.log(e);
    var currentConfig = await API.graphql({
      query: queries.getConfig,
      variables: {
        id: config.id,
      },
    });
    const newVersion = currentConfig.data.getConfig._version;
    config._version = newVersion;
    const updatedConfig = await API.graphql({
      query: mutations.updateConfig,
      variables: {
        input: config,
      },
    });
    return updatedConfig.data.updateConfig;
  }
};

export default createConfigMigrator;
