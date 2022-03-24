import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/User.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedIntervention {
  String? id;
  late User whoDidIt;
  late Intervention intervention;
  Location? location;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<ExecutedSurvey> executedSurveys;
  late bool working;

  AppliedIntervention(
      {this.id,
      required this.whoDidIt,
      required this.intervention,
      this.location,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      required this.executedSurveys,
      required this.working});

  AppliedIntervention.fromAmplifyModel(
      amp.AppliedIntervention appliedIntervention) {
    id = appliedIntervention.id;
    whoDidIt = User.fromAmplifyModel(appliedIntervention.whoDidIt);
    intervention =
        Intervention.fromAmplifyModel(appliedIntervention.intervention);
    location = appliedIntervention.location == null
        ? null
        : Location.fromAmplifyModel(appliedIntervention.location!);
    schemeVersion = appliedIntervention.schemeVersion;
    executedSurveys = List.generate(
        appliedIntervention.executedSurveys.length,
        (index) => ExecutedSurvey.fromAmplifyModel(
            appliedIntervention.executedSurveys[index]));
    working = true;
  }

  amp.AppliedIntervention toAmplifyModel() {
    return (amp.AppliedIntervention(
        id: id,
        whoDidIt: whoDidIt.toAmplifyModel(),
        intervention: intervention.toAmplifyModel(),
        location: location?.toAmplifyModel(),
        schemeVersion: schemeVersion,
        executedSurveys: List.generate(executedSurveys.length,
            (index) => executedSurveys[index].toAmplifyModel()),
        appliedInterventionInterventionId: intervention.id!,
        appliedInterventionWhoDidItId: whoDidIt.id!));
  }

  //todo: integrate working boolean
}
