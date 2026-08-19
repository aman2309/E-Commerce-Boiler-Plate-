import 'dart:ui';

enum AppEnvironment { dev, staging, prod }

class AppConfig {
  AppConfig._();

  static const String appName = 'Flutter Boilerplate';
  static const String appShortName = 'F-Boilerplate';
  static const String packageName = 'com.example.flutter_boilerplate';
  static const String iosBundleId = 'com.example.flutterBoilerplate';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  static const AppEnvironment environment = AppEnvironment.dev;

  static const String supportEmail = 'support@example.com';
  static const String supportPhone = '+1234567890';

  static const String fontFamily = 'Poppins';

  static const Color primaryColor = Color(0xFF111111);
  static const Color secondaryColor = Color(0xFFFF6584);

  static String get apiBaseUrl {
    switch (environment) {
      case AppEnvironment.dev:
        return 'https://dev-api.example.com';
      case AppEnvironment.staging:
        return 'https://staging-api.example.com';
      case AppEnvironment.prod:
        return 'https://api.example.com';
    }
  }

  static bool get isDebug => environment == AppEnvironment.dev;
  static const bool enableDebugBanner = false;

  /// When true, all auth screens bypass API calls and use a local dummy session.
  /// Set to false and wire up [AuthRepository] when a real backend is ready.
  static const bool demoMode = true;
}
