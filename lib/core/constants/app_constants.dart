class AppConstants {
  AppConstants._();

  // Storage Keys
  static const String onboardingKey = 'is_onboarded';
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String cartCountKey = 'cart_count';

  // Pagination
  static const int defaultPageLimit = 20;

  // Animation Durations (milliseconds)
  static const int shortAnimation = 200;
  static const int mediumAnimation = 400;
  static const int longAnimation = 600;

  // Debounce Durations (milliseconds)
  static const int searchDebounce = 500;
  static const int tapDebounce = 300;
}
