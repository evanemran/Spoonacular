import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.blueAccent.shade200;
  static const Color _lightPrimaryColor = Color(0xFF546E7A);
  static const Color _lightPrimaryVariantColor = Color(0xFF546E7A);
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color:_darkSecondaryColor,fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 26 ),
        color: _lightPrimaryVariantColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      ),
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        primaryVariant: _lightPrimaryVariantColor,
        secondary: _lightSecondaryColor,
        onPrimary: _lightOnPrimaryColor,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _lightTextTheme,
      dividerTheme: DividerThemeData(
          color: Colors.black12
      )

  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        primaryVariant: _darkPrimaryVariantColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: DividerThemeData(
          color: Colors.black
      )  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: titleText,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: titleText,
  );

  static final TextTheme titleTextTheme = TextTheme(
    headline1: titleText,
  );

  static final TextTheme subtitletitleTextTheme = TextTheme(
    headline1: subtitleText,
  );

  static final TextStyle titleText =
  TextStyle(fontSize: 26.0,fontWeight:FontWeight.bold, color: Colors.green,fontFamily: "Roboto");

  static final TextStyle titleTextDetail =
  TextStyle(fontSize: 26.0,fontWeight:FontWeight.bold, color: Colors.white,fontFamily: "Roboto");

  static final TextStyle subtitleText =
  TextStyle(fontSize: 18.0,fontWeight:FontWeight.normal, color: Colors.black,fontFamily: "Roboto");

  static final TextStyle subtitleTextDetail =
  TextStyle(fontSize: 18.0,fontWeight:FontWeight.normal, color: Colors.white,fontFamily: "Roboto");

}