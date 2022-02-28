import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class AuthenticatedAndUserCreated extends SessionState {
  final User user;

  AuthenticatedAndUserCreated({required this.user});
}

class AuthenticatedAndNoUserCreated extends SessionState {}
