import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/services/storage_service.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void skip() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    saveOnboardingComplete();
    Get.offAllNamed('/login');
  }

  void saveOnboardingComplete() {
    final storageService = Get.find<StorageService>();
    storageService.setIsOnboarded(true);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
