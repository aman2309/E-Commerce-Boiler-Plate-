import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/modules/checkout/checkout_controller.dart';

class AddAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();

  final selectedCountry = 'United States'.obs;
  final isDefault = false.obs;

  final countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'India',
    'Brazil',
    'Mexico',
  ];

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^[\+]?[0-9\s\-\(\)]{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateAddressLine1(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your address';
    }
    if (value.trim().length < 5) {
      return 'Address must be at least 5 characters';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your state';
    }
    return null;
  }

  String? validateZipCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your zip code';
    }
    if (value.trim().length < 3) {
      return 'Please enter a valid zip code';
    }
    return null;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> saveAddress() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));

      final newAddress = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'addressLine1': addressLine1Controller.text.trim(),
        'addressLine2': addressLine2Controller.text.trim(),
        'city': cityController.text.trim(),
        'state': stateController.text.trim(),
        'zipCode': zipCodeController.text.trim(),
        'country': selectedCountry.value,
        'isDefault': isDefault.value,
      };

      final checkoutController = Get.find<CheckoutController>();
      if (isDefault.value) {
        for (var addr in checkoutController.addresses) {
          addr['isDefault'] = false;
        }
      }
      checkoutController.addresses.add(newAddress);

      Get.back();
      Get.snackbar(
        'Success',
        'Address saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save address. Please try again.',
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
