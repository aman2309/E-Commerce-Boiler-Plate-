import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onSearch;
  final bool readOnly;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Widget? suffixIcon;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hint,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onSearch,
    this.readOnly = false,
    this.onTap,
    this.borderRadius,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? 16.r;

    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: (value) {
          onChanged?.call(value);
          onSearch?.call(value);
        },
        onSubmitted: (value) {
          onSubmitted?.call(value);
          onSearch?.call(value);
        },
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorConstants.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? hint ?? 'Search products, brands...',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: ColorConstants.textTertiary,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Icon(
              Icons.search_rounded,
              color: ColorConstants.textTertiary,
              size: 22.w,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 48.w,
            minHeight: 52.h,
          ),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: suffixIcon,
                )
              : null,
          suffixIconConstraints: suffixIcon != null
              ? BoxConstraints(
                  minWidth: 44.w,
                  minHeight: 52.h,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          filled: false,
        ),
      ),
    );
  }
}
