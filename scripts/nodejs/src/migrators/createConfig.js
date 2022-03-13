import * as mutations from '../graphql/mutations.js';
import { API, graphqlOperation } from "aws-amplify";
import * as queries from '../graphql/queries.js';

const createConfig = async ()=> {
    let config = {
        id: "sodis_config",
        name: "Fundación Sodis/Aktion Sodis e.V.",
        colorTheme: {
            highlight: "test",
            secondaryHighlight: "test",
            backgroundOneLight: "test",
            backgroundTwoLight: "test",
            backgroundOneDark: "test",
            backgroundTwoDark: "test"
        },
    }
    try {
       const createdConfig = await API.graphql(
        {
            query: mutations.createConfig,
            variables: {
                input: config
            } 
        }
        );
        return createdConfig;
    }catch(e) {
        const currentConfig = await API.graphql({
            query: queries.getConfig,
            variables: {
                id: config.id
            }
        });
        const newVersion = currentConfig.data.getConfig._version;
        config._version = newVersion;
        const updatedConfig = await API.graphql({
            query: mutations.updateConfig,
            variables: {
                input: config,
            }
            });
            return updatedConfig;
    }
    
    
}

export default createConfig;