import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isOutlined;
  final bool isExpanded;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isOutlined = false,
    this.isExpanded = true,
    this.icon,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.colorScheme.primary;
    final disabledColor = buttonColor.withOpacity(0.5);

    final effectiveHeight = height ?? 52.h;
    final effectiveBorderRadius = borderRadius ?? 12.r;
    final effectiveFontSize = fontSize ?? 16.sp;

    final child = isLoading
        ? SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined ? buttonColor : Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20.w, color: isOutlined ? buttonColor : textColor ?? Colors.white),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: Text(
                  text,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontSize: effectiveFontSize,
                    color: isOutlined
                        ? buttonColor
                        : textColor ?? Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    final button = SizedBox(
      height: effectiveHeight,
      width: isExpanded ? double.infinity : width,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: onPressed == null ? disabledColor : buttonColor,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                ),
                padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: textColor ?? Colors.white,
                disabledBackgroundColor: disabledColor,
                disabledForegroundColor: Colors.white70,
                elevation: elevation ?? 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                ),
                padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
              ),
              child: child,
            ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: button);
    }
    return button;
  }
}
