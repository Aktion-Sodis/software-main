import 'package:flutter/material.dart';

width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

defaultPadding(BuildContext context) => width(context) * .04;

appBarHeight(BuildContext context) => height(context) * .1;
