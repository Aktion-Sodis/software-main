import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';

abstract class SessionState {}

abstract class UnauthenticatedSessionState extends SessionState {}

class UnknownSessionState extends UnauthenticatedSessionState {}

class RequiresAuthentificationSessionState extends UnauthenticatedSessionState {
}

class AuthenticatedSessionState extends SessionState {
  String userID;

  AuthenticatedSessionState({required this.userID});
}

class FullyAuthenticatedSessionState extends AuthenticatedSessionState {
  FullyAuthenticatedSessionState({required String userID})
      : super(userID: userID);
}

class RequiresPasswordChangeSessionState extends SessionState {
  AuthCredentials authCredentials;
  RequiresPasswordChangeSessionState({required this.authCredentials});
}
