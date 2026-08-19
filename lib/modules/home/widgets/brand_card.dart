import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class BrandCard extends StatelessWidget {
  final String name;
  final IconData? icon;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.name,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorConstants.grey200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: ColorConstants.grey50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.branding_watermark,
                size: 24.w,
                color: ColorConstants.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              name,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
