import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double? salePrice;
  final double? fontSize;
  final Color? salePriceColor;
  final Color? priceColor;
  final bool showDiscount;

  const PriceWidget({
    super.key,
    required this.price,
    this.salePrice,
    this.fontSize,
    this.salePriceColor,
    this.priceColor,
    this.showDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSalePrice = salePrice != null && salePrice! > 0 && salePrice! < price;
    final effectiveFontSize = fontSize ?? 16.sp;
    final effectiveSalePriceColor =
        salePriceColor ?? theme.colorScheme.primary;
    final effectivePriceColor =
        priceColor ?? theme.colorScheme.onSurface;
    final discount = hasSalePrice
        ? (((price - salePrice!) / price) * 100).round()
        : 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (hasSalePrice) ...[
          Text(
            '\$${salePrice!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: effectiveFontSize,
              fontWeight: FontWeight.w700,
              color: effectiveSalePriceColor,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: effectiveFontSize * 0.85,
              fontWeight: FontWeight.w400,
              color: effectivePriceColor.withOpacity(0.4),
              decoration: TextDecoration.lineThrough,
              decorationColor: effectivePriceColor.withOpacity(0.4),
            ),
          ),
        ] else
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: effectiveFontSize,
              fontWeight: FontWeight.w700,
              color: effectivePriceColor,
            ),
          ),
        if (showDiscount && hasSalePrice && discount > 0) ...[
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '-$discount%',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
