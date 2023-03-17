import 'package:flutter/material.dart';

class MyThemes{
  static const primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    dividerColor: Colors.black,
  );
}