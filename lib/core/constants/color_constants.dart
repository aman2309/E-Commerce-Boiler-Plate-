import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';

class ColorConstants {
  ColorConstants._();

  // Primary
  static const Color primary = AppConfig.primaryColor;
  static const Color primaryLight = Color(0xFF333333);
  static const Color primaryDark = Color(0xFF111111);

  // Accent / Brand
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentGreen = Color(0xFF00C853);
  static const Color accentBlue = Color(0xFF2979FF);
  static const Color accentPurple = Color(0xFF7C4DFF);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color accentAmber = Color(0xFFFFB300);

  // Secondary
  static const Color secondary = AppConfig.secondaryColor;
  static const Color secondaryLight = Color(0xFFFF94AC);
  static const Color secondaryDark = Color(0xFFCC506A);

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF8F9FA);
  static const Color grey100 = Color(0xFFF1F3F5);
  static const Color grey200 = Color(0xFFE9ECEF);
  static const Color grey300 = Color(0xFFDEE2E6);
  static const Color grey400 = Color(0xFFCED4DA);
  static const Color grey500 = Color(0xFFADB5BD);
  static const Color grey600 = Color(0xFF868E96);
  static const Color grey700 = Color(0xFF495057);
  static const Color grey800 = Color(0xFF343A40);
  static const Color grey900 = Color(0xFF212529);

  // Semantic
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF1744);
  static const Color warning = Color(0xFFFFB300);
  static const Color info = Color(0xFF2979FF);

  // Discount / Sale
  static const Color discountGreen = Color(0xFF00C853);
  static const Color saleRed = Color(0xFFFF1744);

  // Background
  static const Color scaffoldBackgroundLight = Color(0xFFF5F6FA);
  static const Color scaffoldBackgroundDark = Color(0xFF121212);

  // Card
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);

  // Divider
  static const Color divider = Color(0xFFEEEEEE);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textPrimaryDark = Color(0xFFF1F3F5);
  static const Color textSecondaryDark = Color(0xFFADB5BD);

  // Rating
  static const Color starYellow = Color(0xFFFFB300);
  static const Color starBackground = Color(0xFFFFF8E1);
}
