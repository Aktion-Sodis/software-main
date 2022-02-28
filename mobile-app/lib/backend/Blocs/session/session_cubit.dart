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
    try {
      final userId = await authRepo.attemptAutoLogin();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      User? user = await userRepo.getUserById(userId);

      /// Will require user to enter first and lastname if not created so far (unlikely when attempting auto login)
      if (user != null) {
        emit(AuthenticatedAndUserCreated(user: user));
      } else {
        emit(AuthenticatedAndNoUserCreated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials) async {
    try {
      if (credentials.userId == null) {
        emit(Unauthenticated());
      }

      User? user = await userRepo.getUserById(credentials.userId!);

      //todo: check here wether password has to be updated
      /// Will require user to enter first and lastname if not created so far
      if (user != null) {
        emit(AuthenticatedAndUserCreated(user: user));
      } else {
        emit(AuthenticatedAndNoUserCreated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
