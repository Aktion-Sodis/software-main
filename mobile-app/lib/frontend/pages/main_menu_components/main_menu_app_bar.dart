import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

import '../../common_widgets.dart';

Widget MainMenuAppBar(
    BuildContext context, VoidCallback voidCallback, String text,
    {bool showBackButton = false}) {
  return Container(
      width: width(context),
      height: appBarHeight(context),
      child: Column(children: [
        Expanded(
            child: Row(
          children: [
            if (showBackButton)
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: defaultPadding(context)),
                  child: CommonWidgets.defaultBackwardButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding(context)),
                      context: context,
                      goBack: () => Navigator.of(context).pop())),
            Expanded(
                child: Row(
                    mainAxisAlignment: showBackButton
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                  Container(
                      child: Text(text,
                          style: Theme.of(context).textTheme.headline2))
                ]))
          ],
        )),
        Container(height: 1, width: width(context), color: Colors.grey)
      ]));
}
