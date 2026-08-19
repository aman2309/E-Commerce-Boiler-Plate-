import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'order_details_controller.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorConstants.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              'Order #${controller.order['id'] ?? ''}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
            )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = controller.order;
        final items = List<Map<String, dynamic>>.from(order['items'] ?? []);
        final address = Map<String, dynamic>.from(order['address'] ?? {});
        final payment = Map<String, dynamic>.from(order['payment'] ?? {});
        final timeline = List<Map<String, dynamic>>.from(order['timeline'] ?? []);

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusTimeline(timeline, order['status']),
              SizedBox(height: 16.h),
              _buildSectionTitle('Order Items'),
              SizedBox(height: 8.h),
              ...items.map((item) => _buildOrderItem(item)),
              SizedBox(height: 16.h),
              _buildSectionTitle('Delivery Address'),
              SizedBox(height: 8.h),
              _buildAddressCard(address),
              SizedBox(height: 16.h),
              _buildSectionTitle('Payment Information'),
              SizedBox(height: 8.h),
              _buildPaymentCard(payment),
              SizedBox(height: 16.h),
              _buildSectionTitle('Price Breakdown'),
              SizedBox(height: 8.h),
              _buildPriceBreakdown(order),
              SizedBox(height: 24.h),
              _buildActionButtons(controller, order),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
    );
  }

  Widget _buildStatusTimeline(List<Map<String, dynamic>> timeline, String currentStatus) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
          Text(
            'Order Status',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
          ),
          SizedBox(height: 16.h),
          ...timeline.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == timeline.length - 1;
            final isCompleted = step['completed'] == true;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted ? ColorConstants.accentGreen : ColorConstants.grey200,
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.circle,
                        size: 14.w,
                        color: ColorConstants.white,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2.w,
                        height: 40.h,
                        color: isCompleted ? ColorConstants.accentGreen : ColorConstants.grey200,
                      ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
                          color: isCompleted ? ColorConstants.textPrimary : ColorConstants.textTertiary,
                        ),
                      ),
                      if ((step['date'] as String).isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            step['date'],
                            style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              item['image'],
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60.w,
                height: 60.h,
                color: ColorConstants.grey100,
                child: const Icon(Icons.image, color: ColorConstants.grey400),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorConstants.textPrimary),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Qty: ${item['quantity']} \u00D7 \$${item['price'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12.sp, color: ColorConstants.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: ColorConstants.accentOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.location_on_outlined, color: ColorConstants.accentOrange, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                address['name'] ?? '',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorConstants.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${address['street']}\n${address['city']}, ${address['state']} ${address['zip']}\n${address['country']}',
            style: TextStyle(fontSize: 13.sp, color: ColorConstants.textSecondary, height: 1.5),
          ),
          SizedBox(height: 4.h),
          Text(
            'Phone: ${address['phone']}',
            style: TextStyle(fontSize: 13.sp, color: ColorConstants.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: ColorConstants.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.credit_card, color: ColorConstants.accentBlue, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment['method'] ?? '',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorConstants.textPrimary),
                ),
                Text(
                  'Card ending in ${payment['cardLast4']}',
                  style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorConstants.accentGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              payment['status'] ?? '',
              style: TextStyle(fontSize: 12.sp, color: ColorConstants.accentGreen, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(Map<String, dynamic> order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
        children: [
          _priceRow('Subtotal', '\$${(order['subtotal'] ?? 0).toStringAsFixed(2)}'),
          _priceRow('Shipping', '\$${(order['shipping'] ?? 0).toStringAsFixed(2)}'),
          _priceRow('Tax', '\$${(order['tax'] ?? 0).toStringAsFixed(2)}'),
          if ((order['discount'] ?? 0) != 0)
            _priceRow('Discount', '\$${(order['discount'] ?? 0).toStringAsFixed(2)}',
                valueColor: ColorConstants.accentGreen),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            height: 1,
            color: ColorConstants.divider,
          ),
          _priceRow(
            'Total',
            '\$${(order['total'] ?? 0).toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              color: isBold ? ColorConstants.textPrimary : ColorConstants.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: valueColor ?? ColorConstants.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(OrderDetailsController controller, Map<String, dynamic> order) {
    final status = order['status'] as String? ?? '';
    final isCancellable = status == 'processing' || status == 'shipped';

    return Column(
      children: [
        if (status == 'shipped' || status == 'processing')
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: controller.trackOrder,
              icon: const Icon(Icons.local_shipping_outlined),
              label: Text('Track Order', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.black,
                foregroundColor: ColorConstants.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                elevation: 0,
              ),
            ),
          ),
        if (status == 'shipped' || status == 'processing') SizedBox(height: 10.h),
        if (status == 'delivered' || status == 'cancelled')
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: controller.reorder,
              icon: const Icon(Icons.replay),
              label: Text('Reorder', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.accentOrange,
                foregroundColor: ColorConstants.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                elevation: 0,
              ),
            ),
          ),
        if (status == 'delivered' || status == 'cancelled') SizedBox(height: 10.h),
        if (isCancellable)
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: controller.cancelOrder,
              icon: Icon(Icons.cancel_outlined, color: ColorConstants.error, size: 18.sp),
              label: Text('Cancel Order', style: TextStyle(color: ColorConstants.error, fontSize: 14.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorConstants.error),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
          ),
        if (isCancellable) SizedBox(height: 10.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: TextButton.icon(
            onPressed: controller.contactSupport,
            icon: Icon(Icons.headset_mic_outlined, color: ColorConstants.textSecondary, size: 18.sp),
            label: Text(
              'Contact Support',
              style: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
            ),
          ),
        ),
      ],
    );
  }
}
