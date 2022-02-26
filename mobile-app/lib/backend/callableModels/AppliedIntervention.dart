import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/User.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedIntervention {
  String id;
  late User whoDidIt;
  late Intervention intervention;
  Location? location;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ExecutedSurvey> executedSurveys;

  AppliedIntervention(
      {required this.id,
      this.whoDidIt,
      this.intervention,
      this.location,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      this.executedSurveys});

  amp.AppliedIntervention toAmplifyModel() {
    return (amp.AppliedIntervention(
      whoDidIt: whoDidIt.toAmplifyModel(),
      intervention: intervention.toAmplifyModel(),
    ));
  }
}
