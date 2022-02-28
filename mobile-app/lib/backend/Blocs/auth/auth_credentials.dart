// Container holding user attributes

class AuthCredentials {
  String? userId;
  final String userName;
  final String password;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  String getFirstName() => firstName ?? userName.split(" ")[0];
  String getLastName() => lastName ?? userName.split(" ")[-1];
  
  AuthCredentials({
    this.userId,
    required this.userName,
    required this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });
}