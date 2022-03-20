import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget CustomIconButton(
    VoidCallback onPressed, IconData iconData, Size size, bool pressable,
    {EdgeInsets? padding}) {
  return MaterialButton(
      height: pressable ? 10 : 0,
      onPressed: onPressed,
      padding: padding,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            border: Border.all(color: Colors.black45, width: 1)),
        child: Icon(iconData,
            color: Colors.black87, size: min(size.width, size.height) * .6),
      ));
}
