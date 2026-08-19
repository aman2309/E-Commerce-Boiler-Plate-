import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StorageService {
  late final GetStorage _box;
  static const _keyToken = 'auth_token';
  static const _keyUser = 'user_data';
  static const _keyOnboarded = 'is_onboarded';
  static const _keyThemeMode = 'theme_mode';
  static const _keyLanguage = 'language';

  Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  // ──────────────────── Token ────────────────────

  Future<void> saveToken(String token) async {
    await _box.write(_keyToken, token);
  }

  String? getToken() {
    return _box.read<String>(_keyToken);
  }

  bool get hasToken => getToken() != null && getToken()!.isNotEmpty;

  Future<void> removeToken() async {
    await _box.remove(_keyToken);
  }

  // ──────────────────── User ────────────────────

  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _box.write(_keyUser, jsonEncode(userData));
  }

  Map<String, dynamic>? getUser() {
    final raw = _box.read<String>(_keyUser);
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> removeUser() async {
    await _box.remove(_keyUser);
  }

  // ──────────────────── Onboarding ────────────────────

  Future<void> setIsOnboarded(bool value) async {
    await _box.write(_keyOnboarded, value);
  }

  bool isOnboarded() {
    return _box.read<bool>(_keyOnboarded) ?? false;
  }

  // ──────────────────── Theme ────────────────────

  Future<void> setThemeMode(ThemeMode mode) async {
    await _box.write(_keyThemeMode, mode.name);
  }

  ThemeMode getThemeMode() {
    final value = _box.read<String>(_keyThemeMode);
    if (value == null) return ThemeMode.system;
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  // ──────────────────── Language ────────────────────

  Future<void> setLanguage(String languageCode) async {
    await _box.write(_keyLanguage, languageCode);
  }

  String getLanguage() {
    return _box.read<String>(_keyLanguage) ?? 'en';
  }

  // ──────────────────── Session ────────────────────

  Future<void> clearSession() async {
    await removeToken();
    await removeUser();
  }
}
