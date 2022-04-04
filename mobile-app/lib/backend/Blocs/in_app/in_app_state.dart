import 'package:flutter/foundation.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class InAppState {}

class SurveyInAppState extends InAppState {
  final Survey survey;
  final AppliedIntervention appliedIntervention;
  final Entity entity;

  SurveyInAppState(
      {required this.survey,
      required this.appliedIntervention,
      required this.entity});

  SurveyInAppState copyWith(
      {Survey? survey,
      AppliedIntervention? appliedIntervention,
      Entity? entity}) {
    return SurveyInAppState(
        survey: survey ?? this.survey,
        appliedIntervention: appliedIntervention ?? this.appliedIntervention,
        entity: entity ?? this.entity);
  }
}

class MainInAppState extends InAppState {}

class UserPageInAppState extends InAppState {}
