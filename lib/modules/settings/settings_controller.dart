import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';

class SettingsController extends GetxController {
  final isNotificationsEnabled = true.obs;
  final selectedLanguage = 'English'.obs;
  final isDarkMode = false.obs;

  String get appVersion => '1.0.0+1';

  void toggleNotifications() {
    isNotificationsEnabled.value = !isNotificationsEnabled.value;
    Get.snackbar(
      'Notifications',
      isNotificationsEnabled.value ? 'Notifications enabled' : 'Notifications disabled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void changeTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeTheme(isDark ? ThemeData.dark() : ThemeData.light());
  }

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    Get.snackbar(
      'Language',
      'Language changed to $lang',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void changePassword() {
    Get.snackbar(
      'Change Password',
      'Password change feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action is irreversible and all your data will be permanently removed.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
