import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/ContentTag.dart';
import 'package:mobile_app/backend/callableModels/MultiLanguageText.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Content {
  String? id;
  late MultiLanguageText name_ml;
  late MultiLanguageText description_ml;
  late List<amp.InterventionContentRelation>
      interventions; //many to many -> maybe change
  late List<ContentTag> tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  Content(
      {required this.id,
      required this.name_ml,
      required this.description_ml,
      required this.interventions,
      required this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Content.fromAmplifyModel(amp.Content content) {
    id = content.id;
    name_ml = MultiLanguageText.fromAmplifyModel(content.name);
    description_ml = MultiLanguageText.fromAmplifyModel(content.description);
    interventions = content.interventions;
    tags = List.generate(content.tags.length,
        (index) => ContentTag.fromAmplifyModel(content.tags[index]));
    schemeVersion = content.schemeVersion;
    createdAt = content.createdAt?.getDateTimeInUtc();
    updatedAt = content.updatedAt?.getDateTimeInUtc();
  }

  amp.Content toAmplifyModel() {
    return (amp.Content(
        id: id,
        name: name_ml.toAmplifyModel(),
        description: description_ml.toAmplifyModel(),
        interventions: interventions,
        tags:
            List.generate(tags.length, (index) => tags[index].toAmplifyModel()),
        schemeVersion: schemeVersion));
  }
}
