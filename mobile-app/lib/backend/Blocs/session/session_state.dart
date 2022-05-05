import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

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
  User? user;
  FullyAuthenticatedSessionState({required String userID, this.user})
      : super(userID: userID);
}

class RequiresPasswordChangeSessionState extends SessionState {
  AuthCredentials authCredentials;
  RequiresPasswordChangeSessionState({required this.authCredentials});
}
