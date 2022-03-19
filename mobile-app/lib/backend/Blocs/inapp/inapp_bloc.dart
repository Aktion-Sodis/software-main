import 'package:flutter_bloc/flutter_bloc.dart';

import 'inapp_event.dart';
import 'inapp_state.dart';

class InAppBloc extends Bloc<InAppEvent, InAppState> {
  //todo: add task repository

  InAppBloc() : super(InAppState(currentArea: CurrentArea.MAIN_MENU)) {
    on<InAppEvent>(_mapEventToState);
  }

  void _mapEventToState(InAppEvent event, Emitter<InAppState> emit) async {
    //todo: implement
  }
}

class InAppMenuState {}
