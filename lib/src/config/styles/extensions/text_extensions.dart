import 'package:coffee_mania/src/config/styles/typography.dart';
import 'package:flutter/material.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  AppTextTheme.light({Color color = Colors.black})
      : interBold24 = AppTextStyle.interBold24.value.copyWith(color: color),
        interSemibold32 =
            AppTextStyle.interSemibold32.value.copyWith(color: color),
        interMedium16 = AppTextStyle.interMedium16.value.copyWith(color: color),
        interRegular20 =
            AppTextStyle.interRegular20.value.copyWith(color: color),
        interRegular14 =
            AppTextStyle.interRegular14.value.copyWith(color: color),
        interRegular12 =
            AppTextStyle.interRegular12.value.copyWith(color: color);

  AppTextTheme._({
    required this.interBold24,
    required this.interSemibold32,
    required this.interMedium16,
    required this.interRegular20,
    required this.interRegular14,
    required this.interRegular12,
  });

  AppTextTheme.base()
      : interBold24 = AppTextStyle.interBold24.value,
        interSemibold32 = AppTextStyle.interSemibold32.value,
        interMedium16 = AppTextStyle.interMedium16.value,
        interRegular20 = AppTextStyle.interRegular20.value,
        interRegular14 = AppTextStyle.interRegular14.value,
        interRegular12 = AppTextStyle.interRegular12.value;

  AppTextTheme.dark({Color color = Colors.white})
      : interBold24 = AppTextStyle.interBold24.value.copyWith(color: color),
        interSemibold32 =
            AppTextStyle.interSemibold32.value.copyWith(color: color),
        interMedium16 = AppTextStyle.interMedium16.value.copyWith(color: color),
        interRegular20 =
            AppTextStyle.interRegular20.value.copyWith(color: color),
        interRegular14 =
            AppTextStyle.interRegular14.value.copyWith(color: color),
        interRegular12 =
            AppTextStyle.interRegular12.value.copyWith(color: color);

  final TextStyle interBold24;

  final TextStyle interSemibold32;

  final TextStyle interMedium16;

  final TextStyle interRegular20;

  final TextStyle interRegular14;

  final TextStyle interRegular12;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      interBold24: TextStyle.lerp(interBold24, other.interBold24, t)!,
      interSemibold32:
          TextStyle.lerp(interSemibold32, other.interSemibold32, t)!,
      interMedium16: TextStyle.lerp(interMedium16, other.interMedium16, t)!,
      interRegular20: TextStyle.lerp(interRegular20, other.interRegular20, t)!,
      interRegular14: TextStyle.lerp(interRegular14, other.interRegular14, t)!,
      interRegular12: TextStyle.lerp(interRegular12, other.interRegular12, t)!,
    );
  }

  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ??
        _throwThemeExceptionFromFunc(context);
  }

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? bold24,
    TextStyle? medium24,
    TextStyle? medium20,
    TextStyle? bold32,
    TextStyle? medium16,
    TextStyle? medium12,
    TextStyle? regular20,
    TextStyle? regular14,
    TextStyle? medium14,
    TextStyle? semiBold20,
    TextStyle? semiBold12,
    TextStyle? semiBold32,
    TextStyle? regular12,
  }) {
    return AppTextTheme._(
      interBold24: bold24 ?? interBold24,
      interSemibold32: semiBold32 ?? interSemibold32,
      interMedium16: medium16 ?? interMedium16,
      interRegular20: regular20 ?? interRegular20,
      interRegular14: regular14 ?? interRegular14,
      interRegular12: regular12 ?? interRegular12,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextTheme не найдена в $context');
