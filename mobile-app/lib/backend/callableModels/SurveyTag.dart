import 'package:mobile_app/models/ModelProvider.dart' as amp;

class SurveyTag {
  String? id;
  late String text;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  SurveyTag(
      {this.id,
      required this.text,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  SurveyTag.fromAmplifyModel(amp.SurveyTag tag) {
    id = tag.id;
    text = tag.text;
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
  }

  amp.SurveyTag toAmplifyModel() {
    return amp.SurveyTag(text: text, id: id, schemeVersion: schemeVersion);
  }
}
