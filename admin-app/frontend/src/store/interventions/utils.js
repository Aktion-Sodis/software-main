import { v4 as uuidv4 } from 'uuid';
import { API, graphqlOperation } from 'aws-amplify';
import { DataStore } from '@aws-amplify/datastore';
import { listInterventions, listInterventionTags } from '../../graphql/queries';
import { Intervention } from '../../models';

export class EmptyIntervention {
  constructor() {
    this.id = uuidv4();
    this.name = '';
    this.description = '';
    this.tagIds = [];
    this.contents = [];
    this.isEmptyIntervention = true;
  }
}

// Mock API calls
export const postNewIntervention = async (intervention) => DataStore.save(
  new Intervention({
    name: intervention.name,
    description: intervention.description,
    interventionType: intervention.interventionType,
    contents: [],
    surveys: [],
    tags: [],
    schemeVersion: 0,
    levels: [],
  }),
);
export const putIntervention = async (interventionDraft) => interventionDraft;
export const deleteIntervention = async () => ({ errors: [] });
export const getAllInterventions = async () => API.graphql(graphqlOperation(listInterventions));
export const getAllInterventionTags = async () => API.graphql(graphqlOperation(listInterventionTags));
