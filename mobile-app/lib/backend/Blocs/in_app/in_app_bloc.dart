import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_state.dart';

class InAppBloc extends Bloc<InAppEvent, InAppState>{
  InAppBloc():super(MainInAppState()){
    {
      on<InAppEvent>(_mapEventToState);
    }
  }

  void _mapEventToState(InAppEvent event, Emitter<InAppState> emit) async{
    if(event is PerformSurveyEvent){
      emit(SurveyInAppState(survey: event.survey));
    }else if(event is MainViewEvent){
      emit(MainInAppState());
    }else if(event is GoToUserPageEvent){
      emit(UserPageInAppState());
    }
  }
}