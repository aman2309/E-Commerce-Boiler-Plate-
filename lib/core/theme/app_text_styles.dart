import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = AppConfig.fontFamily;

  // Headings
  static TextStyle h1({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.2,
      );

  static TextStyle h2({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 28,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.2,
      );

  static TextStyle h3({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.3,
      );

  // Titles
  static TextStyle t1({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle t2({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 18,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle t3({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.4,
      );

  // Body
  static TextStyle b1({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.5,
      );

  static TextStyle b2({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.5,
      );

  static TextStyle b3({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorConstants.textSecondaryLight,
        height: 1.5,
      );

  // Caption
  static TextStyle caption({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorConstants.textSecondaryLight,
        height: 1.4,
      );

  // Overline
  static TextStyle overline({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 10,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? ColorConstants.textSecondaryLight,
        height: 1.4,
        letterSpacing: 1.2,
      );

  // Label
  static TextStyle label({
    Color? color,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? ColorConstants.textPrimaryLight,
        height: 1.4,
      );

  // Dark theme text styles
  static TextStyle darkH1({Color? color, FontWeight? fontWeight}) =>
      h1(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkH2({Color? color, FontWeight? fontWeight}) =>
      h2(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkH3({Color? color, FontWeight? fontWeight}) =>
      h3(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkT1({Color? color, FontWeight? fontWeight}) =>
      t1(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkT2({Color? color, FontWeight? fontWeight}) =>
      t2(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkT3({Color? color, FontWeight? fontWeight}) =>
      t3(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkB1({Color? color, FontWeight? fontWeight}) =>
      b1(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkB2({Color? color, FontWeight? fontWeight}) =>
      b2(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  static TextStyle darkB3({Color? color, FontWeight? fontWeight}) =>
      b3(color: color ?? ColorConstants.textSecondaryDark, fontWeight: fontWeight);

  static TextStyle darkCaption({Color? color, FontWeight? fontWeight}) =>
      caption(color: color ?? ColorConstants.textSecondaryDark, fontWeight: fontWeight);

  static TextStyle darkOverline({Color? color, FontWeight? fontWeight}) =>
      overline(color: color ?? ColorConstants.textSecondaryDark, fontWeight: fontWeight);

  static TextStyle darkLabel({Color? color, FontWeight? fontWeight}) =>
      label(color: color ?? ColorConstants.textPrimaryDark, fontWeight: fontWeight);

  // Convenience getters that return default styles (for widget compatibility).
  static TextStyle get heading1 => h1();
  static TextStyle get heading2 => h2();
  static TextStyle get heading3 => h3();
  static TextStyle get title1 => t1();
  static TextStyle get title2 => t2();
  static TextStyle get title3 => t3();
  static TextStyle get bodyLarge => b1();
  static TextStyle get bodyMedium => b2();
  static TextStyle get bodySmall => b3();
  static TextStyle get labelLarge => label();
  static TextStyle get labelMedium => caption();
  static TextStyle get labelSmall => overline();

  static TextTheme get textTheme => const TextTheme(
        displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontFamily: _fontFamily, fontSize: 10, fontWeight: FontWeight.w500),
      );

  static TextTheme get darkTextTheme => const TextTheme(
        displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700, color: ColorConstants.textPrimaryDark),
        displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700, color: ColorConstants.textPrimaryDark),
        displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w600, color: ColorConstants.textPrimaryDark),
        headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w600, color: ColorConstants.textPrimaryDark),
        headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600, color: ColorConstants.textPrimaryDark),
        headlineSmall: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: ColorConstants.textPrimaryDark),
        titleLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: ColorConstants.textPrimaryDark),
        titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: ColorConstants.textPrimaryDark),
        titleSmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: ColorConstants.textPrimaryDark),
        bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400, color: ColorConstants.textPrimaryDark),
        bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.textPrimaryDark),
        bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: ColorConstants.textSecondaryDark),
        labelLarge: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: ColorConstants.textPrimaryDark),
        labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: ColorConstants.textPrimaryDark),
        labelSmall: TextStyle(fontFamily: _fontFamily, fontSize: 10, fontWeight: FontWeight.w500, color: ColorConstants.textSecondaryDark),
      );
}
