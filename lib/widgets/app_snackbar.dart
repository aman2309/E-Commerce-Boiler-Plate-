import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success({String? title, required String message}) {
    _show(
      title: title ?? 'Success',
      message: message,
      icon: Icons.check_circle_outline_rounded,
      backgroundColor: const Color(0xFF2E7D32),
      iconColor: Colors.white,
    );
  }

  static void error({String? title, required String message}) {
    _show(
      title: title ?? 'Error',
      message: message,
      icon: Icons.error_outline_rounded,
      backgroundColor: const Color(0xFFC62828),
      iconColor: Colors.white,
    );
  }

  static void info({String? title, required String message}) {
    _show(
      title: title ?? 'Info',
      message: message,
      icon: Icons.info_outline_rounded,
      backgroundColor: const Color(0xFF1565C0),
      iconColor: Colors.white,
    );
  }

  static void warning({String? title, required String message}) {
    _show(
      title: title ?? 'Warning',
      message: message,
      icon: Icons.warning_amber_rounded,
      backgroundColor: const Color(0xFFE65100),
      iconColor: Colors.white,
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      borderRadius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      icon: Icon(icon, color: iconColor, size: 24.w),
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 13.sp,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
