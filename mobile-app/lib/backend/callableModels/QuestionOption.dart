import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class QuestionOption {
  String? id;
  late I18nString text_ml;
  String? followUpQuestionID;

  String get text => text_ml.text;

  set text(String text) => text_ml.text = text;

  QuestionOption({this.id, required this.text_ml, this.followUpQuestionID});

  amp.QuestionOption toAmplifyModel() {
    return amp.QuestionOption(
        text: text_ml.toAmplifyModel(),
        followUpQuestionID: followUpQuestionID,
        id: id);
  }

  QuestionOption.fromAmplifyModel(amp.QuestionOption questionOption) {
    id = questionOption.id;
    text_ml = I18nString.fromAmplifyModel(questionOption.text);
    followUpQuestionID = questionOption.followUpQuestionID;
  }
}
