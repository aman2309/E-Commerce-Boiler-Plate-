import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSearchController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final recentSearches = <String>[].obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final isSearching = false.obs;
  final popularSearches = [
    'Headphones',
    'Shoes',
    'Watch',
    'Shirt',
    'Bag',
    'Sunglasses',
    'Laptop',
    'Camera',
  ].obs;

  Timer? _debouncer;

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
  }

  @override
  void onClose() {
    _debouncer?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _performSearch(query);
      } else {
        searchResults.clear();
      }
    });
  }

  void onSearchSubmitted(String query) {
    if (query.isEmpty) return;
    _debouncer?.cancel();
    _performSearch(query);
    _addToRecentSearches(query);
  }

  void _performSearch(String query) {
    isSearching.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      final results = _sampleProducts()
          .where((p) =>
              p['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              p['brand']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              p['category']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      searchResults.value = results;
      isSearching.value = false;
    });
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    searchResults.clear();
  }

  void removeRecentSearch(String search) {
    recentSearches.remove(search);
    _saveRecentSearches();
  }

  void clearAllRecentSearches() {
    recentSearches.clear();
    _saveRecentSearches();
  }

  void _addToRecentSearches(String query) {
    if (query.trim().isEmpty) return;
    recentSearches.removeWhere(
        (s) => s.toLowerCase() == query.toLowerCase());
    recentSearches.insert(0, query.trim());
    if (recentSearches.length > 10) {
      recentSearches.removeLast();
    }
    _saveRecentSearches();
  }

  void _loadRecentSearches() {
    recentSearches.value = [
      'Wireless headphones',
      'Cotton shirt',
      'Running shoes',
      'Smart watch',
    ];
  }

  void _saveRecentSearches() {}

  List<Map<String, dynamic>> _sampleProducts() {
    return [
      {
        'id': 1,
        'name': 'Wireless Bluetooth Headphones Pro',
        'brand': 'SoundMax',
        'category': 'Electronics',
        'price': 2999.0,
        'salePrice': 1799.0,
        'discount': 40,
        'rating': 4.5,
        'image': 'https://picsum.photos/seed/headphones/400/400',
      },
      {
        'id': 2,
        'name': 'Premium Cotton Casual Shirt',
        'brand': 'StyleCraft',
        'category': 'Fashion',
        'price': 1599.0,
        'salePrice': 999.0,
        'discount': 37,
        'rating': 4.2,
        'image': 'https://picsum.photos/seed/shirt/400/400',
      },
      {
        'id': 3,
        'name': 'Smart Fitness Watch Ultra',
        'brand': 'TechFit',
        'category': 'Electronics',
        'price': 5999.0,
        'salePrice': 3999.0,
        'discount': 33,
        'rating': 4.7,
        'image': 'https://picsum.photos/seed/watch/400/400',
      },
      {
        'id': 5,
        'name': 'Stainless Steel Water Bottle',
        'brand': 'HydroLife',
        'category': 'Sports',
        'price': 699.0,
        'salePrice': 499.0,
        'discount': 28,
        'rating': 4.6,
        'image': 'https://picsum.photos/seed/bottle/400/400',
      },
      {
        'id': 10,
        'name': 'Yoga Mat Premium Non-Slip',
        'brand': 'ZenFit',
        'category': 'Sports',
        'price': 1499.0,
        'salePrice': 999.0,
        'discount': 33,
        'rating': 4.6,
        'image': 'https://picsum.photos/seed/yogamat/400/400',
      },
      {
        'id': 12,
        'name': 'Denim Jacket Vintage Wash',
        'brand': 'StyleCraft',
        'category': 'Fashion',
        'price': 2999.0,
        'salePrice': 1999.0,
        'discount': 33,
        'rating': 4.4,
        'image': 'https://picsum.photos/seed/jacket/400/400',
      },
      {
        'id': 20,
        'name': 'Running Shoes Lightweight',
        'brand': 'SportStep',
        'category': 'Sports',
        'price': 3999.0,
        'salePrice': 2799.0,
        'discount': 30,
        'rating': 4.7,
        'image': 'https://picsum.photos/seed/shoes/400/400',
      },
      {
        'id': 21,
        'name': 'Portable Bluetooth Speaker',
        'brand': 'SoundMax',
        'category': 'Electronics',
        'price': 2499.0,
        'salePrice': 1699.0,
        'discount': 32,
        'rating': 4.5,
        'image': 'https://picsum.photos/seed/speaker/400/400',
      },
    ];
  }
}
