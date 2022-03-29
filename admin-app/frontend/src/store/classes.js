import { v4 as uuidv4 } from 'uuid';
import { Intervention, InterventionType } from '../models';

const emptyIntervention = () => new Intervention({
  id: uuidv4(),
  name: '',
  description: '',
  tags: [],
  type: InterventionType.TECHNOLOGY,
  questionIds: [],
  contents: [],
});

export { emptyIntervention };
