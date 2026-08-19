import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppConfig.primaryColor,
      brightness: Brightness.light,
      primary: AppConfig.primaryColor,
      secondary: AppConfig.secondaryColor,
      surface: ColorConstants.white,
      error: ColorConstants.error,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConfig.fontFamily,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundLight,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _lightCardTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      dividerTheme: DividerThemeData(
        color: ColorConstants.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppConfig.primaryColor,
      brightness: Brightness.dark,
      primary: AppConfig.primaryColor,
      secondary: AppConfig.secondaryColor,
      surface: ColorConstants.cardDark,
      error: ColorConstants.error,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConfig.fontFamily,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundDark,
      textTheme: AppTextStyles.darkTextTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      dividerTheme: DividerThemeData(
        color: ColorConstants.grey700,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: ColorConstants.white,
    foregroundColor: ColorConstants.textPrimaryLight,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      fontFamily: AppConfig.fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorConstants.textPrimaryLight,
    ),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: ColorConstants.cardDark,
    foregroundColor: ColorConstants.textPrimaryDark,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(
      fontFamily: AppConfig.fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorConstants.textPrimaryDark,
    ),
  );

  static final CardThemeData _lightCardTheme = CardThemeData(
    elevation: 1,
    color: ColorConstants.cardLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static final CardThemeData _darkCardTheme = CardThemeData(
    elevation: 1,
    color: ColorConstants.cardDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static final ElevatedButtonThemeData _lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppConfig.primaryColor,
      foregroundColor: ColorConstants.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: AppConfig.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final ElevatedButtonThemeData _darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppConfig.primaryColor,
      foregroundColor: ColorConstants.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: AppConfig.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final OutlinedButtonThemeData _lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppConfig.primaryColor,
      side: const BorderSide(color: AppConfig.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: AppConfig.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final OutlinedButtonThemeData _darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppConfig.primaryColor,
      side: const BorderSide(color: AppConfig.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: AppConfig.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: ColorConstants.grey50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.grey300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.grey300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppConfig.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.error, width: 2),
    ),
    hintStyle: const TextStyle(
      color: ColorConstants.grey500,
      fontFamily: AppConfig.fontFamily,
      fontSize: 14,
    ),
  );

  static final InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: ColorConstants.grey800,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.grey700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.grey700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppConfig.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ColorConstants.error, width: 2),
    ),
    hintStyle: const TextStyle(
      color: ColorConstants.grey500,
      fontFamily: AppConfig.fontFamily,
      fontSize: 14,
    ),
  );

  static const BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: ColorConstants.white,
    selectedItemColor: AppConfig.primaryColor,
    unselectedItemColor: ColorConstants.grey500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );

  static const BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    backgroundColor: ColorConstants.cardDark,
    selectedItemColor: AppConfig.primaryColor,
    unselectedItemColor: ColorConstants.grey500,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
}
