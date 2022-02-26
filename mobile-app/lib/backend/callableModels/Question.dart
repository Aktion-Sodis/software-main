import 'package:mobile_app/backend/callableModels/QuestionOption.dart';

class Question {
  String id;
  String? text;
  QuestionType? type;
  List<QuestionOption>? questionOptions;
  bool? isFollowUpQuestion;

  Question(
      {required this.id,
      this.text,
      this.type,
      this.questionOptions,
      this.isFollowUpQuestion});
}

enum QuestionType {
  TEXT,
  SINGLECHOICE,
  MULTIPLECHOICE,
  PICTURE,
  PICTUREWITHTAGS,
  AUDIO
}
