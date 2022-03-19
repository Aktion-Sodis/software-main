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
      User? user = await userRepo.getUserById(userId);
      emit(FullyAuthenticatedSessionState(userID: userId, user: user));
      //todo: differ when password is necessary
    } else {
      emit(RequiresAuthentificationSessionState());
    }
  }

  void showAuth() => emit(RequiresAuthentificationSessionState());

  void showSession(AuthCredentials credentials) async {
    try {
      print("showSession called: ${credentials.userId}");
      if (credentials.userId == null) {
        print("popping requires authentification");
        emit(RequiresAuthentificationSessionState());
      } else if (credentials.userId == "CONFIRM_SIGN_IN_WITH_NEW_PASSWORD") {
        print("popping requires password state");
        emit(RequiresPasswordChangeSessionState(authCredentials: credentials));
      } else {
        print("popping fully quthenticated state");
        emit(FullyAuthenticatedSessionState(userID: credentials.userId!));
      }
    } catch (e) {
      print("error in showing Session");
      print(e.toString());
      emit(RequiresAuthentificationSessionState());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(RequiresAuthentificationSessionState());
  }
}
