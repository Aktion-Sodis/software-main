import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/request_permissions/request_permissions_cubit.dart';
import 'package:mobile_app/frontend/pages/request_permissions_page.dart';

class PermissionsChecker extends StatelessWidget with WidgetsBindingObserver {
  PermissionsChecker({Key? key, required this.child}) : super(key: key);

  final Widget child;

  late Function() _checkAllPermissions; // called on the start and on the resume
  late BuildContext context;

  Future<void> checkAndRequestPermissions() async {
    _checkAllPermissions();

    if (!await RequestPermissionsCubit.areAllPermissionsAccepted() &&
        !RequestPermissionsPage.opened) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RequestPermissionsPage()));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('[PermissionsChecker] lifecycle changed');
    if (state == AppLifecycleState.resumed) {
      print('[PermissionsChecker] lifecycle resumed');

      print('[PermissionsChecker] do checkAndRequestPermissions');
      checkAndRequestPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAllPermissions =
        BlocProvider.of<RequestPermissionsCubit>(context).checkAllPermissions;
    this.context = context;
    WidgetsBinding.instance!.addObserver(this);
    checkAndRequestPermissions();

    return child;
  }
}
