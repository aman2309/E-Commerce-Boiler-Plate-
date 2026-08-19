import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String? brand;
  final double price;
  final double? salePrice;
  final int? discount;
  final double? rating;
  final int? reviewCount;
  final bool isWishlisted;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onCartTap;

  const ProductCard({
    super.key,
    this.imageUrl,
    required this.name,
    this.brand,
    required this.price,
    this.salePrice,
    this.discount,
    this.rating,
    this.reviewCount,
    this.isWishlisted = false,
    this.onTap,
    this.onWishlistTap,
    this.onCartTap,
  });

  int? get _computedDiscount {
    if (discount != null && discount! > 0) return discount;
    if (salePrice != null && salePrice! > 0 && price > 0) {
      return (((price - salePrice!) / price) * 100).round();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasDiscount = _computedDiscount != null && _computedDiscount! > 0;
    final hasSalePrice = salePrice != null && salePrice! > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: imageUrl != null && imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (_, __, ___) =>
                                _buildImagePlaceholder(),
                          )
                        : _buildImagePlaceholder(),
                  ),
                  if (hasDiscount)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.accentGreen,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '-$_computedDiscount%',
                          style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onWishlistTap,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: ColorConstants.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isWishlisted
                              ? ColorConstants.error
                              : ColorConstants.grey500,
                          size: 18.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    if (rating != null)
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: ColorConstants.starYellow,
                            size: 14.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                          if (reviewCount != null)
                            Text(
                              ' ($reviewCount)',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ColorConstants.textTertiary,
                              ),
                            ),
                        ],
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        if (hasSalePrice)
                          Text(
                            '\$${salePrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.accentOrange,
                            ),
                          ),
                        if (hasSalePrice) SizedBox(width: 4.w),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: hasSalePrice ? 11.sp : 14.sp,
                            fontWeight: hasSalePrice
                                ? FontWeight.w400
                                : FontWeight.w700,
                            color: hasSalePrice
                                ? ColorConstants.textTertiary
                                : ColorConstants.textPrimary,
                            decoration: hasSalePrice
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: double.infinity,
                      height: 32.h,
                      child: ElevatedButton(
                        onPressed: onCartTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.accentOrange,
                          foregroundColor: ColorConstants.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorConstants.grey50,
      child: Icon(
        Icons.shopping_bag_outlined,
        color: ColorConstants.grey400,
        size: 36.w,
      ),
    );
  }
}
