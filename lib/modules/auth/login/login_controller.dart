import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/data/repositories/auth_repository.dart';
import 'package:flutter_boilerplate/services/storage_service.dart';

class LoginController extends GetxController {
  final AuthRepository? _authRepository;

  LoginController([this._authRepository]);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      if (AppConfig.demoMode) {
        await Future.delayed(const Duration(seconds: 1));
        final storage = Get.find<StorageService>();
        await storage.saveToken('demo-token-${DateTime.now().millisecondsSinceEpoch}');
        await storage.saveUser({
          'id': '1',
          'name': 'Demo User',
          'email': emailController.text.trim(),
          'phone': '+1 000 000 0000',
          'avatarUrl': '',
        });
      } else {
        await _authRepository!.login(
          emailController.text.trim(),
          passwordController.text,
        );
      }
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  void navigateToSignup() {
    Get.toNamed(AppRoutes.signup);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
