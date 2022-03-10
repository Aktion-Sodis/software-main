import 'package:mobile_app/backend/callableModels/CustomData.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/I18nString.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Level {
  String? id;
  late I18nString name_ml;
  late I18nString description_ml;
  String? parentLevelID;
  late bool interventionsAreAllowed;
  List<Intervention>? allowedInterventions;
  late List<CustomData> customData;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  Level(
      {this.id,
      required this.name_ml,
      required this.description_ml,
      this.parentLevelID,
      required this.interventionsAreAllowed,
      this.allowedInterventions,
      required this.customData,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Level.fromAmplifyModel(amp.Level level) {
    id = level.id;
    name_ml = I18nString.fromAmplifyModel(level.name);
    description_ml = I18nString.fromAmplifyModel(level.description);
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
        name: name_ml.toAmplifyModel(),
        description: description_ml.toAmplifyModel(),
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
