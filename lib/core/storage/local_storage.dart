import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_boilerplate/core/constants/app_constants.dart';

class LocalStorageService extends GetxService {
  static LocalStorageService get to => Get.find<LocalStorageService>();

  late final GetStorage _box;

  Future<LocalStorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Token
  Future<void> saveToken(String token) => _box.write(AppConstants.tokenKey, token);

  String? getToken() => _box.read<String>(AppConstants.tokenKey);

  Future<void> removeToken() => _box.remove(AppConstants.tokenKey);

  // Refresh Token
  Future<void> saveRefreshToken(String token) =>
      _box.write(AppConstants.refreshTokenKey, token);

  String? getRefreshToken() => _box.read<String>(AppConstants.refreshTokenKey);

  Future<void> removeRefreshToken() => _box.remove(AppConstants.refreshTokenKey);

  // User
  Future<void> saveUser(Map<String, dynamic> user) =>
      _box.write(AppConstants.userKey, jsonEncode(user));

  Map<String, dynamic>? getUser() {
    final data = _box.read<String>(AppConstants.userKey);
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> removeUser() => _box.remove(AppConstants.userKey);

  // Onboarding
  Future<void> setIsOnboarded(bool value) =>
      _box.write(AppConstants.onboardingKey, value);

  bool isOnboarded() => _box.read<bool>(AppConstants.onboardingKey) ?? false;

  // Theme
  Future<void> setThemeMode(ThemeMode mode) =>
      _box.write(AppConstants.themeKey, mode.name);

  ThemeMode getThemeMode() {
    final value = _box.read<String>(AppConstants.themeKey);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  // Language
  Future<void> setLanguage(String code) =>
      _box.write(AppConstants.languageKey, code);

  String? getLanguage() => _box.read<String>(AppConstants.languageKey);

  // Cart Count
  Future<void> saveCartCount(int count) =>
      _box.write(AppConstants.cartCountKey, count);

  int getCartCount() => _box.read<int>(AppConstants.cartCountKey) ?? 0;

  // Clear All
  Future<void> clearAll() => _box.erase();
}
