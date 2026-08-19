import 'package:get/get.dart';

class ProductListingController extends GetxController {
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final products = <Map<String, dynamic>>[].obs;
  final searchQuery = ''.obs;
  final sortBy = 'popular'.obs;
  final viewMode = 'grid'.obs;
  final selectedCategory = ''.obs;

  int page = 1;
  final int pageSize = 10;
  bool hasMore = true;

  bool get isGridView => viewMode.value == 'grid';

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void toggleViewMode() {
    viewMode.value = viewMode.value == 'grid' ? 'list' : 'grid';
  }

  void loadProducts() {
    isLoading.value = true;
    hasError.value = false;
    page = 1;
    hasMore = true;

    Future.delayed(const Duration(milliseconds: 800), () {
      products.value = _sampleProducts();
      isLoading.value = false;
    });
  }

  void loadMore() {
    if (isLoadingMore.value || !hasMore) return;
    isLoadingMore.value = true;
    page++;

    Future.delayed(const Duration(milliseconds: 600), () {
      final moreProducts = _sampleProducts().map((p) {
        p['id'] = '${p['id']}_$page';
        return p;
      }).toList();
      products.addAll(moreProducts);
      isLoadingMore.value = false;
      if (page >= 5) hasMore = false;
    });
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadProducts();
      return;
    }
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      final results = _sampleProducts()
          .where((p) =>
              p['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
              p['brand']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      products.value = results;
      isLoading.value = false;
    });
  }

  void sortProducts(String sort) {
    sortBy.value = sort;
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      switch (sort) {
        case 'price_low':
          products.sort(
              (a, b) => (a['salePrice'] as num).compareTo(b['salePrice'] as num));
          break;
        case 'price_high':
          products.sort(
              (a, b) => (b['salePrice'] as num).compareTo(a['salePrice'] as num));
          break;
        case 'rating':
          products.sort(
              (a, b) => (b['rating'] as num).compareTo(a['rating'] as num));
          break;
        case 'newest':
          products.sort(
              (a, b) => (b['id'] as int).compareTo(a['id'] as int));
          break;
        default:
          products.sort(
              (a, b) => (b['rating'] as num).compareTo(a['rating'] as num));
      }
      isLoading.value = false;
    });
  }

  void refreshProducts() {
    searchQuery.value = '';
    sortBy.value = 'popular';
    loadProducts();
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      if (category.isEmpty) {
        products.value = _sampleProducts();
      } else {
        products.value = _sampleProducts()
            .where((p) => p['category'] == category)
            .toList();
      }
      isLoading.value = false;
    });
  }

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
        'reviewCount': 2341,
        'image': 'https://picsum.photos/seed/headphones/400/400',
        'inStock': true,
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
        'reviewCount': 876,
        'image': 'https://picsum.photos/seed/shirt/400/400',
        'inStock': true,
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
        'reviewCount': 5432,
        'image': 'https://picsum.photos/seed/watch/400/400',
        'inStock': true,
      },
      {
        'id': 4,
        'name': 'Organic Face Moisturizer',
        'brand': 'GlowNatural',
        'category': 'Beauty',
        'price': 899.0,
        'salePrice': 699.0,
        'discount': 22,
        'rating': 4.3,
        'reviewCount': 1203,
        'image': 'https://picsum.photos/seed/moisturizer/400/400',
        'inStock': true,
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
        'reviewCount': 3456,
        'image': 'https://picsum.photos/seed/bottle/400/400',
        'inStock': true,
      },
      {
        'id': 6,
        'name': 'Kids Building Blocks Set',
        'brand': 'PlayTime',
        'category': 'Kids',
        'price': 1299.0,
        'salePrice': 899.0,
        'discount': 30,
        'rating': 4.8,
        'reviewCount': 2100,
        'image': 'https://picsum.photos/seed/blocks/400/400',
        'inStock': true,
      },
      {
        'id': 7,
        'name': 'Bestselling Mystery Novel',
        'brand': 'BookWorld',
        'category': 'Books',
        'price': 499.0,
        'salePrice': 349.0,
        'discount': 30,
        'rating': 4.4,
        'reviewCount': 6789,
        'image': 'https://picsum.photos/seed/novel/400/400',
        'inStock': true,
      },
      {
        'id': 8,
        'name': 'Car Phone Mount Holder',
        'brand': 'AutoGear',
        'category': 'Automotive',
        'price': 599.0,
        'salePrice': 399.0,
        'discount': 33,
        'rating': 4.1,
        'reviewCount': 1567,
        'image': 'https://picsum.photos/seed/carmount/400/400',
        'inStock': true,
      },
      {
        'id': 9,
        'name': 'Indoor Herb Garden Kit',
        'brand': 'GreenThumb',
        'category': 'Home & Garden',
        'price': 1799.0,
        'salePrice': 1299.0,
        'discount': 27,
        'rating': 4.5,
        'reviewCount': 934,
        'image': 'https://picsum.photos/seed/herb/400/400',
        'inStock': true,
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
        'reviewCount': 4321,
        'image': 'https://picsum.photos/seed/yogamat/400/400',
        'inStock': true,
      },
      {
        'id': 11,
        'name': 'Wireless Charging Pad',
        'brand': 'ChargeTech',
        'category': 'Electronics',
        'price': 1199.0,
        'salePrice': 799.0,
        'discount': 33,
        'rating': 4.3,
        'reviewCount': 2876,
        'image': 'https://picsum.photos/seed/charger/400/400',
        'inStock': true,
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
        'reviewCount': 1234,
        'image': 'https://picsum.photos/seed/jacket/400/400',
        'inStock': true,
      },
      {
        'id': 13,
        'name': 'LED Desk Lamp Adjustable',
        'brand': 'BrightHome',
        'category': 'Home & Garden',
        'price': 2499.0,
        'salePrice': 1699.0,
        'discount': 32,
        'rating': 4.7,
        'reviewCount': 1890,
        'image': 'https://picsum.photos/seed/desklamp/400/400',
        'inStock': true,
      },
      {
        'id': 14,
        'name': 'Matte Lipstick Collection',
        'brand': 'GlowNatural',
        'category': 'Beauty',
        'price': 799.0,
        'salePrice': 599.0,
        'discount': 25,
        'rating': 4.2,
        'reviewCount': 3456,
        'image': 'https://picsum.photos/seed/lipstick/400/400',
        'inStock': true,
      },
      {
        'id': 15,
        'name': 'Remote Control Racing Car',
        'brand': 'PlayTime',
        'category': 'Toys',
        'price': 2199.0,
        'salePrice': 1599.0,
        'discount': 27,
        'rating': 4.5,
        'reviewCount': 2345,
        'image': 'https://picsum.photos/seed/rccar/400/400',
        'inStock': true,
      },
      {
        'id': 16,
        'name': 'Coffee Table Book - Travel',
        'brand': 'BookWorld',
        'category': 'Books',
        'price': 1299.0,
        'salePrice': 899.0,
        'discount': 30,
        'rating': 4.3,
        'reviewCount': 567,
        'image': 'https://picsum.photos/seed/coffeebook/400/400',
        'inStock': true,
      },
      {
        'id': 17,
        'name': 'Car Air Freshener Pack',
        'brand': 'AutoGear',
        'category': 'Automotive',
        'price': 299.0,
        'salePrice': 199.0,
        'discount': 33,
        'rating': 4.0,
        'reviewCount': 4567,
        'image': 'https://picsum.photos/seed/airfresh/400/400',
        'inStock': true,
      },
      {
        'id': 18,
        'name': 'Ceramic Plant Pots Set',
        'brand': 'GreenThumb',
        'category': 'Home & Garden',
        'price': 1099.0,
        'salePrice': 799.0,
        'discount': 27,
        'rating': 4.6,
        'reviewCount': 1678,
        'image': 'https://picsum.photos/seed/plantpot/400/400',
        'inStock': false,
      },
      {
        'id': 19,
        'name': 'Resistance Bands Set',
        'brand': 'ZenFit',
        'category': 'Sports',
        'price': 899.0,
        'salePrice': 599.0,
        'discount': 33,
        'rating': 4.4,
        'reviewCount': 5432,
        'image': 'https://picsum.photos/seed/bands/400/400',
        'inStock': true,
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
        'reviewCount': 8765,
        'image': 'https://picsum.photos/seed/shoes/400/400',
        'inStock': true,
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
        'reviewCount': 3210,
        'image': 'https://picsum.photos/seed/speaker/400/400',
        'inStock': true,
      },
      {
        'id': 22,
        'name': 'Silk Scarf Floral Print',
        'brand': 'StyleCraft',
        'category': 'Fashion',
        'price': 999.0,
        'salePrice': 699.0,
        'discount': 30,
        'rating': 4.1,
        'reviewCount': 456,
        'image': 'https://picsum.photos/seed/scarf/400/400',
        'inStock': true,
      },
    ];
  }
}
