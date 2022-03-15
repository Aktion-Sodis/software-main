import 'package:flutter/material.dart';

Future<ThemeData> getThemeData() async {
  return ThemeData(
      primaryColor: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blue, fontSize: 12),
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

class ThemeColors {
  static const Color black = Colors.black;
  static const Color yellow = Color.fromARGB(255, 255, 236, 69);
  static const Color green = Color.fromARGB(255, 75, 185, 126);
  static const Color darkGrey = Color.fromARGB(255, 72, 70, 73);
  static const Color red = Color.fromARGB(255, 219, 79, 71);
  static const Color mobster = Color.fromARGB(
      255, 120, 117, 121); // actually, light grey with purple tones

}

BoxShadow defaultShadow = BoxShadow(
  color: Colors.black.withOpacity(0.15),
  spreadRadius: 1,
  blurRadius: 2,
  offset: const Offset(0, 0), // changes position of shadow
);
