import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBack;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;
  final TextStyle? style;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const AppBarWidget({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.showBack = true,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = true,
    this.style,
    this.systemOverlayStyle,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveLeading = leading ??
        (showBack
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20.w,
                  color: theme.colorScheme.onSurface,
                ),
                onPressed: () => Navigator.of(context).pop(),
                splashRadius: 22,
              )
            : null);

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: style ??
                  theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
            )
          : null,
      centerTitle: centerTitle,
      leading: effectiveLeading,
      actions: actions,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0.5,
      systemOverlayStyle: systemOverlayStyle ??
          SystemUiOverlayStyle(
            statusBarBrightness: theme.brightness,
            statusBarIconBrightness: theme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
          ),
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          color: theme.colorScheme.outline.withOpacity(0.15),
        ),
      ),
    );
  }
}
