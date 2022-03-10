import * as mutations from '../graphql/mutations.js';
import { InterventionType } from '../models/index.js';
import { API, graphqlOperation } from "aws-amplify";
import * as queries from '../graphql/queries.js';
import mlString from '../utils/stringFormatter.js';

export default async function createOrUpdateTags () {
    const universalTag = {
        text: mlString("Migrado"),
        id: "migration_tag"
    }

    try {
        await API.graphql({
            query: mutations.createSurveyTag,
            variables: {
                input: universalTag
            }
        });
        await API.graphql({
            query: mutations.createContentTag,
            variables: {
                input: universalTag
            }
        });
        await API.graphql({
            query: mutations.createInterventionTag,
            variables: {
                input: universalTag
            }
        });
    }
    catch(e) {}
}