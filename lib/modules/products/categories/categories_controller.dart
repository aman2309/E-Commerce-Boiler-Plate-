import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final isLoading = true.obs;
  final categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      categories.value = _sampleCategories();
      isLoading.value = false;
    });
  }

  List<Map<String, dynamic>> _sampleCategories() {
    return [
      {
        'id': 1,
        'name': 'Electronics',
        'icon': Icons.devices,
        'color': Colors.blue,
        'productCount': 1250,
      },
      {
        'id': 2,
        'name': 'Fashion',
        'icon': Icons.checkroom,
        'color': Colors.pink,
        'productCount': 3420,
      },
      {
        'id': 3,
        'name': 'Home & Garden',
        'icon': Icons.home_outlined,
        'color': Colors.green,
        'productCount': 980,
      },
      {
        'id': 4,
        'name': 'Sports',
        'icon': Icons.sports_soccer,
        'color': Colors.orange,
        'productCount': 756,
      },
      {
        'id': 5,
        'name': 'Beauty',
        'icon': Icons.face_retouching_natural,
        'color': Colors.purple,
        'productCount': 1890,
      },
      {
        'id': 6,
        'name': 'Kids',
        'icon': Icons.child_care,
        'color': Colors.teal,
        'productCount': 567,
      },
      {
        'id': 7,
        'name': 'Books',
        'icon': Icons.menu_book,
        'color': Colors.brown,
        'productCount': 4500,
      },
      {
        'id': 8,
        'name': 'Automotive',
        'icon': Icons.directions_car,
        'color': Colors.red,
        'productCount': 430,
      },
      {
        'id': 9,
        'name': 'Grocery',
        'icon': Icons.local_grocery_store,
        'color': Colors.lightGreen,
        'productCount': 2100,
      },
      {
        'id': 10,
        'name': 'Toys',
        'icon': Icons.toys,
        'color': Colors.amber,
        'productCount': 890,
      },
    ];
  }
}
