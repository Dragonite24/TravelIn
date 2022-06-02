import 'package:flutter/material.dart';
import 'package:travel_in/constants.dart';

enum AppTheme {
  RedLight,
  RedDark,
  BlueLight,
  BlueDark,
}

final appThemeData = {
  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: CColors.red,
    appBarTheme: AppBarTheme(
      backgroundColor: CColors.red.withOpacity(0.5),
    ),
  ),
  AppTheme.RedDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: CColors.red,
  ),
  AppTheme.BlueLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: CColors.red,
  ),
  AppTheme.BlueDark: ThemeData(
    brightness: Brightness.dark,
    bottomAppBarColor: CColors.dark_grey,
    primaryColor: CColors.red,
  ),
};
