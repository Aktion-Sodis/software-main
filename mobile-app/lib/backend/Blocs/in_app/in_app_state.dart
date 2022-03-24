import 'package:flutter/foundation.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppState {}

class SurveyInAppState extends InAppState {
  final Survey survey;
  final AppliedIntervention appliedIntervention;

  SurveyInAppState({required this.survey, required this.appliedIntervention});

  SurveyInAppState copyWith(
      {Survey? survey, AppliedIntervention? appliedIntervention}) {
    return SurveyInAppState(
        survey: survey ?? this.survey,
        appliedIntervention: appliedIntervention ?? this.appliedIntervention);
  }
}

class MainInAppState extends InAppState {}

class UserPageInAppState extends InAppState {}
