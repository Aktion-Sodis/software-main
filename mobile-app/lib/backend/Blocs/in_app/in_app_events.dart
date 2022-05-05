import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppEvent {}

class PerformSurveyEvent extends InAppEvent {
  final Survey survey;
  final AppliedIntervention appliedIntervention;
  final Entity entity;

  PerformSurveyEvent(
      {required this.survey,
      required this.appliedIntervention,
      required this.entity});
}

class MainViewEvent extends InAppEvent {}

class GoToUserPageEvent extends InAppEvent {}

class FinishAndSaveExecutedSurvey extends InAppEvent {
  final ExecutedSurvey executedSurvey;
  final AppliedIntervention appliedIntervention;
  final Entity entity;
  final OrganizationViewBloc organizationViewBloc;

  FinishAndSaveExecutedSurvey(this.executedSurvey, this.appliedIntervention,
      this.entity, this.organizationViewBloc);
}
