import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'checkout_controller.dart';
import '../cart/cart_controller.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    Get.put(CartController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: ColorConstants.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepIndicator(controller),
          Expanded(
            child: Obx(() {
              switch (controller.currentStep.value) {
                case 0:
                  return _buildAddressSection(controller);
                case 1:
                  return _buildDeliverySection(controller);
                case 2:
                  return _buildPaymentSection(controller);
                case 3:
                  return _buildConfirmSection(controller);
                default:
                  return _buildAddressSection(controller);
              }
            }),
          ),
          _buildBottomBar(controller),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(CheckoutController controller) {
    final steps = ['Address', 'Delivery', 'Payment', 'Confirm'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: ColorConstants.white,
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isActive = index <= controller.currentStep.value;
          final isCompleted = index < controller.currentStep.value;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? ColorConstants.black
                          : ColorConstants.grey200,
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check, size: 16.w, color: ColorConstants.white)
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isActive
                                    ? ColorConstants.white
                                    : ColorConstants.textTertiary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isActive
                          ? ColorConstants.textPrimary
                          : ColorConstants.textTertiary,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (index < steps.length - 1)
                Container(
                  width: 40.w,
                  height: 2.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  color: isCompleted
                      ? ColorConstants.black
                      : ColorConstants.grey200,
                ),
            ],
          );
        }),
      )),
    );
  }

  Widget _buildAddressSection(CheckoutController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Delivery Address',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children:
                List.generate(controller.addresses.length, (index) {
              final address = controller.addresses[index];
              final isSelected =
                  index == controller.selectedAddressIndex.value;
              return _buildAddressCard(
                  address, isSelected, index, controller);
            }),
          )),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: controller.addNewAddress,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorConstants.grey200,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                      size: 20.w, color: ColorConstants.textPrimary),
                  SizedBox(width: 8.w),
                  Text(
                    'Add New Address',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
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

  Widget _buildAddressCard(
    Map<String, dynamic> address,
    bool isSelected,
    int index,
    CheckoutController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.selectAddress(index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorConstants.black
                : ColorConstants.grey200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorConstants.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<int>(
              value: index,
              groupValue: controller.selectedAddressIndex.value,
              onChanged: (value) {
                if (value != null) controller.selectAddress(value);
              },
              activeColor: ColorConstants.black,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          address['name'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textPrimary,
                          ),
                        ),
                      ),
                      if (address['isDefault'] == true)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorConstants.black,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: ColorConstants.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    address['phone'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorConstants.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${address['addressLine1']}${address['addressLine2'] != '' ? ', ${address['addressLine2']}' : ''}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  Text(
                    '${address['city']}, ${address['state']} ${address['zipCode']}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  Text(
                    address['country'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit_outlined,
                  size: 18.w, color: ColorConstants.textTertiary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliverySection(CheckoutController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Delivery Method',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children: controller.deliveryOptions.map((option) {
              final isSelected =
                  option['id'] == controller.selectedDeliveryMethod.value;
              return GestureDetector(
                onTap: () => controller.selectDelivery(option['id']),
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorConstants.black
                          : ColorConstants.grey200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option['icon'],
                        size: 28.w,
                        color: isSelected
                            ? ColorConstants.black
                            : ColorConstants.textTertiary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option['name'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              option['description'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorConstants.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (option['freeOver50'])
                            Text(
                              'Free over \$50',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ColorConstants.accentGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(
                            option['price'] == 0
                                ? 'FREE'
                                : '\$${(option['price'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: option['price'] == 0
                                  ? ColorConstants.accentGreen
                                  : ColorConstants.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(CheckoutController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Column(
            children: controller.paymentMethods.map((method) {
              final isSelected =
                  method['id'] == controller.selectedPaymentMethod.value;
              return GestureDetector(
                onTap: () => controller.selectPayment(method['id']),
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorConstants.black
                          : ColorConstants.grey200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        method['icon'],
                        size: 28.w,
                        color: isSelected
                            ? ColorConstants.black
                            : ColorConstants.textTertiary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['name'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              method['description'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorConstants.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: method['id'],
                        groupValue: controller.selectedPaymentMethod.value,
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectPayment(value);
                          }
                        },
                        activeColor: ColorConstants.black,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildConfirmSection(CheckoutController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          _buildSectionCard(
            'Delivery Address',
            Obx(() {
              final address = controller.selectedAddress;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['name'] ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${address['addressLine1'] ?? ''}${address['addressLine2'] != null && address['addressLine2'] != '' ? ', ${address['addressLine2']}' : ''}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  Text(
                    '${address['city'] ?? ''}, ${address['state'] ?? ''} ${address['zipCode'] ?? ''}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              );
            }),
          ),

          _buildSectionCard(
            'Delivery Method',
            Obx(() {
              final method = controller.deliveryOptions.firstWhere(
                (e) => e['id'] == controller.selectedDeliveryMethod.value,
                orElse: () => controller.deliveryOptions[0],
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    method['name'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  Text(
                    method['price'] == 0
                        ? 'FREE'
                        : '\$${(method['price'] as double).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              );
            }),
          ),

          _buildSectionCard(
            'Payment Method',
            Obx(() {
              final method = controller.paymentMethods.firstWhere(
                (e) => e['id'] == controller.selectedPaymentMethod.value,
                orElse: () => controller.paymentMethods[1],
              );
              return Text(
                method['name'],
                style: TextStyle(
                  fontSize: 13.sp,
                  color: ColorConstants.textPrimary,
                ),
              );
            }),
          ),

          _buildSectionCard(
            'Items',
            Obx(() => Column(
              children: controller.cartItems.map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: CachedNetworkImage(
                          imageUrl: item['image'],
                          width: 48.w,
                          height: 48.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 48.w,
                            height: 48.h,
                            color: ColorConstants.grey100,
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 48.w,
                            height: 48.h,
                            color: ColorConstants.grey100,
                            child: Icon(Icons.error,
                                size: 20.w, color: ColorConstants.grey400),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Qty: ${item['quantity']}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: ColorConstants.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${((item['price'] as double) * (item['quantity'] as int)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )),
          ),

          _buildSectionCard(
            'Price Details',
            Column(
              children: [
                _buildPriceRow(
                    'Subtotal', '\$${controller.subtotal.toStringAsFixed(2)}'),
                if (controller.discount > 0)
                  _buildPriceRow(
                    'Discount',
                    '-\$${controller.discount.toStringAsFixed(2)}',
                    valueColor: ColorConstants.accentGreen,
                  ),
                _buildPriceRow(
                  'Delivery',
                  controller.deliveryCharge == 0
                      ? 'FREE'
                      : '\$${controller.deliveryCharge.toStringAsFixed(2)}',
                  valueColor: controller.deliveryCharge == 0
                      ? ColorConstants.accentGreen
                      : null,
                ),
                _buildPriceRow(
                    'Tax (8%)', '\$${controller.tax.toStringAsFixed(2)}'),
                const Divider(color: ColorConstants.grey200),
                _buildPriceRow(
                  'Total',
                  '\$${controller.total.toStringAsFixed(2)}',
                  isBold: true,
                ),
              ],
            ),
          ),

          _buildSecurePaymentBadge(),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          content,
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              color: ColorConstants.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 16.sp : 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              color: valueColor ?? ColorConstants.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurePaymentBadge() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorConstants.accentGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline,
              size: 16.w, color: ColorConstants.accentGreen),
          SizedBox(width: 8.w),
          Text(
            'Secure Payment • SSL Encrypted',
            style: TextStyle(
              fontSize: 12.sp,
              color: ColorConstants.accentGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CheckoutController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() {
          final isLastStep = controller.currentStep.value == 3;
          return Row(
            children: [
              if (controller.currentStep.value > 0)
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: controller.previousStep,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorConstants.textPrimary,
                      side: const BorderSide(color: ColorConstants.grey300),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (controller.currentStep.value > 0) SizedBox(width: 12.w),
              Expanded(
                flex: isLastStep ? 2 : 3,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLastStep) {
                      controller.placeOrder();
                    } else {
                      controller.nextStep();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.black,
                    foregroundColor: ColorConstants.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorConstants.white,
                          ),
                        )
                      : Text(
                          isLastStep ? 'Place Order' : 'Continue',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
