import 'package:flutter/material.dart';

import './shape.dart';

ThemeData lightThemeData(Color colorSchemeSeed) {
  return ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: false),
    brightness: Brightness.light,
    // colorSchemeSeed: colorSchemeSeed,
    useMaterial3: true,
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: Shape.shapeRoundedLarge,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  );
}

ThemeData darkThemeData(Color colorSchemeSeed) {
  return ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: false),
    brightness: Brightness.dark,
    colorSchemeSeed: colorSchemeSeed,
    dividerTheme: const DividerThemeData(color: Colors.white38, space: 8),
    useMaterial3: true,
    fontFamily: 'Lato',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: Shape.shapeRoundedLarge,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      contentTextStyle: const TextStyle(color: Colors.black),
      shape: Shape.shapeRoundedLarge,
    ),
  );
}
