import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final isLoading = true.obs;
  final product = <String, dynamic>{}.obs;
  final selectedImageIndex = 0.obs;
  final selectedSize = ''.obs;
  final selectedColor = ''.obs;
  final quantity = 1.obs;
  final isWishlisted = false.obs;
  final isDescriptionExpanded = false.obs;
  final isSpecificationsExpanded = false.obs;
  final relatedProducts = <Map<String, dynamic>>[].obs;
  final reviews = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final productId = Get.arguments as String? ?? '1';
    loadProduct(productId);
  }

  void loadProduct(String id) {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      product.value = _sampleProduct(id);
      relatedProducts.value = _sampleRelatedProducts();
      reviews.value = _sampleReviews();
      if (product['sizes'] != null && (product['sizes'] as List).isNotEmpty) {
        selectedSize.value = (product['sizes'] as List).first.toString();
      }
      if (product['colors'] != null && (product['colors'] as List).isNotEmpty) {
        selectedColor.value = (product['colors'] as List).first['name'] ?? '';
      }
      isLoading.value = false;
    });
  }

  void incrementQuantity() {
    if (quantity.value < (product['stock'] ?? 10)) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
    Get.snackbar(
      isWishlisted.value ? 'Added to Wishlist' : 'Removed from Wishlist',
      product['name'] ?? '',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void addToCart() {
    Get.snackbar(
      'Added to Cart',
      '${product['name']} (x${quantity.value})',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      mainButton: TextButton(
        onPressed: () => Get.toNamed('/cart'),
        child: const Text('View Cart'),
      ),
    );
  }

  void buyNow() {
    Get.snackbar(
      'Proceeding to Checkout',
      '${product['name']} (x${quantity.value})',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(String color) {
    selectedColor.value = color;
  }

  void shareProduct() {
    Get.snackbar(
      'Share',
      'Share link copied to clipboard!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void toggleDescription() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
  }

  void toggleSpecifications() {
    isSpecificationsExpanded.value = !isSpecificationsExpanded.value;
  }

  Map<String, dynamic> _sampleProduct(String id) {
    return {
      'id': id,
      'name': 'Wireless Bluetooth Headphones Pro Max',
      'brand': 'SoundMax',
      'category': 'Electronics',
      'price': 3999.0,
      'salePrice': 2499.0,
      'discount': 37,
      'rating': 4.5,
      'reviewCount': 2341,
      'inStock': true,
      'stock': 15,
      'images': [
        'https://picsum.photos/seed/hp1/800/800',
        'https://picsum.photos/seed/hp2/800/800',
        'https://picsum.photos/seed/hp3/800/800',
        'https://picsum.photos/seed/hp4/800/800',
      ],
      'sizes': ['One Size'],
      'colors': [
        {'name': 'Midnight Black', 'hex': '#000000'},
        {'name': 'Pearl White', 'hex': '#F5F5F5'},
        {'name': 'Ocean Blue', 'hex': '#0066CC'},
      ],
      'description':
          'Experience premium sound quality with our Wireless Bluetooth Headphones Pro Max. Featuring active noise cancellation, 40-hour battery life, and ultra-comfortable memory foam ear cushions. Designed for audiophiles who demand nothing but the best. With Bluetooth 5.3 technology, enjoy seamless connectivity across all your devices.',
      'specifications': {
        'Connectivity': 'Bluetooth 5.3',
        'Battery Life': '40 Hours',
        'Charging Time': '2 Hours',
        'Weight': '250g',
        'Driver Size': '40mm',
        'Frequency Response': '20Hz - 20kHz',
        'Noise Cancellation': 'Active (ANC)',
        'Water Resistance': 'IPX4',
      },
    };
  }

  List<Map<String, dynamic>> _sampleRelatedProducts() {
    return [
      {
        'id': '11',
        'name': 'Wireless Earbuds Mini',
        'brand': 'SoundMax',
        'price': 1999.0,
        'salePrice': 1299.0,
        'discount': 35,
        'rating': 4.3,
        'image': 'https://picsum.photos/seed/earbuds/400/400',
      },
      {
        'id': '21',
        'name': 'Portable Bluetooth Speaker',
        'brand': 'SoundMax',
        'price': 2499.0,
        'salePrice': 1699.0,
        'discount': 32,
        'rating': 4.5,
        'image': 'https://picsum.photos/seed/speaker/400/400',
      },
      {
        'id': '31',
        'name': 'USB-C Fast Charger',
        'brand': 'ChargeTech',
        'price': 1499.0,
        'salePrice': 999.0,
        'discount': 33,
        'rating': 4.4,
        'image': 'https://picsum.photos/seed/charger3/400/400',
      },
      {
        'id': '41',
        'name': 'Audio Cable Premium',
        'brand': 'SoundMax',
        'price': 599.0,
        'salePrice': 399.0,
        'discount': 33,
        'rating': 4.2,
        'image': 'https://picsum.photos/seed/cable/400/400',
      },
      {
        'id': '51',
        'name': 'Headphone Stand',
        'brand': 'TechGear',
        'price': 899.0,
        'salePrice': 599.0,
        'discount': 33,
        'rating': 4.1,
        'image': 'https://picsum.photos/seed/stand/400/400',
      },
    ];
  }

  List<Map<String, dynamic>> _sampleReviews() {
    return [
      {
        'id': 1,
        'userName': 'Arjun M.',
        'rating': 5.0,
        'date': '2026-08-10',
        'title': 'Best headphones I have ever owned!',
        'comment':
            'The sound quality is absolutely incredible. The noise cancellation works flawlessly and the battery life is as advertised. Very comfortable for long listening sessions.',
        'helpful': 124,
      },
      {
        'id': 2,
        'userName': 'Priya S.',
        'rating': 4.0,
        'date': '2026-08-05',
        'title': 'Great value for money',
        'comment':
            'Solid headphones with great bass and clear highs. The only reason I am not giving 5 stars is that the carrying case could be better quality.',
        'helpful': 87,
      },
      {
        'id': 3,
        'userName': 'Rohan K.',
        'rating': 5.0,
        'date': '2026-07-28',
        'title': 'Perfect for work from home',
        'comment':
            'These headphones have become essential for my work calls. The microphone quality is crystal clear and colleagues can hear me perfectly.',
        'helpful': 65,
      },
      {
        'id': 4,
        'userName': 'Sneha D.',
        'rating': 4.0,
        'date': '2026-07-20',
        'title': 'Good but heavy',
        'comment':
            'Sound quality is top notch but they are a bit heavy for wearing all day. Otherwise excellent product.',
        'helpful': 42,
      },
      {
        'id': 5,
        'userName': 'Vikram P.',
        'rating': 3.0,
        'date': '2026-07-15',
        'title': 'Average build quality',
        'comment':
            'The sound is good but I expected better build quality at this price point. The plastic feels a bit cheap.',
        'helpful': 31,
      },
    ];
  }
}
