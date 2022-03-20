import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/ContentTag.dart';
import 'package:mobile_app/backend/callableModels/I18nString.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Content {
  String? id;
  late I18nString name_ml;
  late I18nString description_ml;
  late List<amp.InterventionContentRelation>
      interventions; //many to many -> maybe change
  late List<amp.ContentContentTagRelation> tagConnections;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  List<ContentTag> get tags => List.generate(tagConnections.length,
      (index) => ContentTag.fromAmplifyModel(tagConnections[index].contentTag));

  void addContentTag(ContentTag contentTag) {
    tagConnections.add(amp.ContentContentTagRelation(
        content: toAmplifyModel(), contentTag: contentTag.toAmplifyModel()));
  }

  void updateContentTag(ContentTag contentTag) {
    int index = tagConnections
        .indexWhere((element) => element.contentTag.id == contentTag.id);
    if (index >= 0) {
      tagConnections[index] = tagConnections[index]
          .copyWith(contentTag: contentTag.toAmplifyModel());
    } else {
      addContentTag(contentTag);
    }
  }

  Content(
      {required this.id,
      required this.name_ml,
      required this.description_ml,
      required this.interventions,
      required this.tagConnections,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Content.fromAmplifyModel(amp.Content content) {
    id = content.id;
    name_ml = I18nString.fromAmplifyModel(content.name);
    description_ml = I18nString.fromAmplifyModel(content.description);
    interventions = content.interventions;
    tagConnections = content.tags;
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
        tags: tagConnections,
        schemeVersion: schemeVersion));
  }
}
