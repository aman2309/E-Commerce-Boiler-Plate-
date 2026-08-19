import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/constants/dimensions.dart';
import 'package:flutter_boilerplate/widgets/category_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> categories;
  final VoidCallback? onSeeAll;

  const CategorySection({
    super.key,
    required this.title,
    required this.categories,
    this.onSeeAll,
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
                  'View All',
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
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(right: AppDimens.lg.w),
                child: CategoryCard(
                  name: category['name'] ?? '',
                  icon: category['icon'] as IconData? ?? Icons.category,
                  color: category['color'] as Color? ?? Colors.grey,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
