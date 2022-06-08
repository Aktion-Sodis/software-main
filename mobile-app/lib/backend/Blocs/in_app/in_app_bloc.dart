import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_state.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_events.dart';
import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/repositories/ExecutedSurveyRepository.dart';
import 'package:mobile_app/services/gps.dart';

class InAppBloc extends Bloc<InAppEvent, InAppState> {
  InAppBloc() : super(MainInAppState()) {
    {
      on<InAppEvent>(_mapEventToState);
    }
  }

  void _mapEventToState(InAppEvent event, Emitter<InAppState> emit) async {
    if (event is PerformSurveyEvent) {
      emit(SurveyInAppState(
          survey: event.survey,
          appliedIntervention: event.appliedIntervention,
          entity: event.entity));
    } else if (event is MainViewEvent) {
      emit(MainInAppState());
    } else if (event is GoToUserPageEvent) {
      emit(UserPageInAppState());
    } else if (event is FinishAndSaveExecutedSurvey) {
      ExecutedSurvey toSave = event.executedSurvey;
      toSave.appliedIntervention = event.appliedIntervention;
      try {
        toSave.location = Location.fromPosition(await GPS.getCurrentPosition());
      } catch (e) {
        // Probably: LocationServiceDisabledException or TimeoutException
      }
      await ExecutedSurveyRepository.saveExecutedSurvey(toSave);

      print("executed survey saved");
      event.organizationViewBloc.add(AddExecutedSurvey(
          event.entity, event.appliedIntervention, event.executedSurvey));
      emit(MainInAppState());
    }
  }
}
