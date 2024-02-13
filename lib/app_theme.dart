import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Color(0xFF5D9CEC);
  static Color backgroundColorLight = Color(0xFFDFECDB);
  static Color backgroundColorDark = Color(0xFF060E1E);
  static Color greenColor = Color(0xFF61E757);
  static Color redColor = Color(0xFFEC4B4B);
  static Color blackColor = Color(0xFF141922);
  static Color greyColor = Color(0xFFC8C9CB);
  static Color whiteColor = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
  );
}
