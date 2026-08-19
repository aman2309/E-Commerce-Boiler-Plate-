import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/theme/app_text_styles.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/widgets/product_card.dart';
import 'package:flutter_boilerplate/modules/products/search/search_controller.dart'
    as app_search;
import 'package:flutter_boilerplate/modules/products/product_listing_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(app_search.AppSearchController());

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
          style: AppTextStyles.bodyMedium,
          onChanged: controller.onSearchChanged,
          onSubmitted: (query) => controller.onSearchSubmitted(query),
        ),
        actions: [
          Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: controller.clearSearch,
            );
          }),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.searchQuery.value.isEmpty) {
          return _buildDefaultContent(controller);
        }
        if (controller.isSearching.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.searchResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  'No results found',
                  style: AppTextStyles.heading3.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Try different keywords',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return _buildSearchResults(controller);
      }),
    );
  }

  Widget _buildDefaultContent(app_search.AppSearchController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecentSearches(controller),
          SizedBox(height: 24.h),
          _buildPopularSearches(controller),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(app_search.AppSearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Searches', style: AppTextStyles.heading3),
            TextButton(
              onPressed: controller.clearAllRecentSearches,
              child: const Text('Clear All'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Obx(() {
          if (controller.recentSearches.isEmpty) {
            return Text(
              'No recent searches',
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
            );
          }
          return Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: controller.recentSearches.map((search) {
              return ActionChip(
                label: Text(search),
                avatar: const Icon(Icons.close, size: 16),
                onPressed: () {
                  controller.searchController.text = search;
                  controller.onSearchSubmitted(search);
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildPopularSearches(app_search.AppSearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Popular Searches', style: AppTextStyles.heading3),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: controller.popularSearches.map((search) {
            return ActionChip(
              label: Text(search),
              avatar: Icon(Icons.trending_up, size: 16.sp, color: Colors.orange),
              onPressed: () {
                controller.searchController.text = search;
                controller.onSearchSubmitted(search);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults(app_search.AppSearchController controller) {
    return Obx(() => GridView.builder(
          padding: EdgeInsets.all(12.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final product = controller.searchResults[index];
            return ProductCard(
              name: product['name'] ?? '',
              price: (product['price'] ?? 0).toDouble(),
              salePrice: (product['salePrice'] ?? 0).toDouble(),
              discount: product['discount'] as int?,
              rating: (product['rating'] ?? 0).toDouble(),
              imageUrl: product['image'] as String?,
              brand: product['brand'] as String?,
              onTap: () => Get.toNamed(
                AppRoutes.productDetails,
                arguments: product['id'].toString(),
              ),
            );
          },
        ));
  }
}
