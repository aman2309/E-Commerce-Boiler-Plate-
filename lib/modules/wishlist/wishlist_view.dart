import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'wishlist_controller.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            'My Wishlist (${controller.itemCount})',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.wishlistItems.isEmpty) {
          return _buildEmptyState();
        }
        return _buildWishlistGrid(controller);
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                color: ColorConstants.accentOrange.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 56.sp,
                color: ColorConstants.accentOrange.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Your wishlist is empty',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Save items you love to your wishlist\nand review them anytime',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorConstants.textSecondary,
                height: 1.5,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.accentOrange,
                foregroundColor: ColorConstants.white,
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Explore Products',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistGrid(WishlistController controller) {
    return Obx(
      () => GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: controller.wishlistItems.length,
        itemBuilder: (context, index) {
          final item = controller.wishlistItems[index];
          return _buildWishlistItem(item, index, controller);
        },
      ),
    );
  }

  Widget _buildWishlistItem(
    Map<String, dynamic> item,
    int index,
    WishlistController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 10,
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
                    top: Radius.circular(14.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: ColorConstants.grey100,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: ColorConstants.grey100,
                      child: Icon(
                        Icons.error,
                        color: ColorConstants.grey400,
                        size: 40.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => _showRemoveDialog(controller, index, item),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.w,
                        color: ColorConstants.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    '\u20B9${(item['price'] as double).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: ColorConstants.accentOrange,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.moveToCart(index),
                      icon: Icon(Icons.shopping_cart_outlined, size: 14.w),
                      label: Text(
                        'Move to Cart',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.black,
                        foregroundColor: ColorConstants.white,
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(
    WishlistController controller,
    int index,
    Map<String, dynamic> item,
  ) {
    Get.defaultDialog(
      title: 'Remove Item',
      middleText: 'Remove "${item['name']}" from wishlist?',
      textConfirm: 'Remove',
      textCancel: 'Cancel',
      confirmTextColor: ColorConstants.white,
      buttonColor: ColorConstants.error,
      cancelTextColor: ColorConstants.textSecondary,
      onConfirm: () {
        controller.removeFromWishlist(index);
        Get.back();
      },
    );
  }
}
