import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle getSystemUiOverlayStyle(
    ThemeData themeData, bool hasBottomNavigation) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        themeData.colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
    systemNavigationBarColor: hasBottomNavigation
        ? ElevationOverlay.applySurfaceTint(
            themeData.colorScheme.surface,
            themeData.colorScheme.surfaceTint,
            3,
          )
        : themeData.colorScheme.background,
    systemNavigationBarIconBrightness:
        themeData.colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
  );
}
