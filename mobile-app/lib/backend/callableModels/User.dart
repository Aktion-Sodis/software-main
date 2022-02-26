import 'package:mobile_app/backend/callableModels/Permission.dart';

class User {
  String id;
  String? firstName;
  String? lastName;
  String? bio;
  List<Permission>? permissions;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  User(
      {required this.id,
      this.firstName,
      this.lastName,
      this.bio,
      this.permissions,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
