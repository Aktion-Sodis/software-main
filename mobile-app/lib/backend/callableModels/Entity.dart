import 'package:mobile_app/backend/callableModels/AppliedCustomData.dart';
import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Level.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';

class Entity {
  String id;
  String? name;
  String? description;
  String? parentEntityID;
  Level? level;
  Location? location;
  List<AppliedCustomData>? customData;
  List<AppliedIntervention>? appliedInterventions;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Entity(
      {required this.id,
      this.name,
      this.description,
      this.parentEntityID,
      this.level,
      this.location,
      this.customData,
      this.appliedInterventions,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
