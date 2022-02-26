import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

class AppliedIntervention {
  String id;
  User? whoDidIt;
  Intervention? intervention;
  Location? location;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ExecutedSurvey>? executedSurveys;

  AppliedIntervention(
      {required this.id,
      this.whoDidIt,
      this.intervention,
      this.location,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      this.executedSurveys});
}
