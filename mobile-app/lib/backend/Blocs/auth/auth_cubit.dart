import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';

enum AuthState { login }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
