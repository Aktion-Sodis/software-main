import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppEvent{}

class PerformSurveyEvent extends InAppEvent{
  final Survey survey;

  PerformSurveyEvent({required this.survey});
}

class MainViewEvent extends InAppEvent{}

class GoToUserPageEvent extends InAppEvent{}
