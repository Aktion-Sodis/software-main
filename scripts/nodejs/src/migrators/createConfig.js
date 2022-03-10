import * as mutations from '../graphql/mutations.js';

const createConfig = async ()=> {
    const config = {
        id: "sodis_config",
        name: "Fundación Sodis/Aktion Sodis e.V.",
        colorTheme: {
            highlight: "test",
            secondaryHighlight: "test",
            backgroundOneLight: "test",
            backgroundTwoLight: "test",
            backgroundOneDark: "test",
            backgroundTwoDark: "test"
        }
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
        const updatedConfig = await API.graphql({
            query: mutations.updateConfig,
            input: {
                variables: config
            }
            });
            return updatedConfig;
    }
    
    
}

export default createConfig;