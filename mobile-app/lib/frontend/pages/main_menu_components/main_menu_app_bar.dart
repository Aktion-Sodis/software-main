import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

Widget MainMenuAppBar(
    BuildContext context, VoidCallback voidCallback, String text,
    {bool? showBackButton}) {
  return Container(
      width: width(context),
      height: appBarHeight(context),
      child: Column(children: [
        Expanded(
            child: Row(
          children: [
            //todo: add back button
            Expanded(
                child: Center(
                    child: Container(
                        child: Text(text,
                            style: Theme.of(context).textTheme.headline2))))
          ],
        )),
        Container(height: 1, width: width(context), color: Colors.grey)
      ]));
}
