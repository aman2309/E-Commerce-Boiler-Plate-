import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/modules/wishlist/wishlist_controller.dart';

class CartController extends GetxController {
  final isLoading = false.obs;
  final cartItems = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'Premium Cotton T-Shirt',
      'image': 'https://picsum.photos/200/200?random=1',
      'size': 'M',
      'color': 'Navy Blue',
      'price': 29.99,
      'quantity': 2,
    },
    {
      'id': '2',
      'name': 'Slim Fit Jeans',
      'image': 'https://picsum.photos/200/200?random=2',
      'size': '32',
      'color': 'Dark Wash',
      'price': 59.99,
      'quantity': 1,
    },
    {
      'id': '3',
      'name': 'Running Sneakers',
      'image': 'https://picsum.photos/200/200?random=3',
      'size': '10',
      'color': 'Black/White',
      'price': 89.99,
      'quantity': 1,
    },
    {
      'id': '4',
      'name': 'Leather Belt',
      'image': 'https://picsum.photos/200/200?random=4',
      'size': 'One Size',
      'color': 'Brown',
      'price': 24.99,
      'quantity': 1,
    },
  ].obs;

  final couponCode = ''.obs;
  final discount = 0.0.obs;
  final deliveryCharge = 5.99.obs;
  final tax = 0.0.obs;

  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      total += (item['price'] as double) * (item['quantity'] as int);
    }
    return total;
  }

  double get total {
    double totalAmount = subtotal - discount.value + deliveryCharge.value + tax.value;
    return totalAmount;
  }

  int get itemCount {
    int count = 0;
    for (var item in cartItems) {
      count += item['quantity'] as int;
    }
    return count;
  }

  @override
  void onInit() {
    super.onInit();
    _calculateTax();
    _calculateDeliveryCharge();
  }

  void _calculateTax() {
    tax.value = subtotal * 0.08;
  }

  void _calculateDeliveryCharge() {
    deliveryCharge.value = subtotal >= 50 ? 0.0 : 5.99;
  }

  void incrementQuantity(int index) {
    if (index < cartItems.length) {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) + 1;
      cartItems.refresh();
      _calculateTax();
      _calculateDeliveryCharge();
      _recalculateDiscount();
      updateCartCount();
    }
  }

  void decrementQuantity(int index) {
    if (index < cartItems.length && (cartItems[index]['quantity'] as int) > 1) {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) - 1;
      cartItems.refresh();
      _calculateTax();
      _calculateDeliveryCharge();
      _recalculateDiscount();
      updateCartCount();
    }
  }

  void removeItem(int index) {
    if (index < cartItems.length) {
      cartItems.removeAt(index);
      _calculateTax();
      _calculateDeliveryCharge();
      _recalculateDiscount();
      updateCartCount();
      Get.snackbar(
        'Removed',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void moveToWishlist(int index) {
    if (index < cartItems.length) {
      final item = cartItems[index];
      final wishlistController = Get.find<WishlistController>();
      wishlistController.addToWishlist(item);
      removeItem(index);
      Get.snackbar(
        'Moved',
        'Item moved to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void applyCoupon(String code) {
    if (code.toUpperCase() == 'SAVE10') {
      couponCode.value = code;
      discount.value = subtotal * 0.10;
      _calculateTax();
      Get.snackbar(
        'Success',
        'Coupon applied! 10% discount',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        'Invalid coupon code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeCoupon() {
    couponCode.value = '';
    discount.value = 0.0;
    _calculateTax();
    Get.snackbar(
      'Removed',
      'Coupon removed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  void _recalculateDiscount() {
    if (couponCode.value.isNotEmpty) {
      if (couponCode.value.toUpperCase() == 'SAVE10') {
        discount.value = subtotal * 0.10;
      }
    }
  }

  double getCartTotal() => total;

  void clearCart() {
    cartItems.clear();
    couponCode.value = '';
    discount.value = 0.0;
    deliveryCharge.value = 5.99;
    tax.value = 0.0;
    updateCartCount();
  }

  void updateCartCount() {
    Get.forceAppUpdate();
  }
}
