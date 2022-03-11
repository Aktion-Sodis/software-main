import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/ContentTag.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Content {
  String? id;
  late String name;
  String? description;
  late List<amp.InterventionContentRelation>
      interventions; //many to many -> maybe change
  late List<ContentTag> tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Content(
      {required this.id,
      required this.name,
      this.description,
      required this.interventions,
      required this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Content.fromAmplifyModel(amp.Content content) {
    id = content.id;
    name = content.name;
    description = content.description;
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
        name: name,
        description: description,
        interventions: interventions,
        tags:
            List.generate(tags.length, (index) => tags[index].toAmplifyModel()),
        schemeVersion: schemeVersion));
  }
}
