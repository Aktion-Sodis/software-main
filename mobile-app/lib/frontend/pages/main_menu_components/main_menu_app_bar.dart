import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

Widget MainMenuAppBar(
    BuildContext context, VoidCallback voidCallback, String text,
    {bool? showBackButton}) {
  return Container(
    width: width(context),
    height: appBarHeight(context),
    child: Row(
      children: [
        //todo: add back button
        Expanded(
            child: Center(
                child: Container(
                    child: Text(text,
                        style: Theme.of(context).textTheme.subtitle1))))
      ],
    ),
  );
}
