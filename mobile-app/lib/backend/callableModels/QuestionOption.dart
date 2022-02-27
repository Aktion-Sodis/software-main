import 'package:mobile_app/models/ModelProvider.dart' as amp;

class QuestionOption {
  String? id;
  late String text;
  String? followUpQuestionID;

  QuestionOption({this.id, required this.text, this.followUpQuestionID});

  amp.QuestionOption toAmplifyModel() {
    return amp.QuestionOption(
        text: text, followUpQuestionID: followUpQuestionID, id: id);
  }

  QuestionOption.fromAmplifyModel(amp.QuestionOption questionOption) {
    id = questionOption.id;
    text = questionOption.text;
    followUpQuestionID = questionOption.followUpQuestionID;
  }
}
