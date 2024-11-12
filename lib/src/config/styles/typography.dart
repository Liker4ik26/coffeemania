import 'package:coffee_mania/src/config/styles/font_families.dart';
import 'package:flutter/material.dart';

enum AppTextStyle {
  interBold24(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interSemibold32(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w600,
      fontSize: 32,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interMedium16(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interRegular20(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w400,
      fontSize: 20,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interRegular14(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interRegular12(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  );

  final TextStyle value;

  const AppTextStyle(this.value);
}
