import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Permission {
  late PermissionType permissionType;
  late List<String> allowedEntities;

  Permission({required this.permissionType, required this.allowedEntities});

  Permission.fromAmplifyModel(amp.Permission permission) {
    permissionType =
        permissionTypeFromAmplifyPermissionType(permission.permissionType);
    allowedEntities = permission.allowedEntities;
  }

  amp.Permission toAmplifyModel() {
    return (amp.Permission(
        allowedEntities: allowedEntities,
        permissionType:
            amplifyPermissionTypeFromPermissionType(permissionType)));
  }
}

enum PermissionType {
  READ,
  CHANGEMASTERDATA,
  CREATEINTERVENTIONS,
  EXECUTESURVEYS,
  CREATESUBENTITIES,
  ADMIN
}

PermissionType permissionTypeFromAmplifyPermissionType(
    amp.PermissionType permissionType) {
  switch (permissionType) {
    case amp.PermissionType.READ:
      return PermissionType.READ;
      break;
    case amp.PermissionType.CHANGEMASTERDATA:
      return PermissionType.CHANGEMASTERDATA;
      break;
    case amp.PermissionType.CREATEINTERVENTIONS:
      return PermissionType.CREATEINTERVENTIONS;
      break;
    case amp.PermissionType.EXECUTESURVEYS:
      return PermissionType.EXECUTESURVEYS;
      break;
    case amp.PermissionType.CREATESUBENTITIES:
      return PermissionType.CREATESUBENTITIES;
      break;
    case amp.PermissionType.ADMIN:
      return PermissionType.ADMIN;
      break;
  }
}

amp.PermissionType amplifyPermissionTypeFromPermissionType(
    PermissionType permissionType) {
  switch (permissionType) {
    case PermissionType.READ:
      return amp.PermissionType.READ;
      break;
    case PermissionType.CHANGEMASTERDATA:
      return amp.PermissionType.CHANGEMASTERDATA;
      break;
    case PermissionType.CREATEINTERVENTIONS:
      return amp.PermissionType.CREATEINTERVENTIONS;
      break;
    case PermissionType.EXECUTESURVEYS:
      return amp.PermissionType.EXECUTESURVEYS;
      break;
    case PermissionType.CREATESUBENTITIES:
      return amp.PermissionType.CREATESUBENTITIES;
      break;
    case PermissionType.ADMIN:
      return amp.PermissionType.ADMIN;
      break;
  }
}
