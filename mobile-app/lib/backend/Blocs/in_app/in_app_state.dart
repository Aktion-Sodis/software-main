import 'package:flutter/foundation.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppState{}

class SurveyInAppState extends InAppState{
  final Survey survey;

  SurveyInAppState({required this.survey});

  SurveyInAppState copyWith({Survey? survey}){
    return SurveyInAppState(survey: survey ?? this.survey);
  }
}

class MainInAppState extends InAppState{}

class UserPageInAppState extends InAppState{}

