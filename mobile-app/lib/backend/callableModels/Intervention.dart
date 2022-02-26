import 'package:mobile_app/backend/callableModels/Content.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Intervention {
  String id;
  String? name;
  String? description;
  InterventionType? interventionType;
  List<Content>? contents;
  List<Survey>? surveys;
  List<String>? tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Intervention(
      {required this.id,
      this.name,
      this.description,
      this.interventionType,
      this.contents,
      this.surveys,
      this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  amp.Intervention toAmplifyModel() {
    return (
      amp.Intervention(contents: )
      );
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
