import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final Color? gradientStart;
  final Color? gradientEnd;
  final IconData? icon;

  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonTap,
    this.gradientStart,
    this.gradientEnd,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final startColor = gradientStart ?? ColorConstants.accentOrange;
    final endColor = gradientEnd ?? const Color(0xFFFF8A50);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: startColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: ColorConstants.white.withValues(alpha: 0.9),
                  ),
                ),
                if (buttonText != null) ...[
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: onButtonTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        buttonText!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: startColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (icon != null)
            Icon(
              icon!,
              size: 72.w,
              color: ColorConstants.white.withValues(alpha: 0.3),
            ),
        ],
      ),
    );
  }
}
