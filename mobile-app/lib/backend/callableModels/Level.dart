import 'package:mobile_app/backend/callableModels/CustomData.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';

class Level {
  String id;
  String? name;
  String? description;
  String? parentLevelID;
  bool? interventionsAreAllowed;
  List<Intervention>? allowedInterventions;
  List<CustomData>? customData;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level(
      {required this.id,
      this.name,
      this.description,
      this.parentLevelID,
      this.interventionsAreAllowed,
      this.allowedInterventions,
      this.customData,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
