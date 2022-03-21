import 'package:flutter/material.dart';

Future<ThemeData> getThemeData() async {
  return ThemeData(
      primaryColor: Colors.blue,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      buttonTheme: const ButtonThemeData(height: 4),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(color: Colors.green),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true),
      textTheme: const TextTheme(
          overline: TextStyle(color: Colors.black87),
          headline1: TextStyle(color: Colors.blue),
          headline2: TextStyle(color: Colors.black87),
          bodyText1: TextStyle(
        fontSize: 25,
      )),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
          floatingLabelStyle: TextStyle(color: Colors.blue, fontSize: 18),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIconColor: Colors.grey),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),
    iconTheme: const IconThemeData(
      size: 25,
    ),
  );
}
