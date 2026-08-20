import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: _buildAppBar(controller),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return _buildEmptyCart(context);
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    _buildDeliveryBanner(controller),
                    SizedBox(height: 12.h),
                    _buildCartItems(controller),
                    SizedBox(height: 12.h),
                    _buildCouponSection(controller),
                    SizedBox(height: 12.h),
                    _buildPriceBreakdown(controller),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
            _buildBottomBar(controller),
          ],
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(CartController controller) {
    return AppBar(
      backgroundColor: ColorConstants.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.w, color: ColorConstants.textPrimary),
      ),
      title: Row(
        children: [
          Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(width: 8.w),
          if (controller.itemCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: ColorConstants.accentOrange,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${controller.itemCount}',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.white,
                ),
              ),
            ),
        ],
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(color: ColorConstants.divider, height: 1.h),
      ),
    );
  }

  Widget _buildDeliveryBanner(CartController controller) {
    final isFreeDelivery = controller.deliveryCharge.value == 0;
    final remaining = 50.0 - controller.subtotal;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isFreeDelivery
            ? ColorConstants.accentGreen.withValues(alpha: 0.1)
            : ColorConstants.accentOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isFreeDelivery
              ? ColorConstants.accentGreen.withValues(alpha: 0.3)
              : ColorConstants.accentOrange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isFreeDelivery ? Icons.check_circle_rounded : Icons.local_shipping_outlined,
            color: isFreeDelivery ? ColorConstants.accentGreen : ColorConstants.accentOrange,
            size: 22.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: isFreeDelivery
                ? Text(
                    'You\'ve unlocked FREE delivery!',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.accentGreen,
                    ),
                  )
                : Text(
                    'Add \$${remaining.toStringAsFixed(2)} more for FREE delivery',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.accentOrange,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(CartController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(controller.cartItems.length, (index) {
          final item = controller.cartItems[index];
          return Dismissible(
            key: Key(item['id']),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 24.w),
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: ColorConstants.error,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline_rounded, color: ColorConstants.white, size: 26.w),
                  SizedBox(height: 4.h),
                  Text(
                    'Delete',
                    style: TextStyle(color: ColorConstants.white, fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            onDismissed: (_) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.removeItem(index);
              });
            },
            child: _buildCartItemCard(item, index, controller),
          );
        }),
      ),
    );
  }

  Widget _buildCartItemCard(Map<String, dynamic> item, int index, CartController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: item['image'] ?? '',
                width: 100.w,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 100.w,
                  height: double.infinity,
                  color: ColorConstants.grey100,
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorConstants.grey400,
                      ),
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 100.w,
                  height: double.infinity,
                  color: ColorConstants.grey100,
                  child: Icon(Icons.image_not_supported_outlined, color: ColorConstants.grey400, size: 28.w),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () => controller.removeItem(index),
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: ColorConstants.grey100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close_rounded, size: 14.w, color: ColorConstants.grey500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          _buildInfoChip(item['size']),
                          SizedBox(width: 6.w),
                          _buildInfoChip(item['color']),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '\$${(item['price'] as double).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.accentOrange,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuantitySelector(item, index, controller),
                      GestureDetector(
                        onTap: () => controller.moveToWishlist(index),
                        child: Text(
                          'Move to Wishlist',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: ColorConstants.accentBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String? label) {
    if (label == null || label.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorConstants.grey100,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: ColorConstants.textSecondary,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(Map<String, dynamic> item, int index, CartController controller) {
    final qty = item['quantity'] as int;
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.grey50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorConstants.grey200, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: qty > 1 ? () => controller.decrementQuantity(index) : null,
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              child: Icon(
                Icons.remove_rounded,
                size: 16.w,
                color: qty > 1 ? ColorConstants.textPrimary : ColorConstants.grey400,
              ),
            ),
          ),
          Container(
            width: 36.w,
            alignment: Alignment.center,
            child: Text(
              '$qty',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textPrimary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.incrementQuantity(index),
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              child: Icon(
                Icons.add_rounded,
                size: 16.w,
                color: ColorConstants.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection(CartController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer_outlined, size: 18.w, color: ColorConstants.accentOrange),
              SizedBox(width: 8.w),
              Text(
                'Coupon Code',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (controller.discount.value > 0) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: ColorConstants.accentGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorConstants.accentGreen.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_rounded, size: 18.w, color: ColorConstants.accentGreen),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '"${controller.couponCode.value}" applied \u2014 10% off',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: ColorConstants.accentGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.removeCoupon(),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: ColorConstants.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close_rounded, size: 14.w, color: ColorConstants.error),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => controller.couponCode.value = value,
                    style: TextStyle(fontSize: 14.sp, color: ColorConstants.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Enter coupon code',
                      hintStyle: TextStyle(fontSize: 13.sp, color: ColorConstants.grey400),
                      filled: true,
                      fillColor: ColorConstants.grey50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: ColorConstants.grey200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: ColorConstants.grey200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: ColorConstants.textPrimary, width: 1.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => controller.applyCoupon(controller.couponCode.value),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.textPrimary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(CartController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 14.h),
          _buildPriceRow('Subtotal', '\$${controller.subtotal.toStringAsFixed(2)}'),
          if (controller.discount.value > 0) ...[
            SizedBox(height: 10.h),
            _buildPriceRow(
              'Discount',
              '- \$${controller.discount.value.toStringAsFixed(2)}',
              valueColor: ColorConstants.accentGreen,
            ),
          ],
          SizedBox(height: 10.h),
          _buildPriceRow(
            'Delivery',
            controller.deliveryCharge.value == 0 ? 'FREE' : '\$${controller.deliveryCharge.value.toStringAsFixed(2)}',
            valueColor: controller.deliveryCharge.value == 0 ? ColorConstants.accentGreen : null,
          ),
          SizedBox(height: 10.h),
          _buildPriceRow('Tax (8%)', '\$${controller.tax.value.toStringAsFixed(2)}'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: ColorConstants.divider, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                ),
              ),
              Text(
                '\$${controller.total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ColorConstants.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: valueColor ?? ColorConstants.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(CartController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.textTertiary,
                    ),
                  ),
                  Text(
                    '\$${controller.total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                      onPressed: controller.cartItems.isNotEmpty
                          ? () => Get.toNamed(AppRoutes.checkout)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.textPrimary,
                        disabledBackgroundColor: ColorConstants.grey300,
                        foregroundColor: ColorConstants.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.white,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(Icons.arrow_forward_rounded, size: 18.w, color: ColorConstants.white),
                        ],
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: ColorConstants.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 56.w,
                color: ColorConstants.grey400,
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Looks like you haven\'t added anything to your cart yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorConstants.textSecondary,
                height: 1.5,
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.textPrimary,
                  foregroundColor: ColorConstants.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 18.w, color: ColorConstants.white),
                    SizedBox(width: 8.w),
                    Text(
                      'Start Shopping',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.white,
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
}
