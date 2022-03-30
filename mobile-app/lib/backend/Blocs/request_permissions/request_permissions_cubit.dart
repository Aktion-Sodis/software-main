import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/backend/callableModels/localModels/required_permission.dart';
import 'package:permission_handler/permission_handler.dart';

part 'request_permissions_state.dart';

class RequestPermissionsCubit extends Cubit<RequestPermissionsState> {
  RequestPermissionsCubit() : super(RequestingPermissions());

  static final RequestPermissionsCubit instance = RequestPermissionsCubit();

  static final List<RequiredPermission> REQUIRED_PERMISSIONS = [
    RequiredPermission(
        name: "Camera",
        permission: Permission.camera,
        iconData: MdiIcons.cameraOutline),
    RequiredPermission(
        name: "Microphone",
        permission: Permission.microphone,
        iconData: MdiIcons.microphoneOutline),
    RequiredPermission(
        name: "Location",
        permission: Permission.location,
        iconData: MdiIcons.mapOutline),
  ];

  static Future<bool> areAllPermissionsAccepted() async {
    for (RequiredPermission requiredPermission in REQUIRED_PERMISSIONS) {
      if (!(await requiredPermission.permission.isGranted)) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  static Future<bool> areAnyPermissionsPermanentlyDenied() async {
    for (RequiredPermission requiredPermission in REQUIRED_PERMISSIONS) {
      if (await requiredPermission.permission.isPermanentlyDenied) {
        return Future.value(true);
      }
    }
    return Future.value(false);
  }

  Future<void> checkAllPermissions() async {
    var restrictedPermissions = state.restrictedPermissions.toList();
    var acceptedPermissions = state.acceptedPermissions.toList();
    bool haveToEmit = false;

    for (RequiredPermission requiredPermission in REQUIRED_PERMISSIONS) {
      //var limited = await requiredPermission.permission.isLimited;

      if (await requiredPermission.permission.isRestricted) {
        if (!restrictedPermissions.contains(requiredPermission)) {
          restrictedPermissions.add(requiredPermission);
          haveToEmit = true;
        }
      } else if (await requiredPermission.permission.isGranted) {
        if (!acceptedPermissions.contains(requiredPermission)) {
          acceptedPermissions.add(requiredPermission);
          haveToEmit = true;
        }
      }
    }

    if (haveToEmit) {
      emit(RequestingPermissions(
          acceptedPermissions: acceptedPermissions,
          restrictedPermissions: restrictedPermissions));
    }
  }

  Future<void> requestAllPermissions() async {
    if (await RequestPermissionsCubit.areAnyPermissionsPermanentlyDenied()) {
      emit(RequestingPermissionsWithDialog(
          restrictedPermissions: state.restrictedPermissions,
          acceptedPermissions: state.acceptedPermissions));
      return;
    }

    for (RequiredPermission requiredPermission
        in RequestPermissionsCubit.REQUIRED_PERMISSIONS) {
      if (!(await requiredPermission.permission.isGranted)) {
        var newPermission = await requiredPermission.permission.request();
        if (newPermission.isGranted) {
          emit(RequestingPermissions(
              restrictedPermissions: state.restrictedPermissions,
              acceptedPermissions: state.acceptedPermissions.toList()
                ..add(requiredPermission)));
        }
      }
    }

    if (await RequestPermissionsCubit.areAllPermissionsAccepted()) {
      emit(RequestedPermissionsAccepted(
          restrictedPermissions: state.restrictedPermissions,
          acceptedPermissions: state.acceptedPermissions));
    }
  }
}
