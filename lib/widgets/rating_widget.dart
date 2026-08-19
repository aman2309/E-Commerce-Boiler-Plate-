import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? color;
  final Color? unratedColor;
  final bool showText;
  final int? reviewCount;

  const RatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 20,
    this.color,
    this.unratedColor,
    this.showText = false,
    this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final starColor = color ?? Colors.amber.shade600;
    final effectiveUnratedColor = unratedColor ?? Colors.grey.shade300;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(maxRating, (index) {
            final starValue = index + 1;
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Icon(
                _getStarIcon(starValue, rating),
                size: size.w,
                color: starValue <= rating.round()
                    ? starColor
                    : (starValue - 1 < rating
                        ? starColor.withOpacity(0.6)
                        : effectiveUnratedColor),
              ),
            );
          }),
        ),
        if (showText) ...[
          SizedBox(width: 6.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
        if (reviewCount != null) ...[
          SizedBox(width: 4.w),
          Text(
            '($reviewCount)',
            style: TextStyle(
              fontSize: 12.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ],
    );
  }

  IconData _getStarIcon(int starValue, double rating) {
    if (starValue <= rating.floor()) {
      return Icons.star_rounded;
    } else if (starValue - 1 < rating && starValue > rating.floor()) {
      return Icons.star_half_rounded;
    }
    return Icons.star_border_rounded;
  }
}
