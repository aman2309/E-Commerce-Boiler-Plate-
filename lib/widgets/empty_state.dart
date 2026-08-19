import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final String? message;
  final String? actionText;
  final VoidCallback? onAction;
  final VoidCallback? onRetry;

  const EmptyState({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.message,
    this.actionText,
    this.onAction,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayMessage = message ?? subtitle;
    final displayOnRetry = onRetry ?? onAction;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon!,
                  size: 56.w,
                  color: theme.colorScheme.primary.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 24.h),
            ],
            Text(
              title ?? 'Nothing here',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (displayMessage != null) ...[
              SizedBox(height: 8.h),
              Text(
                displayMessage,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionText != null && displayOnRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: displayOnRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 14.h,
                  ),
                ),
                child: Text(
                  actionText!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
