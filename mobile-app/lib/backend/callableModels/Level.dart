import 'package:mobile_app/backend/callableModels/CustomData.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Level {
  String? id;
  late String name;
  String? description;
  String? parentLevelID;
  late bool interventionsAreAllowed;
  List<Intervention>? allowedInterventions;
  late List<CustomData> customData;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level(
      {this.id,
      required this.name,
      this.description,
      this.parentLevelID,
      required this.interventionsAreAllowed,
      this.allowedInterventions,
      required this.customData,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Level.fromAmplifyModel(amp.Level level) {
    id = level.id;
    name = level.name;
    description = level.description;
    parentLevelID = level.parentLevelID;
    interventionsAreAllowed = level.interventionsAreAllowed;
    allowedInterventions = level.allowedInterventions != null
        ? List.generate(
            level.allowedInterventions!.length,
            (index) => Intervention.fromAmplifyModel(
                level.allowedInterventions![index]))
        : null;
    customData = List.generate(level.customData.length,
        (index) => CustomData.fromAmplifyModel(level.customData[index]));
    schemeVersion = level.schemeVersion;
    createdAt = level.createdAt?.getDateTimeInUtc();
    updatedAt = level.updatedAt?.getDateTimeInUtc();
  }

  amp.Level toAmplifyModel() {
    return amp.Level(
        id: id,
        name: name,
        description: description,
        parentLevelID: parentLevelID,
        interventionsAreAllowed: interventionsAreAllowed,
        allowedInterventions: allowedInterventions != null
            ? List.generate(allowedInterventions!.length,
                (index) => allowedInterventions![index].toAmplifyModel())
            : null,
        customData: List.generate(
            customData.length, (index) => customData[index].toAmplifyModel()),
        schemeVersion: schemeVersion);
  }
}
