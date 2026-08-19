import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/localization/app_translations.dart';

class LocalizationService extends Translations {
  static const String defaultLanguage = 'en';

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
  ];

  static const List<String> languageCodes = ['en'];

  static const Map<String, String> languageNames = {
    'en': 'English',
  };

  Locale get locale {
    return Get.deviceLocale ?? const Locale(defaultLanguage);
  }

  void changeLocale(String code) {
    if (!languageCodes.contains(code)) return;
    final locale = Locale(code);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => AppTranslations().keys;
}
