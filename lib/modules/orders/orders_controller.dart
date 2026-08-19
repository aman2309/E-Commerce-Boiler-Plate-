import 'package:get/get.dart';

class OrdersController extends GetxController {
  final isLoading = false.obs;
  final selectedTab = 'all'.obs;
  final orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    isLoading.value = true;
    orders.value = [
      {
        'id': 1001,
        'date': '2026-08-15',
        'status': 'delivered',
        'items': [
          {
            'name': 'Wireless Headphones',
            'image': 'https://picsum.photos/seed/hp1/100/100',
            'price': 79.99,
            'quantity': 1,
          },
          {
            'name': 'Phone Case',
            'image': 'https://picsum.photos/seed/case1/100/100',
            'price': 19.99,
            'quantity': 2,
          },
        ],
        'total': 119.97,
        'address': '123 Main St, New York, NY 10001',
        'trackingNumber': 'TRK-2026-1001',
      },
      {
        'id': 1002,
        'date': '2026-08-17',
        'status': 'shipped',
        'items': [
          {
            'name': 'Running Shoes',
            'image': 'https://picsum.photos/seed/shoe1/100/100',
            'price': 129.99,
            'quantity': 1,
          },
        ],
        'total': 129.99,
        'address': '456 Oak Ave, Los Angeles, CA 90001',
        'trackingNumber': 'TRK-2026-1002',
      },
      {
        'id': 1003,
        'date': '2026-08-18',
        'status': 'processing',
        'items': [
          {
            'name': 'Smart Watch',
            'image': 'https://picsum.photos/seed/watch1/100/100',
            'price': 249.99,
            'quantity': 1,
          },
          {
            'name': 'Watch Band',
            'image': 'https://picsum.photos/seed/band1/100/100',
            'price': 24.99,
            'quantity': 1,
          },
          {
            'name': 'Screen Protector',
            'image': 'https://picsum.photos/seed/prot1/100/100',
            'price': 9.99,
            'quantity': 2,
          },
        ],
        'total': 294.96,
        'address': '789 Pine Rd, Chicago, IL 60601',
        'trackingNumber': '',
      },
      {
        'id': 1004,
        'date': '2026-08-19',
        'status': 'cancelled',
        'items': [
          {
            'name': 'Laptop Stand',
            'image': 'https://picsum.photos/seed/stand1/100/100',
            'price': 49.99,
            'quantity': 1,
          },
        ],
        'total': 49.99,
        'address': '321 Elm St, Houston, TX 77001',
        'trackingNumber': '',
      },
      {
        'id': 1005,
        'date': '2026-08-14',
        'status': 'delivered',
        'items': [
          {
            'name': 'Bluetooth Speaker',
            'image': 'https://picsum.photos/seed/spk1/100/100',
            'price': 59.99,
            'quantity': 1,
          },
          {
            'name': 'USB-C Cable',
            'image': 'https://picsum.photos/seed/cable1/100/100',
            'price': 12.99,
            'quantity': 3,
          },
        ],
        'total': 98.96,
        'address': '654 Maple Dr, Phoenix, AZ 85001',
        'trackingNumber': 'TRK-2026-1005',
      },
    ];
    isLoading.value = false;
  }

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedTab.value == 'all') return orders.toList();
    return orders.where((o) => o['status'] == selectedTab.value).toList();
  }

  void filterByStatus(String status) {
    selectedTab.value = status;
  }

  void reorder(int orderId) {
    Get.snackbar(
      'Reorder',
      'Items from order #$orderId added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void cancelOrder(int orderId) {
    final index = orders.indexWhere((o) => o['id'] == orderId);
    if (index != -1) {
      orders[index]['status'] = 'cancelled';
      orders.refresh();
      Get.snackbar(
        'Order Cancelled',
        'Order #$orderId has been cancelled',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
