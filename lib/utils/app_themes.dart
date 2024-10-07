import 'package:flutter/material.dart';
import 'package:sen/utils/app_colors.dart';

abstract class AppThemes{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}