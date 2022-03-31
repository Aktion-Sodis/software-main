import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// This class descripes permissions, which the device need to use some functions
class RequiredPermission {
  final String name;
  final Permission permission;
  final IconData iconData;

  RequiredPermission(
      {required this.name, required this.permission, required this.iconData});
}
