import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/session/session_state.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';

import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  SessionCubit({
    required this.authRepo,
    required this.userRepo,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    final userId = await authRepo.attemptAutoLogin();
    if (userId != null) {
      emit(FullyAuthenticatedSessionState(userID: userId));
      //todo: differ when password is necessary
    } else {
      emit(RequiresAuthentificationSessionState());
    }
  }

  void showAuth() => emit(RequiresAuthentificationSessionState());

  void showSession(AuthCredentials credentials) async {
    try {
      if (credentials.userId != null) {
        //todo: check whether user requires
        emit(FullyAuthenticatedSessionState(userID: credentials.userId!));
      } else {
        emit(RequiresAuthentificationSessionState());
      }
    } catch (e) {
      emit(RequiresAuthentificationSessionState());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(RequiresAuthentificationSessionState());
  }
}
