import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    this.imageUrl,
    required this.name,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? ColorConstants.accentOrange;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: effectiveColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
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
                      errorWidget: (_, __, ___) => _buildIcon(effectiveColor),
                    )
                  : _buildIcon(effectiveColor),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 72.w,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(Color effectiveColor) {
    return Center(
      child: Icon(
        icon ?? Icons.category_outlined,
        color: effectiveColor,
        size: 28.w,
      ),
    );
  }
}
