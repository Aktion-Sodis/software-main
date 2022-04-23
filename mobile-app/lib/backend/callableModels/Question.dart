import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/backend/callableModels/QuestionOption.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Question {
  String? id;
  late I18nString text_ml;
  late QuestionType type;
  List<QuestionOption>? questionOptions;
  late bool isFollowUpQuestion;

  String get text => text_ml.text;

  set text(String text) => text_ml.text = text;

  Question(
      {this.id,
      required this.text_ml,
      required this.type,
      this.questionOptions,
      required this.isFollowUpQuestion});

  amp.Question toAmplifyModel() {
    return amp.Question(
        id: id,
        text: text_ml.toAmplifyModel(),
        type: questionTypeToAmplifyQuestionType(type),
        questionOptions: questionOptions != null
            ? List.generate(questionOptions!.length,
                (index) => questionOptions![index].toAmplifyModel())
            : null,
        isFollowUpQuestion: isFollowUpQuestion);
  }

  Question.fromAmplifyModel(amp.Question question) {
    id = question.id;
    text_ml = I18nString.fromAmplifyModel(question.text);
    type = questionTypeFromAmplifyQuestionType(question.type);
    questionOptions = question.questionOptions != null
        ? List.generate(
            question.questionOptions!.length,
            (index) => QuestionOption.fromAmplifyModel(
                question.questionOptions![index]))
        : null;
    isFollowUpQuestion = question.isFollowUpQuestion;
  }
}

enum QuestionType {
  TEXT,
  SINGLECHOICE,
  MULTIPLECHOICE,
  PICTURE,
  PICTUREWITHTAGS,
  AUDIO,
  INT,
  DOUBLE,
  RATING
}

amp.QuestionType questionTypeToAmplifyQuestionType(QuestionType questionType) {
  switch (questionType) {
    case QuestionType.TEXT:
      return amp.QuestionType.TEXT;
      break;
    case QuestionType.SINGLECHOICE:
      return amp.QuestionType.SINGLECHOICE;
      break;
    case QuestionType.MULTIPLECHOICE:
      return amp.QuestionType.MULTIPLECHOICE;
      break;
    case QuestionType.PICTURE:
      return amp.QuestionType.PICTURE;
      break;
    case QuestionType.PICTUREWITHTAGS:
      return amp.QuestionType.PICTUREWITHTAGS;
      break;
    case QuestionType.AUDIO:
      return amp.QuestionType.AUDIO;
      break;
    case QuestionType.INT:
      return amp.QuestionType.INT;
      break;
    case QuestionType.DOUBLE:
      return amp.QuestionType.DOUBLE;
      break;
    case QuestionType.RATING:
      return amp.QuestionType.RATING;
      break;
  }
}

QuestionType questionTypeFromAmplifyQuestionType(
    amp.QuestionType questionType) {
  switch (questionType) {
    case amp.QuestionType.TEXT:
      return QuestionType.TEXT;
      break;
    case amp.QuestionType.SINGLECHOICE:
      return QuestionType.SINGLECHOICE;
      break;
    case amp.QuestionType.MULTIPLECHOICE:
      return QuestionType.MULTIPLECHOICE;
      break;
    case amp.QuestionType.PICTURE:
      return QuestionType.PICTURE;
      break;
    case amp.QuestionType.PICTUREWITHTAGS:
      return QuestionType.PICTUREWITHTAGS;
      break;
    case amp.QuestionType.AUDIO:
      return QuestionType.AUDIO;
      break;
    case amp.QuestionType.INT:
      return QuestionType.INT;
      break;
    case amp.QuestionType.DOUBLE:
      return QuestionType.DOUBLE;
      break;
    case amp.QuestionType.RATING:
      return QuestionType.RATING;
      break;
  }
}
