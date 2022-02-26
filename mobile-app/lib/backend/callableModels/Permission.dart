class Permission {
  PermissionType? permissionType;
  List<String>? allowedEntities;

  Permission({this.permissionType, this.allowedEntities});
}

enum PermissionType {
  READ,
  CHANGEMASTERDATA,
  CREATEINTERVENTIONS,
  EXECUTESURVEYS,
  CREATESUBENTITIES,
  ADMIN
}
