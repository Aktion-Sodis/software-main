import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppEvent {}

class PerformSurveyEvent extends InAppEvent {
  final Survey survey;
  final AppliedIntervention appliedIntervention;

  PerformSurveyEvent({required this.survey, required this.appliedIntervention});
}

class MainViewEvent extends InAppEvent {}

class GoToUserPageEvent extends InAppEvent {}

class FinishAndSaveExecutedSurvey extends InAppEvent {
  final ExecutedSurvey executedSurvey;
  final AppliedIntervention appliedIntervention;

  FinishAndSaveExecutedSurvey(this.executedSurvey, this.appliedIntervention);
}
