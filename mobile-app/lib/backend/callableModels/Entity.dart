import 'package:mobile_app/backend/callableModels/AppliedCustomData.dart';
import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Level.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/I18nString.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Entity {
  String? id;
  late I18nString name_ml;
  late I18nString description_ml;
  String? parentEntityID;
  late Level level;
  Location? location;
  late List<AppliedCustomData> customData;
  late List<AppliedIntervention> appliedInterventions;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  Entity(
      {this.id,
      required this.name_ml,
      required this.description_ml,
      this.parentEntityID,
      required this.level,
      this.location,
      required this.customData,
      required this.appliedInterventions,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Entity.fromAmplifyModel(amp.Entity entity) {
    id = entity.id;
    name_ml = I18nString.fromAmplifyModel(entity.name);
    description_ml = I18nString.fromAmplifyModel(entity.description);
    parentEntityID = entity.parentEntityID;
    level = Level.fromAmplifyModel(entity.level);
    location = entity.location == null
        ? null
        : Location.fromAmplifyModel(entity.location!);
    customData = List.generate(
        entity.customData.length,
        (index) =>
            AppliedCustomData.fromAmplifyModel(entity.customData[index]));
    appliedInterventions = List.generate(
        entity.appliedInterventions.length,
        (index) => AppliedIntervention.fromAmplifyModel(
            entity.appliedInterventions[index]));
    schemeVersion = entity.schemeVersion;
    createdAt = entity.createdAt?.getDateTimeInUtc();
    updatedAt = entity.updatedAt?.getDateTimeInUtc();
  }

  amp.Entity toAmplifyModel() {
    return (amp.Entity(
        id: id,
        name: name_ml.toAmplifyModel(),
        description: description_ml.toAmplifyModel(),
        parentEntityID: parentEntityID,
        level: level.toAmplifyModel(),
        location: location?.toAmplifyModel(),
        customData: List.generate(
            customData.length, (index) => customData[index].toAmplifyModel()),
        appliedInterventions: List.generate(appliedInterventions.length,
            (index) => appliedInterventions[index].toAmplifyModel()),
        schemeVersion: schemeVersion,
        entityLevelId: level.id!));
  }

  List<ExecutedSurvey> executedSurveysDescending() {
    List<ExecutedSurvey> toSort = [];
    for (AppliedIntervention appliedIntervention in appliedInterventions) {
      toSort.addAll(appliedIntervention.executedSurveys);
    }
    toSort.sort((a, b) => b.date.difference(a.date).inHours);
    return toSort;
  }
}
