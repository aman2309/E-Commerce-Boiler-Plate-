import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/modules/cart/cart_controller.dart';

class WishlistController extends GetxController {
  final isLoading = false.obs;

  final wishlistItems = <Map<String, dynamic>>[
    {
      'id': '101',
      'name': 'Classic Hoodie',
      'image': 'https://picsum.photos/200/200?random=101',
      'price': 49.99,
    },
    {
      'id': '102',
      'name': 'Denim Jacket',
      'image': 'https://picsum.photos/200/200?random=102',
      'price': 79.99,
    },
    {
      'id': '103',
      'name': 'Sport Watch',
      'image': 'https://picsum.photos/200/200?random=103',
      'price': 129.99,
    },
    {
      'id': '104',
      'name': 'Canvas Backpack',
      'image': 'https://picsum.photos/200/200?random=104',
      'price': 39.99,
    },
  ].obs;

  int get itemCount => wishlistItems.length;

  void removeFromWishlist(int index) {
    if (index < wishlistItems.length) {
      final item = wishlistItems[index];
      wishlistItems.removeAt(index);
      update();
      Get.snackbar(
        'Removed',
        '${item['name']} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void addToWishlist(Map<String, dynamic> item) {
    final exists = wishlistItems.any((e) => e['id'] == item['id']);
    if (!exists) {
      wishlistItems.add({
        'id': item['id'],
        'name': item['name'],
        'image': item['image'],
        'price': item['price'],
      });
      update();
    }
  }

  void moveToCart(int index) {
    if (index < wishlistItems.length) {
      final item = wishlistItems[index];
      final cartController = Get.find<CartController>();
      cartController.cartItems.add({
        'id': item['id'],
        'name': item['name'],
        'image': item['image'],
        'size': 'M',
        'color': 'Default',
        'price': item['price'],
        'quantity': 1,
      });
      wishlistItems.removeAt(index);
      update();
      Get.snackbar(
        'Moved',
        'Item moved to cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    }
  }
}
