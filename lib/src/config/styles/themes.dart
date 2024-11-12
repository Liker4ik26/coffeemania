import 'package:coffee_mania/src/config/styles/extensions/extensions.dart';
import 'package:coffee_mania/src/config/styles/extensions/text_extensions.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  const AppThemes._();

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: [
      _darkThemeColors,
      _darkTextTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    indicatorColor: _darkThemeColors.primaryColor,
  );

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    extensions: [
      _lightThemeColors,
      _lightTextTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    indicatorColor: _lightThemeColors.primaryColor,
  );

  static const _lightThemeColors = ThemeColors.light();
  static const _darkThemeColors = ThemeColors.dark();
  static final _lightTextTheme = AppTextTheme.light();
  static final _darkTextTheme = AppTextTheme.dark();
}
