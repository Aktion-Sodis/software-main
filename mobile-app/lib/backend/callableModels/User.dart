import 'package:mobile_app/backend/callableModels/Permission.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class User {
  String? id;
  late String firstName;
  late String lastName;
  String? bio;
  late List<Permission> permissions;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.bio,
      required this.permissions,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  User.fromAmplifyModel(amp.User user) {
    id = user.id;
    firstName = user.firstName;
    lastName = user.lastName;
    bio = user.bio;
    permissions = List.generate(user.permissions.length,
        (index) => Permission.fromAmplifyModel(user.permissions[index]));
    schemeVersion = user.schemeVersion;
    createdAt = user.createdAt?.getDateTimeInUtc();
    updatedAt = user.updatedAt?.getDateTimeInUtc();
  }

  amp.User toAmplifyModel() {
    return (amp.User(
      firstName: firstName,
      lastName: lastName,
      permissions: List.generate(
          permissions.length, (index) => permissions[index].toAmplifyModel()),
      bio: bio,
      schemeVersion: schemeVersion,
      id: id,
    ));
  }
}
