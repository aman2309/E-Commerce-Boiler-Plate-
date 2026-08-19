import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';

class ProfileController extends GetxController {
  final isLoading = false.obs;
  final user = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    isLoading.value = true;
    user.value = {
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+1 234 567 890',
      'avatarUrl': '',
      'initials': 'JD',
    };
    isLoading.value = false;
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
