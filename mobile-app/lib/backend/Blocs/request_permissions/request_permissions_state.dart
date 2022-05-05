part of 'request_permissions_cubit.dart';

@immutable
abstract class RequestPermissionsState {
  final List<RequiredPermission> acceptedPermissions;
  final List<RequiredPermission> restrictedPermissions;

  const RequestPermissionsState({
    required this.acceptedPermissions,
    required this.restrictedPermissions,
  });
}

class RequestingPermissions extends RequestPermissionsState {
  const RequestingPermissions(
      {List<RequiredPermission> acceptedPermissions = const [],
      List<RequiredPermission> restrictedPermissions = const []})
      : super(
            acceptedPermissions: acceptedPermissions,
            restrictedPermissions: restrictedPermissions);
}

class RequestingPermissionsWithDialog extends RequestingPermissions {
  const RequestingPermissionsWithDialog(
      {List<RequiredPermission> acceptedPermissions = const [],
      List<RequiredPermission> restrictedPermissions = const []})
      : super(
            acceptedPermissions: acceptedPermissions,
            restrictedPermissions: restrictedPermissions);
}

class RequestedPermissionsAccepted extends RequestPermissionsState {
  const RequestedPermissionsAccepted(
      {List<RequiredPermission> acceptedPermissions = const [],
      List<RequiredPermission> restrictedPermissions = const []})
      : super(
            acceptedPermissions: acceptedPermissions,
            restrictedPermissions: restrictedPermissions);
}
