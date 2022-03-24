import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

abstract class CommonWidgets {
  static Widget defaultBackwardButton(
      {required BuildContext context,
      Function? goBack,
      ButtonSizes buttonSizes = ButtonSizes.medium}) {
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.zero,
      color: Theme.of(context).canvasColor,
      onPressed: () {
        goBack?.call();
      },
      shape: CircleBorder(
          side: BorderSide(
              color: Theme.of(context).buttonTheme.colorScheme?.background ??
                  Colors.green,
              width: 1)),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding(context)),
        child: Icon(
          MdiIcons.arrowLeft,
          color: Theme.of(context).buttonTheme.colorScheme?.background ??
              Colors.green,
        ),
      ),
    );
  }

  static Widget defaultForwardButton(
      {required BuildContext context,
      Function? proceed,
      ButtonSizes buttonSizes = ButtonSizes.medium}) {
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.zero,
      color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: () {
        proceed?.call();
      },
      shape: CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding(context) *
            (buttonSizes == ButtonSizes.small ? 0.5 : 1)),
        child: Icon(
          MdiIcons.arrowRight,
          color: Colors.white,
          size: Theme.of(context).iconTheme.size == null
              ? null
              : Theme.of(context).iconTheme.size! *
                  (buttonSizes == ButtonSizes.small
                      ? 0.75
                      : buttonSizes == ButtonSizes.large
                          ? 1.5
                          : 1),
        ),
      ),
    );
  }

  static Widget defaultIconButton(
      {required BuildContext context,
      VoidCallback? onPressed,
      ButtonSizes buttonSizes = ButtonSizes.medium,
      bool filled = true,
      required IconData iconData,
      Color? fillColor,
      Color? borderColor}) {
    return MaterialButton(
      minWidth: 0,
      color: fillColor ??
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: onPressed ?? () {},
      shape: CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding(context) *
            (buttonSizes == ButtonSizes.small ? 0.5 : 1)),
        child: Icon(
          iconData,
          color: Colors.white,
          size: Theme.of(context).iconTheme.size == null
              ? null
              : Theme.of(context).iconTheme.size! *
                  (buttonSizes == ButtonSizes.small
                      ? 0.75
                      : buttonSizes == ButtonSizes.large
                          ? 1.5
                          : 1),
        ),
      ),
    );
  }

  static Widget defaultDismissButton(
      {required BuildContext context,
      Function? dismiss,
      ButtonSizes buttonSizes = ButtonSizes.small}) {
    return MaterialButton(
      minWidth: 0,
      color: Colors.red,
      onPressed: () {
        dismiss?.call();
      },
      shape: CircleBorder(),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding(context) *
            (buttonSizes == ButtonSizes.small ? 0.5 : 1)),
        child: Icon(
          MdiIcons.close,
          color: Colors.white,
          size: Theme.of(context).iconTheme.size == null
              ? null
              : Theme.of(context).iconTheme.size! *
                  (buttonSizes == ButtonSizes.small
                      ? 0.75
                      : buttonSizes == ButtonSizes.large
                          ? 1.5
                          : 1),
        ),
      ),
    );
  }
}

enum ButtonSizes {
  small,
  medium,
  large,
}
