import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimens {
  AppDimens._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusXxl = 24;
  static const double radiusFull = 999;

  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;
}

/// Shorthand alias used throughout the app views.
class Dimensions {
  Dimensions._();

  static double get xs => AppDimens.xs;
  static double get sm => AppDimens.sm;
  static double get md => AppDimens.md;
  static double get lg => AppDimens.lg;
  static double get xl => AppDimens.xl;
  static double get xxl => AppDimens.xxl;
  static double get xxxl => AppDimens.xxxl;

  static double get paddingExtraSmall => AppDimens.xs;
  static double get paddingSmall => AppDimens.sm;
  static double get paddingMedium => AppDimens.md;
  static double get paddingLarge => AppDimens.lg;
  static double get paddingHorizontal => AppDimens.lg;
  static double get paddingVertical => AppDimens.md;

  static double get radiusSmall => AppDimens.radiusSm;
  static double get radiusMedium => AppDimens.radiusMd;
  static double get radiusLarge => AppDimens.radiusLg;
  static double get radiusExtraSmall => AppDimens.radiusSm;
  static double get radiusExtraLarge => AppDimens.radiusXl;
}

/// Screen-util extensions on [num].
extension ScreenUtilNumExt on num {
  double get ph => h;
  double get pw => w;
  double get pr => r;
  double get psp => sp;
}
