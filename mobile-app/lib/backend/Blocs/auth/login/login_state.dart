import 'package:mobile_app/backend/Blocs/auth/form_submission_status.dart';

class LoginState {
  final String emailOrPhoneNumber;
  bool get emailOrPhoneNotEmpty => emailOrPhoneNumber.isNotEmpty;
  bool get isValidUsername => isPhoneNumber ? isValidPhoneNumber : isValidEmail;
  bool get isPhoneNumber =>
      emailOrPhoneNumber.contains("+") && (!emailOrPhoneNumber.contains("@"));
  bool get isValidPhoneNumber =>
      emailOrPhoneNumber.startsWith("+") && emailOrPhoneNumber.length >= 6;
  bool get isValidEmail =>
      (emailOrPhoneNumber.contains("@") && emailOrPhoneNumber.contains(".")) &&
      emailOrPhoneNumber.length >= 4;

  final String password;
  bool get passwordNotEmpty => password.isNotEmpty;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.emailOrPhoneNumber = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? emailOrPhoneNumber,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      emailOrPhoneNumber: emailOrPhoneNumber ?? this.emailOrPhoneNumber,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
