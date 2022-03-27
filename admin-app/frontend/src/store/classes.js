import { v4 as uuidv4 } from 'uuid';

class EmptyTag {
  constructor() {
    this.id = uuidv4();
    this.text = '';
  }
}

class Tag {
  constructor({ id, text }) {
    this.id = id;
    this.text = text;
  }
}

export { EmptyTag, Tag };
