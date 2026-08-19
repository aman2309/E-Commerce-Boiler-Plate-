import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final String email = Get.arguments?['email'] ?? '';

  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    secondsRemaining.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void moveToNext(String value, int index) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String get otpCode {
    return otpControllers.map((c) => c.text).join();
  }

  bool get isOTPComplete {
    return otpControllers.every((c) => c.text.length == 1);
  }

  Future<void> verifyOTP() async {
    if (!isOTPComplete) {
      Get.snackbar('Error', 'Please enter the complete 4-digit code');
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      // await AuthService.verifyOTP(email: email, otp: otpCode);
      Get.snackbar('Success', 'OTP verified successfully (placeholder)');
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void resendCode() {
    if (secondsRemaining.value > 0) return;
    _startTimer();
    Get.snackbar('Sent', 'Verification code sent to $email');
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
