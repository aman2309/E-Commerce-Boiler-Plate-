import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'orders_controller.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorConstants.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Orders',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Obx(() => Container(
                color: ColorConstants.white,
                child: TabBar(
                  isScrollable: true,
                  labelColor: ColorConstants.accentOrange,
                  unselectedLabelColor: ColorConstants.textTertiary,
                  indicatorColor: ColorConstants.accentOrange,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  onTap: (index) {
                    const tabs = ['all', 'processing', 'shipped', 'delivered', 'cancelled'];
                    controller.filterByStatus(tabs[index]);
                  },
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Processing'),
                    Tab(text: 'Shipped'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              )),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final filtered = controller.filteredOrders;

        if (filtered.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final order = filtered[index];
            return _buildOrderCard(controller, order);
          },
        );
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
                color: ColorConstants.scaffoldBackgroundLight,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_bag_outlined, size: 56.sp, color: ColorConstants.textTertiary),
            ),
            SizedBox(height: 24.h),
            Text(
              'No orders found',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
            ),
            SizedBox(height: 8.h),
            Text(
              'Start shopping to see your orders here',
              style: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.accentOrange,
                foregroundColor: ColorConstants.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                elevation: 0,
              ),
              child: Text('Browse Products', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrdersController controller, Map<String, dynamic> order) {
    final statusColor = _getStatusColor(order['status']);
    final items = List<Map<String, dynamic>>.from(order['items']);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
                ),
                _buildStatusBadge(order['status'], statusColor),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 12.sp, color: ColorConstants.textTertiary),
                SizedBox(width: 4.w),
                Text(
                  order['date'],
                  style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 50.w,
                    height: 50.h,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(items[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${items.length} item${items.length > 1 ? 's' : ''}',
                  style: TextStyle(fontSize: 13.sp, color: ColorConstants.textSecondary),
                ),
                Text(
                  '\$${order['total'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w800, color: ColorConstants.textPrimary),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                if (order['status'] == 'shipped' || order['status'] == 'processing')
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: OutlinedButton(
                        onPressed: () => Get.toNamed('${AppRoutes.orders}/${order['id']}'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ColorConstants.accentOrange),
                          foregroundColor: ColorConstants.accentOrange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        child: Text('Track Order', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                if (order['status'] == 'shipped' || order['status'] == 'processing') SizedBox(width: 8.w),
                if (order['status'] == 'delivered' || order['status'] == 'cancelled')
                  Expanded(
                    child: SizedBox(
                      height: 38.h,
                      child: ElevatedButton(
                        onPressed: () => controller.reorder(order['id']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.accentOrange,
                          foregroundColor: ColorConstants.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                          elevation: 0,
                        ),
                        child: Text('Reorder', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                if (order['status'] == 'delivered' || order['status'] == 'cancelled') SizedBox(width: 8.w),
                Expanded(
                  child: SizedBox(
                    height: 38.h,
                    child: TextButton(
                      onPressed: () => Get.toNamed('${AppRoutes.orders}/${order['id']}'),
                      child: Text(
                        'View Details',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: ColorConstants.textSecondary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return ColorConstants.accentGreen;
      case 'shipped':
        return ColorConstants.accentBlue;
      case 'processing':
        return ColorConstants.accentOrange;
      case 'cancelled':
        return ColorConstants.error;
      default:
        return ColorConstants.textTertiary;
    }
  }
}
