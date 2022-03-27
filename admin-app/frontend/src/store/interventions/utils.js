import { v4 as uuidv4 } from 'uuid';
import { API, graphqlOperation } from 'aws-amplify';
import { listInterventions, listInterventionTags } from '../../graphql/queries';
import { createIntervention } from '../../graphql/mutations';

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

export class Intervention {
  constructor({
    id, name, description, tagIds, contents,
  }) {
    this.id = id ?? uuidv4();
    this.name = name ?? '';
    this.description = description ?? '';
    this.tagIds = tagIds ?? [];
    this.contents = contents ?? [];
    this.isEmptyIntervention = false;
  }
}

// Mock API calls
export const postNewIntervention = async ({ id, name, description }) => API.graphql(
  graphqlOperation(createIntervention, {
    input: {
      id,
      name,
      description,
      interventionType: 'TECHNOLOGY',
      tags: [],
    },
  }),
);
export const putIntervention = async (interventionDraft) => interventionDraft;
export const deleteIntervention = async () => ({ errors: [] });
export const getAllInterventions = async () => API.graphql(graphqlOperation(listInterventions));
export const getAllInterventionTags = async () => API.graphql(graphqlOperation(listInterventionTags));
