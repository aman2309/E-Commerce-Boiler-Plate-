import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final isLoading = true.obs;
  final cartCount = 0.obs;

  final banners = <Map<String, dynamic>>[].obs;
  final categories = <Map<String, dynamic>>[].obs;
  final featuredProducts = <Map<String, dynamic>>[].obs;
  final trendingProducts = <Map<String, dynamic>>[].obs;
  final bestSellers = <Map<String, dynamic>>[].obs;
  final newArrivals = <Map<String, dynamic>>[].obs;
  final topBrands = <Map<String, dynamic>>[].obs;
  final dealOfTheDay = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    banners.value = [
      {
        'id': '1',
        'title': 'Summer Sale',
        'subtitle': 'Up to 70% off on selected items',
        'color': const Color(0xFF6C5CE7),
      },
      {
        'id': '2',
        'title': 'New Arrivals',
        'subtitle': 'Check out the latest trends',
        'color': const Color(0xFF00B894),
      },
      {
        'id': '3',
        'title': 'Free Shipping',
        'subtitle': 'On orders above \$50',
        'color': const Color(0xFFE17055),
      },
    ];

    categories.value = [
      {'id': '1', 'name': 'Electronics', 'icon': Icons.devices, 'color': const Color(0xFF6C5CE7)},
      {'id': '2', 'name': 'Fashion', 'icon': Icons.checkroom, 'color': const Color(0xFFE17055)},
      {'id': '3', 'name': 'Home & Living', 'icon': Icons.home_outlined, 'color': const Color(0xFF00B894)},
      {'id': '4', 'name': 'Sports', 'icon': Icons.sports_soccer, 'color': const Color(0xFF0984E3)},
      {'id': '5', 'name': 'Books', 'icon': Icons.menu_book, 'color': const Color(0xFFFDCB6E)},
      {'id': '6', 'name': 'Beauty', 'icon': Icons.face, 'color': const Color(0xFFE84393)},
      {'id': '7', 'name': 'Toys', 'icon': Icons.toys, 'color': const Color(0xFF00CEC9)},
      {'id': '8', 'name': 'Grocery', 'icon': Icons.shopping_basket, 'color': const Color(0xFF55EFC4)},
    ];

    featuredProducts.value = [
      {'id': '1', 'name': 'Wireless Headphones Pro', 'price': 79.99, 'discountPrice': 59.99, 'rating': 4.8, 'reviews': 2341, 'image': null, 'isFavorite': false},
      {'id': '2', 'name': 'Smart Watch Ultra', 'price': 199.99, 'discountPrice': 149.99, 'rating': 4.6, 'reviews': 1876, 'image': null, 'isFavorite': true},
      {'id': '3', 'name': 'Running Shoes Air', 'price': 129.99, 'discountPrice': 89.99, 'rating': 4.7, 'reviews': 3210, 'image': null, 'isFavorite': false},
      {'id': '4', 'name': 'Laptop Backpack', 'price': 49.99, 'discountPrice': 34.99, 'rating': 4.5, 'reviews': 987, 'image': null, 'isFavorite': false},
      {'id': '5', 'name': 'Bluetooth Speaker', 'price': 59.99, 'discountPrice': 44.99, 'rating': 4.4, 'reviews': 1543, 'image': null, 'isFavorite': true},
      {'id': '6', 'name': 'Gaming Mouse RGB', 'price': 39.99, 'discountPrice': 29.99, 'rating': 4.3, 'reviews': 876, 'image': null, 'isFavorite': false},
      {'id': '7', 'name': 'Mechanical Keyboard', 'price': 89.99, 'discountPrice': 69.99, 'rating': 4.9, 'reviews': 2100, 'image': null, 'isFavorite': false},
      {'id': '8', 'name': 'USB-C Hub Adapter', 'price': 34.99, 'discountPrice': 24.99, 'rating': 4.2, 'reviews': 654, 'image': null, 'isFavorite': false},
    ];

    trendingProducts.value = [
      {'id': '9', 'name': 'Minimalist Watch', 'price': 149.99, 'discountPrice': 119.99, 'rating': 4.7, 'reviews': 1234, 'image': null, 'isFavorite': false},
      {'id': '10', 'name': 'Wireless Earbuds', 'price': 49.99, 'discountPrice': 39.99, 'rating': 4.5, 'reviews': 2567, 'image': null, 'isFavorite': true},
      {'id': '11', 'name': 'Smartphone Stand', 'price': 19.99, 'discountPrice': 14.99, 'rating': 4.3, 'reviews': 890, 'image': null, 'isFavorite': false},
      {'id': '12', 'name': 'Portable Charger', 'price': 29.99, 'discountPrice': 22.99, 'rating': 4.6, 'reviews': 1678, 'image': null, 'isFavorite': false},
      {'id': '13', 'name': 'Noise Cancelling Buds', 'price': 99.99, 'discountPrice': 74.99, 'rating': 4.8, 'reviews': 3456, 'image': null, 'isFavorite': true},
      {'id': '14', 'name': 'Fitness Tracker', 'price': 69.99, 'discountPrice': 49.99, 'rating': 4.4, 'reviews': 1123, 'image': null, 'isFavorite': false},
      {'id': '15', 'name': 'Desk Organizer', 'price': 24.99, 'discountPrice': 19.99, 'rating': 4.2, 'reviews': 567, 'image': null, 'isFavorite': false},
      {'id': '16', 'name': 'LED Desk Lamp', 'price': 39.99, 'discountPrice': 29.99, 'rating': 4.5, 'reviews': 987, 'image': null, 'isFavorite': false},
    ];

    bestSellers.value = [
      {'id': '17', 'name': 'Premium T-Shirt', 'price': 29.99, 'discountPrice': 19.99, 'rating': 4.6, 'reviews': 5432, 'image': null, 'isFavorite': false},
      {'id': '18', 'name': 'Slim Fit Jeans', 'price': 59.99, 'discountPrice': 44.99, 'rating': 4.5, 'reviews': 3210, 'image': null, 'isFavorite': true},
      {'id': '19', 'name': 'Casual Sneakers', 'price': 79.99, 'discountPrice': 59.99, 'rating': 4.7, 'reviews': 4567, 'image': null, 'isFavorite': false},
      {'id': '20', 'name': 'Canvas Backpack', 'price': 44.99, 'discountPrice': 34.99, 'rating': 4.4, 'reviews': 2345, 'image': null, 'isFavorite': false},
      {'id': '21', 'name': 'Aviator Sunglasses', 'price': 39.99, 'discountPrice': 29.99, 'rating': 4.3, 'reviews': 1890, 'image': null, 'isFavorite': false},
      {'id': '22', 'name': 'Leather Wallet', 'price': 34.99, 'discountPrice': 24.99, 'rating': 4.8, 'reviews': 6789, 'image': null, 'isFavorite': true},
      {'id': '23', 'name': 'Analog Wall Clock', 'price': 24.99, 'discountPrice': 19.99, 'rating': 4.2, 'reviews': 1234, 'image': null, 'isFavorite': false},
      {'id': '24', 'name': 'Ceramic Coffee Mug', 'price': 14.99, 'discountPrice': 9.99, 'rating': 4.5, 'reviews': 8901, 'image': null, 'isFavorite': false},
      {'id': '25', 'name': 'Yoga Mat Premium', 'price': 39.99, 'discountPrice': 29.99, 'rating': 4.6, 'reviews': 2345, 'image': null, 'isFavorite': false},
      {'id': '26', 'name': 'Water Bottle Steel', 'price': 19.99, 'discountPrice': 14.99, 'rating': 4.4, 'reviews': 3456, 'image': null, 'isFavorite': false},
    ];

    newArrivals.value = [
      {'id': '27', 'name': 'Smart Home Hub', 'price': 129.99, 'discountPrice': 99.99, 'rating': 4.9, 'reviews': 234, 'image': null, 'isFavorite': false},
      {'id': '28', 'name': 'Wireless Charger Pad', 'price': 29.99, 'discountPrice': 24.99, 'rating': 4.5, 'reviews': 123, 'image': null, 'isFavorite': false},
      {'id': '29', 'name': 'AI Webcam 4K', 'price': 89.99, 'discountPrice': 69.99, 'rating': 4.7, 'reviews': 89, 'image': null, 'isFavorite': true},
      {'id': '30', 'name': 'Ergonomic Mouse', 'price': 49.99, 'discountPrice': 39.99, 'rating': 4.6, 'reviews': 156, 'image': null, 'isFavorite': false},
      {'id': '31', 'name': 'Smart Plug Mini', 'price': 14.99, 'discountPrice': 9.99, 'rating': 4.3, 'reviews': 678, 'image': null, 'isFavorite': false},
      {'id': '32', 'name': 'RGB Light Strip', 'price': 19.99, 'discountPrice': 14.99, 'rating': 4.4, 'reviews': 345, 'image': null, 'isFavorite': false},
      {'id': '33', 'name': 'Digital Photo Frame', 'price': 79.99, 'discountPrice': 59.99, 'rating': 4.8, 'reviews': 167, 'image': null, 'isFavorite': false},
      {'id': '34', 'name': 'Portable Projector', 'price': 199.99, 'discountPrice': 149.99, 'rating': 4.5, 'reviews': 234, 'image': null, 'isFavorite': true},
    ];

    topBrands.value = [
      {'id': '1', 'name': 'Apple', 'icon': Icons.phone_iphone},
      {'id': '2', 'name': 'Samsung', 'icon': Icons.phone_android},
      {'id': '3', 'name': 'Nike', 'icon': Icons.sports_basketball},
      {'id': '4', 'name': 'Adidas', 'icon': Icons.sports_soccer},
      {'id': '5', 'name': 'Sony', 'icon': Icons.headphones},
      {'id': '6', 'name': 'LG', 'icon': Icons.tv},
      {'id': '7', 'name': 'Puma', 'icon': Icons.run_circle},
      {'id': '8', 'name': 'Bose', 'icon': Icons.surround_sound},
    ];

    dealOfTheDay.value = {
      'id': '35',
      'name': 'Ultra HD Smart TV 55"',
      'price': 699.99,
      'discountPrice': 399.99,
      'rating': 4.8,
      'reviews': 4567,
      'image': null,
      'isFavorite': false,
      'discount': 43,
      'hours': 5,
      'minutes': 23,
      'seconds': 47,
    };

    cartCount.value = 3;
    isLoading.value = false;
  }
}
