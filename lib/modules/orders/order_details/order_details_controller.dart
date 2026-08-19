import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  final isLoading = false.obs;
  final order = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final id = Get.parameters['id'] ?? '1001';
    loadOrder(id);
  }

  void loadOrder(String id) {
    isLoading.value = true;
    order.value = {
      'id': int.tryParse(id) ?? 1001,
      'date': '2026-08-15',
      'status': 'shipped',
      'trackingNumber': 'TRK-2026-1001',
      'items': [
        {
          'name': 'Wireless Headphones Pro',
          'image': 'https://picsum.photos/seed/hp1/200/200',
          'price': 79.99,
          'quantity': 1,
        },
        {
          'name': 'Premium Phone Case',
          'image': 'https://picsum.photos/seed/case1/200/200',
          'price': 19.99,
          'quantity': 2,
        },
        {
          'name': 'USB-C Charging Cable',
          'image': 'https://picsum.photos/seed/cable2/200/200',
          'price': 12.99,
          'quantity': 1,
        },
      ],
      'subtotal': 132.96,
      'shipping': 5.99,
      'tax': 10.64,
      'discount': -15.00,
      'total': 134.59,
      'address': {
        'name': 'John Doe',
        'street': '123 Main Street',
        'city': 'New York',
        'state': 'NY',
        'zip': '10001',
        'country': 'USA',
        'phone': '+1 234 567 890',
      },
      'payment': {
        'method': 'Credit Card',
        'cardLast4': '4242',
        'status': 'Paid',
      },
      'timeline': [
        {'title': 'Order Placed', 'date': 'Aug 15, 2026 - 10:30 AM', 'completed': true},
        {'title': 'Processing', 'date': 'Aug 15, 2026 - 02:15 PM', 'completed': true},
        {'title': 'Shipped', 'date': 'Aug 16, 2026 - 09:00 AM', 'completed': true},
        {'title': 'Out for Delivery', 'date': '', 'completed': false},
        {'title': 'Delivered', 'date': '', 'completed': false},
      ],
    };
    isLoading.value = false;
  }

  void cancelOrder() {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          TextButton(
            onPressed: () {
              order['status'] = 'cancelled';
              order.refresh();
              Get.back();
              Get.snackbar('Order Cancelled', 'Your order has been cancelled successfully',
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void reorder() {
    Get.snackbar(
      'Reorder',
      'Items have been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void trackOrder() {
    final tracking = order['trackingNumber'] ?? '';
    if (tracking.isNotEmpty) {
      Get.snackbar(
        'Tracking',
        'Tracking number: $tracking',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void contactSupport() {
    Get.snackbar(
      'Support',
      'Connecting you with customer support...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
