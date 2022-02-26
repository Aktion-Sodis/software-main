import 'package:mobile_app/backend/callableModels/Marking.dart';
import 'package:mobile_app/backend/callableModels/Question.dart';
import 'package:mobile_app/backend/callableModels/QuestionOption.dart';

class QuestionAnswer {
  String id;
  String? questionID;
  DateTime? date;
  QuestionType? type;
  String? text;
  List<QuestionOption>? questionOptions;
  List<Marking>? markings;

  QuestionAnswer(
      {required this.id,
      this.questionID,
      this.date,
      this.type,
      this.text,
      this.questionOptions,
      this.markings});
}
