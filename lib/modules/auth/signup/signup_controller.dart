import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/services/storage_service.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool agreeToTerms = false.obs;
  final RxInt passwordStrength = 0.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
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

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _updatePasswordStrength() {
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordStrength.value = 0;
      return;
    }
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;
    passwordStrength.value = strength;
  }

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_updatePasswordStrength);
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;
    if (!agreeToTerms.value) {
      Get.snackbar('Error', 'Please agree to the terms and conditions');
      return;
    }

    isLoading.value = true;

    try {
      if (AppConfig.demoMode) {
        await Future.delayed(const Duration(seconds: 1));
        final storage = Get.find<StorageService>();
        await storage.saveToken('demo-token-${DateTime.now().millisecondsSinceEpoch}');
        await storage.saveUser({
          'id': '1',
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'avatarUrl': '',
        });
      } else {
        await Future.delayed(const Duration(seconds: 2));
        // TODO: Replace with actual API call via AuthRepository
      }
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    passwordController.removeListener(_updatePasswordStrength);
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
