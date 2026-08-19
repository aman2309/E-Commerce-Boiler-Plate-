import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/modules/cart/cart_controller.dart';

class CheckoutController extends GetxController {
  final currentStep = 0.obs;
  final isLoading = false.obs;

  final selectedAddressIndex = 0.obs;
  final addresses = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'John Doe',
      'phone': '+1 (555) 123-4567',
      'addressLine1': '123 Main Street',
      'addressLine2': 'Apt 4B',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10001',
      'country': 'United States',
      'isDefault': true,
    },
    {
      'id': '2',
      'name': 'John Doe',
      'phone': '+1 (555) 123-4567',
      'addressLine1': '456 Office Blvd',
      'addressLine2': 'Suite 200',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10002',
      'country': 'United States',
      'isDefault': false,
    },
  ].obs;

  final selectedDeliveryMethod = 'standard'.obs;
  final deliveryOptions = <Map<String, dynamic>>[
    {
      'id': 'standard',
      'name': 'Standard Delivery',
      'description': '5-7 business days',
      'price': 5.99,
      'freeOver50': true,
      'icon': Icons.local_shipping_outlined,
    },
    {
      'id': 'express',
      'name': 'Express Delivery',
      'description': '2-3 business days',
      'price': 9.99,
      'freeOver50': false,
      'icon': Icons.speed,
    },
    {
      'id': 'nextday',
      'name': 'Next Day Delivery',
      'description': '1 business day',
      'price': 14.99,
      'freeOver50': false,
      'icon': Icons.bolt,
    },
  ];

  final selectedPaymentMethod = 'cod'.obs;
  final paymentMethods = <Map<String, dynamic>>[
    {
      'id': 'card',
      'name': 'Credit/Debit Card',
      'description': 'Visa, Mastercard, AMEX',
      'icon': Icons.credit_card,
    },
    {
      'id': 'cod',
      'name': 'Cash on Delivery',
      'description': 'Pay when you receive',
      'icon': Icons.money,
    },
    {
      'id': 'wallet',
      'name': 'Digital Wallet',
      'description': 'Apple Pay, Google Pay',
      'icon': Icons.account_balance_wallet,
    },
  ];

  Map<String, dynamic> get selectedAddress =>
      addresses.isNotEmpty ? addresses[selectedAddressIndex.value] : {};

  double get deliveryCharge {
    final method = deliveryOptions.firstWhere(
      (e) => e['id'] == selectedDeliveryMethod.value,
      orElse: () => deliveryOptions[0],
    );
    final cartController = Get.find<CartController>();
    if (method['freeOver50'] && cartController.subtotal >= 50) {
      return 0.0;
    }
    return method['price'] as double;
  }

  double get subtotal {
    final cartController = Get.find<CartController>();
    return cartController.subtotal;
  }

  double get discount {
    final cartController = Get.find<CartController>();
    return cartController.discount.value;
  }

  double get tax {
    final cartController = Get.find<CartController>();
    return cartController.tax.value;
  }

  double get total {
    return subtotal - discount + deliveryCharge + tax;
  }

  List<Map<String, dynamic>> get cartItems {
    final cartController = Get.find<CartController>();
    return cartController.cartItems.toList();
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void selectAddress(int index) {
    if (index < addresses.length) {
      selectedAddressIndex.value = index;
    }
  }

  void addNewAddress() {
    Get.toNamed('/checkout/add-address');
  }

  void selectDelivery(String method) {
    selectedDeliveryMethod.value = method;
  }

  void selectPayment(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> placeOrder() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      final cartController = Get.find<CartController>();
      cartController.clearCart();
      Get.offAllNamed('/order-confirmation');
      Get.snackbar(
        'Order Placed!',
        'Your order has been placed successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
