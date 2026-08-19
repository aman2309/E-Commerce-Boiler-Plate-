import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/constants/dimensions.dart';
import 'package:flutter_boilerplate/widgets/product_card.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;
  final VoidCallback? onSeeAll;
  final double? itemWidth;
  final double? itemHeight;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.onSeeAll,
    this.itemWidth,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.md.h),
        SizedBox(
          height: itemHeight ?? 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: EdgeInsets.only(right: AppDimens.md.w),
                child: SizedBox(
                  width: itemWidth ?? 150.w,
                  child: ProductCard(
                    name: product['name'] ?? '',
                    price: (product['price'] ?? 0).toDouble(),
                    salePrice:
                        (product['discountPrice'] ?? product['price'] ?? 0)
                            .toDouble(),
                    rating: (product['rating'] ?? 0).toDouble(),
                    reviewCount: product['reviews'] as int?,
                    imageUrl: product['image'] as String?,
                    isWishlisted: product['isFavorite'] ?? false,
                    onTap: () {},
                    onWishlistTap: () {},
                    onCartTap: () {},
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
