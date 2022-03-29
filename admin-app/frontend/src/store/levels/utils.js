import { v4 as uuidv4 } from 'uuid';
import { API, graphqlOperation } from 'aws-amplify';
import { listLevels } from '../../graphql/queries';
import { createLevel } from '../../graphql/mutations';
import { Level } from '../../models';

// Mock API calls
export const postNewLevel = async (levelDraft) => API.graphql(
  graphqlOperation(createLevel, {
    input: {
      name: levelDraft.name,
      description: levelDraft.description,
      parentLevelID: levelDraft.parentLevelID,
      id: levelDraft.id,
      interventionsAreAllowed: true,
      customData: [],
      allowedInterventions: levelDraft.allowedInterventions,
    },
  }),
);
export const emptyLevel = () => {
  const level = new Level({
    id: uuidv4(),
    name: '',
    description: '',
    parentLevelID: null,
    allowedInterventions: [],
  });
  return level;
};

export const putLevel = async (levelDraft) => levelDraft;
export const deleteLevel = async () => ({ errors: [] });
export const getAllLevels = async () => API.graphql(graphqlOperation(listLevels));
