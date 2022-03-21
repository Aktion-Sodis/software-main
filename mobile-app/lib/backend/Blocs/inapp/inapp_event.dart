import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppEvent {}

class GoToUserPageEvent extends InAppEvent {}

class StartSurveyEvent extends InAppEvent {
  Survey survey;
  AppliedIntervention appliedIntervention;

  StartSurveyEvent(this.survey, this.appliedIntervention);
}
