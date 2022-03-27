import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class SurveyTag {
  String? id;
  late I18nString text_ml;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<amp.SurveySurveyTagRelation> surveys;

  String get text => text_ml.text;

  set text(String text) => text_ml.text = text;

  SurveyTag(
      {this.id,
      required this.text_ml,
      this.schemeVersion,
      required this.surveys,
      this.createdAt,
      this.updatedAt});

  SurveyTag.fromAmplifyModel(amp.SurveyTag tag) {
    id = tag.id;
    text_ml = I18nString.fromAmplifyModel(tag.text);
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
    surveys = tag.surveys;
  }

  amp.SurveyTag toAmplifyModel() {
    return amp.SurveyTag(
        text: text_ml.toAmplifyModel(),
        id: id,
        schemeVersion: schemeVersion,
        surveys: surveys);
  }
}
