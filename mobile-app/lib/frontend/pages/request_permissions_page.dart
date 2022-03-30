import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/request_permissions/request_permissions_cubit.dart';
import 'package:mobile_app/frontend/components/nisaba_app_bar.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

void mackeSureAccepringPermissions() {}

class RequestPermissionsPage extends StatelessWidget {
  RequestPermissionsPage({Key? key}) : super(key: key) {
    RequestPermissionsPage.opened = true;
  }

  static bool opened = false;

  void closePage(BuildContext context) {
    RequestPermissionsPage.opened = false;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: BlocConsumer<RequestPermissionsCubit, RequestPermissionsState>(
        bloc: RequestPermissionsCubit.instance,
        listener: (context, state) {
          if (state is RequestingPermissionsWithDialog) {
            showDialog(
                context: context,
                builder: (context) => Center(
                        child: Padding(
                      padding: EdgeInsets.all(defaultPadding(context)),
                      child: Wrap(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding(context),
                                  vertical: defaultPadding(context)),
                              child: Wrap(children: [
                                Column(
                                  children: [
                                    Text(
                                        strings.restricted_permissions_warning),
                                    SizedBox(
                                      height: defaultPadding(context),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ThemeColors.green)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          openAppSettings();
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            strings.open_settings,
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    SizedBox(
                                      height: defaultPadding(context),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ThemeColors.mobster)),
                                        onPressed: () => Navigator.pop(context),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            strings.abbrechen,
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    )));
          }
          if (state is RequestedPermissionsAccepted) {
            closePage(context);
          }
        },
        builder: ((context, state) {
          return Material(
            child: ListView(
              padding: MediaQuery.of(context).padding.copyWith(
                    left: MediaQuery.of(context).padding.left +
                        defaultPadding(context),
                    right: MediaQuery.of(context).padding.right +
                        defaultPadding(context),
                  ),
              children: [
                NisabaAppBar(
                  title: strings.accept_permissions,
                  showBackButton: false,
                ),
                Wrap(
                  children: [
                    Column(
                      children: RequestPermissionsCubit.REQUIRED_PERMISSIONS
                          .map((e) => ListTile(
                                leading: Icon(e.iconData),
                                title: Text(e.name),
                                subtitle: state.acceptedPermissions.contains(e)
                                    ? Text(strings.accepted)
                                    : (state.restrictedPermissions.contains(e)
                                        ? Text(
                                            strings.restricted,
                                            style: const TextStyle(
                                                color: ThemeColors.red),
                                          )
                                        : Text(
                                            strings.required,
                                            style: state.acceptedPermissions
                                                    .isNotEmpty
                                                ? const TextStyle(
                                                    color: ThemeColors.red)
                                                : null,
                                          )),
                              ))
                          .toList(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColors.green),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(18)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ))),
                    onPressed:
                        RequestPermissionsCubit.instance.requestAllPermissions,
                    child: Text(strings.accept_all_permissions))
              ],
            ),
          );
        }),
      ),
    );
  }
}
