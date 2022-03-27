import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class InterventionTag {
  String? id;
  late I18nString text_ml;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<amp.InterventionInterventionTagRelation> interventions;

  String get text => text_ml.text;

  set text(String text) => text_ml.text = text;

  InterventionTag(
      {this.id,
      required this.text_ml,
      this.schemeVersion,
      required this.interventions,
      this.createdAt,
      this.updatedAt});

  InterventionTag.fromAmplifyModel(amp.InterventionTag tag) {
    id = tag.id;
    text_ml = I18nString.fromAmplifyModel(tag.text);
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
    interventions = tag.interventions;
  }

  amp.InterventionTag toAmplifyModel() {
    return amp.InterventionTag(
        text: text_ml.toAmplifyModel(),
        id: id,
        schemeVersion: schemeVersion,
        interventions: interventions);
  }
}
