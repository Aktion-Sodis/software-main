import 'package:flutter/material.dart';

Future<ThemeData> getThemeData() async {
  return ThemeData(
      primaryColor: Colors.blue,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      buttonTheme: ButtonThemeData(height: 4),
      textTheme: TextTheme(
          overline: TextStyle(color: Colors.black87),
          headline1: TextStyle(color: Colors.blue),
          headline2: TextStyle(color: Colors.black87)),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
          floatingLabelStyle: TextStyle(color: Colors.blue, fontSize: 18),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIconColor: Colors.grey));
}
