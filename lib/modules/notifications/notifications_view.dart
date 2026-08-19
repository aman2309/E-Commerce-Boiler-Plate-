import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'notifications_controller.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

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
          'Notifications',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
        ),
        centerTitle: true,
        actions: [
          Obx(() => controller.notifications.isNotEmpty
              ? TextButton(
                  onPressed: controller.markAllAsRead,
                  child: Text(
                    'Mark all read',
                    style: TextStyle(fontSize: 13.sp, color: ColorConstants.accentOrange),
                  ),
                )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            if (controller.unreadCount > 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                color: ColorConstants.accentOrange.withValues(alpha: 0.05),
                child: Text(
                  '${controller.unreadCount} unread notification${controller.unreadCount > 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return _buildNotificationItem(context, controller, notification, index);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
            child: Icon(Icons.notifications_none, size: 56.sp, color: ColorConstants.textTertiary),
          ),
          SizedBox(height: 24.h),
          Text(
            'No notifications',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            "You're all caught up!",
            style: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationsController controller,
    Map<String, dynamic> notification,
    int index,
  ) {
    final isRead = notification['isRead'] == true;
    final typeData = _getTypeData(notification['type']);

    return Dismissible(
      key: Key(notification['id'].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        color: ColorConstants.error,
        child: const Icon(Icons.delete, color: ColorConstants.white),
      ),
      onDismissed: (_) => controller.deleteNotification(index),
      child: InkWell(
        onTap: () => controller.markAsRead(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isRead ? ColorConstants.white : ColorConstants.accentOrange.withValues(alpha: 0.03),
            border: const Border(
              bottom: BorderSide(color: ColorConstants.divider, width: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: typeData['color'].withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(typeData['icon'], color: typeData['color'], size: 20.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                              color: ColorConstants.textPrimary,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: ColorConstants.accentOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification['body'],
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: ColorConstants.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      notification['time'],
                      style: TextStyle(fontSize: 11.sp, color: ColorConstants.textTertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getTypeData(String type) {
    switch (type) {
      case 'order':
        return {'icon': Icons.local_shipping_outlined, 'color': ColorConstants.accentBlue};
      case 'promotion':
        return {'icon': Icons.local_offer_outlined, 'color': ColorConstants.accentOrange};
      case 'system':
        return {'icon': Icons.info_outline, 'color': ColorConstants.accentPurple};
      default:
        return {'icon': Icons.notifications_outlined, 'color': ColorConstants.textTertiary};
    }
  }
}
