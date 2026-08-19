import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/services/storage_service.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    animationController.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    _checkOnboardingAndNavigate();
  }

  void _checkOnboardingAndNavigate() {
    final storageService = Get.find<StorageService>();
    final onboardingCompleted = storageService.isOnboarded();
    final isLoggedIn = storageService.hasToken;

    if (!onboardingCompleted) {
      Get.offAllNamed('/onboarding');
    } else if (!isLoggedIn) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
