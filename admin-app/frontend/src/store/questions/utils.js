export class EmptyQuestion {
  constructor() {
    this.questionText = '';
    this.questionType = 'text';
    this.answers = [{ answerText: '' }];
    this.isEmptyQuestion = true;
  }
}

export class EmptyAnswer {
  constructor() {
    this.answerText = '';
    this.isEmptyAnswer = true;
  }
}

export class Question {
  constructor({ questionText, questionType }) {
    this.questionText = questionText;
    this.questionType = questionType;
  }
}

export class Answer {
  constructor({ answerText }) {
    this.answerText = answerText;
  }
}
