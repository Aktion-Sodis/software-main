import 'package:mobile_app/backend/callableModels/AppliedCustomData.dart';
import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Level.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Entity {
  String? id;
  late String name;
  String? description;
  String? parentEntityID;
  late Level level;
  Location? location;
  late List<AppliedCustomData> customData;
  late List<AppliedIntervention> appliedInterventions;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Entity(
      {this.id,
      required this.name,
      this.description,
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
    name = entity.name;
    description = entity.description;
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
        name: name,
        description: description,
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
}
