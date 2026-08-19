import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final isLoading = false.obs;
  final notifications = <Map<String, dynamic>>[].obs;

  int get unreadCount => notifications.where((n) => n['isRead'] == false).length;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;
    notifications.value = [
      {
        'id': 1,
        'type': 'order',
        'title': 'Order Shipped',
        'body': 'Your order #1002 has been shipped and is on its way to you.',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'id': 2,
        'type': 'promotion',
        'title': 'Flash Sale - 50% Off',
        'body': 'Limited time offer! Get up to 50% off on selected items. Shop now!',
        'time': '5 hours ago',
        'isRead': false,
      },
      {
        'id': 3,
        'type': 'order',
        'title': 'Order Delivered',
        'body': 'Your order #1001 has been delivered successfully.',
        'time': '1 day ago',
        'isRead': true,
      },
      {
        'id': 4,
        'type': 'system',
        'title': 'Security Alert',
        'body': 'A new login was detected from Chrome on macOS. If this wasn\'t you, please change your password.',
        'time': '2 days ago',
        'isRead': false,
      },
      {
        'id': 5,
        'type': 'promotion',
        'title': 'New Arrivals',
        'body': 'Check out our latest collection of wireless earbuds and accessories.',
        'time': '3 days ago',
        'isRead': true,
      },
      {
        'id': 6,
        'type': 'order',
        'title': 'Order Confirmed',
        'body': 'Your order #1003 has been confirmed and is being processed.',
        'time': '4 days ago',
        'isRead': true,
      },
      {
        'id': 7,
        'type': 'system',
        'title': 'App Update Available',
        'body': 'Version 2.0 is now available with exciting new features. Update now!',
        'time': '5 days ago',
        'isRead': false,
      },
      {
        'id': 8,
        'type': 'promotion',
        'title': 'Weekend Special',
        'body': 'Free shipping on all orders this weekend. Use code FREESHIP at checkout.',
        'time': '1 week ago',
        'isRead': true,
      },
    ];
    isLoading.value = false;
  }

  void markAsRead(int index) {
    notifications[index]['isRead'] = true;
    notifications.refresh();
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
    Get.snackbar('Done', 'All notifications marked as read',
        snackPosition: SnackPosition.BOTTOM);
  }

  void deleteNotification(int index) {
    notifications.removeAt(index);
    Get.snackbar('Deleted', 'Notification removed',
        snackPosition: SnackPosition.BOTTOM);
  }

  void clearAll() {
    notifications.clear();
    Get.snackbar('Cleared', 'All notifications cleared',
        snackPosition: SnackPosition.BOTTOM);
  }
}
