import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:mobile_app/backend/callableModels/Marking.dart';
import 'package:mobile_app/backend/callableModels/Question.dart';
import 'package:mobile_app/backend/callableModels/QuestionOption.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class QuestionAnswer {
  String? id;
  late String questionID;
  late DateTime date;
  late QuestionType type;
  String? text;
  int? intValue;
  double? doubleValue;
  int? rating;
  List<QuestionOption>? questionOptions;
  List<Marking>? markings;

  QuestionAnswer(
      {this.id,
      required this.questionID,
      required this.date,
      required this.type,
      this.text,
      this.questionOptions,
      this.markings,
      this.intValue,
      this.doubleValue,
      this.rating});

  QuestionAnswer.fromAmplifyModel(amp.QuestionAnswer questionAnswer) {
    id = questionAnswer.id;
    questionID = questionAnswer.questionID;
    date = questionAnswer.date.getDateTimeInUtc();
    type = questionTypeFromAmplifyQuestionType(questionAnswer.type);
    text = questionAnswer.text;
    intValue = questionAnswer.intValue;
    doubleValue = questionAnswer.doubleValue;
    rating = questionAnswer.rating;
    questionOptions = questionAnswer.questionOptions != null
        ? List.generate(
            questionAnswer.questionOptions!.length,
            (index) => QuestionOption.fromAmplifyModel(
                questionAnswer.questionOptions![index]))
        : null;
    markings = questionAnswer.markings != null
        ? List.generate(
            questionAnswer.markings!.length,
            (index) =>
                Marking.fromAmplifyModel(questionAnswer.markings![index]))
        : null;
  }

  amp.QuestionAnswer toAmplifyModel() {
    return amp.QuestionAnswer(
        id: id,
        questionID: questionID,
        date: TemporalDateTime(date),
        type: questionTypeToAmplifyQuestionType(type),
        text: text,
        intValue: intValue,
        doubleValue: doubleValue,
        rating: rating,
        questionOptions: questionOptions != null
            ? List.generate(questionOptions!.length,
                (index) => questionOptions![index].toAmplifyModel())
            : null,
        markings: markings != null
            ? List.generate(
                markings!.length, (index) => markings![index].toAmplifyModel())
            : null);
  }
}
