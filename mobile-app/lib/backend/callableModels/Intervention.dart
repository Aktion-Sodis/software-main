import 'package:mobile_app/backend/callableModels/Content.dart';
import 'package:mobile_app/backend/callableModels/MultiLanguageText.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';
import 'package:mobile_app/backend/callableModels/InterventionTag.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Intervention {
  String? id;
  late MultiLanguageText name_ml;
  late MultiLanguageText description_ml;
  late InterventionType interventionType;
  late List<amp.InterventionContentRelation> interventionContentRelations;
  late List<Survey> surveys;
  late List<InterventionTag> tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  Intervention(
      {this.id,
      required this.name_ml,
      required this.description_ml,
      required this.interventionType,
      required this.interventionContentRelations,
      required this.surveys,
      required this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Intervention.fromAmplifyModel(amp.Intervention intervention) {
    id = intervention.id;
    name_ml = MultiLanguageText.fromAmplifyModel(intervention.name);
    description_ml =
        MultiLanguageText.fromAmplifyModel(intervention.description);
    interventionType = interventionTypeFromAmplifyInterventionType(
        intervention.interventionType);
    interventionContentRelations = intervention.contents;
    surveys = List.generate(intervention.surveys.length,
        (index) => Survey.fromAmplifyModel(intervention.surveys[index]));
    tags = List.generate(intervention.tags.length,
        (index) => InterventionTag.fromAmplifyModel(intervention.tags[index]));
    schemeVersion = intervention.schemeVersion;
    createdAt = intervention.createdAt?.getDateTimeInUtc();
    updatedAt = intervention.updatedAt?.getDateTimeInUtc();
  }

  amp.Intervention toAmplifyModel() {
    return (amp.Intervention(
        id: id,
        name: name_ml.toAmplifyModel(),
        description: description_ml.toAmplifyModel(),
        interventionType:
            amplifyInterventionTypeFromInterventionType(interventionType),
        contents: interventionContentRelations,
        tags:
            List.generate(tags.length, (index) => tags[index].toAmplifyModel()),
        surveys: List.generate(
            surveys.length, (index) => surveys[index].toAmplifyModel()),
        schemeVersion: schemeVersion));
  }
}

enum InterventionType { TECHNOLOGY, EDUCATION }

amp.InterventionType amplifyInterventionTypeFromInterventionType(
    InterventionType interventionType) {
  switch (interventionType) {
    case InterventionType.TECHNOLOGY:
      return amp.InterventionType.TECHNOLOGY;
      break;
    case InterventionType.EDUCATION:
      return amp.InterventionType.EDUCATION;
      break;
  }
}

InterventionType interventionTypeFromAmplifyInterventionType(
    amp.InterventionType interventionType) {
  switch (interventionType) {
    case amp.InterventionType.TECHNOLOGY:
      return InterventionType.TECHNOLOGY;
      break;
    case amp.InterventionType.EDUCATION:
      return InterventionType.EDUCATION;
      break;
  }
}
