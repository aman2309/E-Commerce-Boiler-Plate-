import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  final RxInt badgeCount = 0.obs;

  void incrementBadge() {
    badgeCount.value++;
  }

  void decrementBadge() {
    if (badgeCount.value > 0) {
      badgeCount.value--;
    }
  }

  void clearBadge() {
    badgeCount.value = 0;
  }

  void setBadgeCount(int count) {
    badgeCount.value = count;
  }

  void showLocalNotification({
    required String title,
    required String body,
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title,
      body,
      icon: const Icon(Icons.notifications_active_rounded, color: Colors.white),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      onTap: (_) => onTap?.call(),
    );
  }
}
