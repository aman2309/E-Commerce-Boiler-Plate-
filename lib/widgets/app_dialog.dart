import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog {
  AppDialog._();

  static Future<void> show({
    required BuildContext context,
    String? title,
    required Widget content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 8,
        title: title != null
            ? Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        content: content,
        contentPadding: EdgeInsets.fromLTRB(24.w, title != null ? 8.h : 24.h, 24.w, 8.h),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
              child: Text(
                cancelText,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          if (confirmText != null)
            ElevatedButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }
}
