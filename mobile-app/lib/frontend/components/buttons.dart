import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

Widget CustomIconButton(
    VoidCallback onPressed, IconData iconData, Size size, bool pressable,
    {EdgeInsets? padding,
    bool selected = false,
    Color selectedColor = Colors.green,
    Color onSelectedColor = Colors.white}) {
  return MaterialButton(
      height: pressable ? 5 : 0,
      onPressed: onPressed,
      padding: padding,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: selected ? selectedColor : Colors.white,
            border: Border.all(color: Colors.black45, width: 1)),
        child: Icon(iconData,
            color: selected ? onSelectedColor : Colors.black87,
            size: min(size.width, size.height) * .6),
      ));
}

Widget defaultGreenButton(BuildContext context, VoidCallback onPressed,
        {double? minWidth, double? minHeight, String? text, IconData? icon}) =>
    ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          minimumSize: MaterialStateProperty.all(Size(
              minWidth ?? width(context) * .3,
              minHeight ?? width(context) * .12)),
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary), //todo: change
        ),
        onPressed: onPressed,
        child: Center(
            child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
              if (icon != null)
                Icon(icon,
                    size: width(context) * .1,
                    color: Theme.of(context).colorScheme.onSecondary),
              if (text != null)
                Container(
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onSecondary)))
            ]))));
