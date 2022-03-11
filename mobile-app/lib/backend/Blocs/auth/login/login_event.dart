abstract class LoginEvent {}

class LoginEmailOrPhoneNumberChanged extends LoginEvent {
  final String emailOrPhoneNumber;
  LoginEmailOrPhoneNumberChanged({required this.emailOrPhoneNumber});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

class GoogleLogin extends LoginEvent {}
