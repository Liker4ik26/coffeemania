import 'package:coffee_mania/src/config/styles/colors.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors._({
    required this.primaryColor,
    required this.backgroundPrimaryColor,
    required this.backgroundSecondaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  const ThemeColors.light()
      : primaryColor = Colors.black,
        backgroundPrimaryColor = AppColors.mintCream,
        backgroundSecondaryColor = Colors.white,
        secondaryColor = Colors.white,
        accentColor = AppColors.darkSkyBlue;

  const ThemeColors.dark()
      : primaryColor = Colors.white,
        backgroundPrimaryColor = AppColors.chineseBlack,
        backgroundSecondaryColor = AppColors.raisinBlack,
        secondaryColor = Colors.white,
        accentColor = AppColors.darkSkyBlue;

  static ThemeColors of(BuildContext context) =>
      Theme.of(context).extension<ThemeColors>()!;

  final Color primaryColor;
  final Color backgroundPrimaryColor;
  final Color backgroundSecondaryColor;
  final Color secondaryColor;
  final Color accentColor;

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? primaryColor,
    Color? backgroundPrimaryColor,
    Color? backgroundSecondaryColor,
    Color? secondaryColor,
    Color? accentColor,
  }) {
    return ThemeColors._(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundPrimaryColor:
          backgroundPrimaryColor ?? this.backgroundPrimaryColor,
      backgroundSecondaryColor:
          backgroundSecondaryColor ?? this.backgroundSecondaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    covariant ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors._(
      primaryColor: Color.lerp(
        primaryColor,
        other.primaryColor,
        t,
      )!,
      backgroundPrimaryColor: Color.lerp(
        backgroundPrimaryColor,
        other.backgroundPrimaryColor,
        t,
      )!,
      backgroundSecondaryColor: Color.lerp(
        backgroundSecondaryColor,
        other.backgroundSecondaryColor,
        t,
      )!,
      secondaryColor: Color.lerp(
        secondaryColor,
        other.secondaryColor,
        t,
      )!,
      accentColor: Color.lerp(
        accentColor,
        other.accentColor,
        t,
      )!,
    );
  }
}
