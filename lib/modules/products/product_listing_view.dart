import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/modules/products/product_listing_controller.dart';
import 'package:flutter_boilerplate/widgets/product_card.dart';
import 'package:flutter_boilerplate/widgets/loading_skeleton.dart';

class ProductListingView extends StatelessWidget {
  const ProductListingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductListingController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: ColorConstants.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Products',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
                onPressed: controller.toggleViewMode,
                icon: Icon(
                  controller.isGridView
                      ? Icons.view_list_outlined
                      : Icons.grid_view_outlined,
                  color: ColorConstants.textPrimary,
                  size: 22.w,
                ),
              )),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(controller),
          _buildSortAndFilterRow(controller),
          _buildCategoryChips(controller),
          _buildActiveFilters(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return LoadingSkeleton(
                  itemCount: 6,
                  isGrid: controller.isGridView,
                );
              }
              if (controller.hasError.value) {
                return _buildErrorState(controller);
              }
              if (controller.products.isEmpty) {
                return _buildEmptyState(controller);
              }
              return RefreshIndicator(
                onRefresh: () async => controller.refreshProducts(),
                child: controller.isGridView
                    ? _buildGridView(controller)
                    : _buildListView(controller),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ProductListingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: TextField(
        onChanged: controller.searchProducts,
        style: TextStyle(fontSize: 14.sp, color: ColorConstants.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: TextStyle(fontSize: 14.sp, color: ColorConstants.textTertiary),
          prefixIcon: const Icon(Icons.search, color: ColorConstants.textTertiary, size: 20),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => controller.searchProducts(''),
                )
              : const SizedBox.shrink()),
          filled: true,
          fillColor: ColorConstants.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: ColorConstants.black, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildSortAndFilterRow(ProductListingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        children: [
          _buildSortDropdown(controller),
          const Spacer(),
          Obx(() => _buildFilterChip(
            icon: controller.isGridView ? Icons.grid_view : Icons.view_list,
            label: controller.isGridView ? 'Grid' : 'List',
            onTap: controller.toggleViewMode,
          )),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(ProductListingController controller) {
    final sortOptions = [
      {'value': 'popular', 'label': 'Popular'},
      {'value': 'price_low', 'label': 'Price: Low to High'},
      {'value': 'price_high', 'label': 'Price: High to Low'},
      {'value': 'rating', 'label': 'Top Rated'},
      {'value': 'newest', 'label': 'Newest'},
    ];

    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorConstants.grey200),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.sortBy.value,
            isDense: true,
            icon: Icon(Icons.keyboard_arrow_down, size: 18.w, color: ColorConstants.textSecondary),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textPrimary,
            ),
            items: sortOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option['value'],
                child: Text(option['label']!),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) controller.sortProducts(value);
            },
          ),
        ),
      );
    });
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorConstants.grey200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.w, color: ColorConstants.textSecondary),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips(ProductListingController controller) {
    final categories = [
      '',
      'Electronics',
      'Fashion',
      'Home & Garden',
      'Sports',
      'Beauty',
      'Kids',
      'Books',
      'Automotive',
    ];

    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final label = cat.isEmpty ? 'All' : cat;
          final isSelected = controller.selectedCategory.value == cat;
          return GestureDetector(
            onTap: () => controller.filterByCategory(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? ColorConstants.black : ColorConstants.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? ColorConstants.black : ColorConstants.grey200,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? ColorConstants.white : ColorConstants.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveFilters(ProductListingController controller) {
    return Obx(() {
      if (controller.selectedCategory.value.isEmpty &&
          controller.searchQuery.value.isEmpty) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: Wrap(
          spacing: 8.w,
          runSpacing: 4.h,
          children: [
            if (controller.selectedCategory.value.isNotEmpty)
              Chip(
                label: Text(controller.selectedCategory.value),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  controller.selectedCategory.value = '';
                  controller.loadProducts();
                },
                backgroundColor: ColorConstants.accentOrange.withValues(alpha: 0.1),
                labelStyle: TextStyle(
                  color: ColorConstants.accentOrange,
                  fontSize: 12.sp,
                ),
              ),
            if (controller.searchQuery.value.isNotEmpty)
              Chip(
                label: Text('"${controller.searchQuery.value}"'),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => controller.searchProducts(''),
                backgroundColor: ColorConstants.black.withValues(alpha: 0.05),
                labelStyle: TextStyle(
                  color: ColorConstants.textPrimary,
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildErrorState(ProductListingController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.w, color: ColorConstants.textTertiary),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            controller.errorMessage.value,
            style: TextStyle(fontSize: 13.sp, color: ColorConstants.textSecondary),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: controller.loadProducts,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.black,
              foregroundColor: ColorConstants.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text('Retry', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ProductListingController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: const BoxDecoration(
                color: ColorConstants.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 48.w,
                color: ColorConstants.textTertiary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: controller.refreshProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.accentOrange,
                foregroundColor: ColorConstants.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text('Refresh', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(ProductListingController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
          controller.loadMore();
        }
        return false;
      },
      child: GridView.builder(
        padding: EdgeInsets.all(12.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.58,
        ),
        itemCount: controller.products.length + (controller.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.products.length) {
            return _buildLoadMoreIndicator();
          }
          final product = controller.products[index];
          return ProductCard(
            imageUrl: product['image'] as String?,
            name: product['name'] as String? ?? '',
            brand: product['brand'] as String?,
            price: (product['price'] as num?)?.toDouble() ?? 0,
            salePrice: (product['salePrice'] as num?)?.toDouble(),
            discount: product['discount'] as int?,
            rating: (product['rating'] as num?)?.toDouble(),
            reviewCount: product['reviewCount'] as int?,
            onTap: () => Get.toNamed(
              AppRoutes.productDetails,
              arguments: product['id'].toString(),
            ),
            onCartTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildListView(ProductListingController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
          controller.loadMore();
        }
        return false;
      },
      child: ListView.separated(
        padding: EdgeInsets.all(12.w),
        itemCount: controller.products.length + (controller.hasMore ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          if (index == controller.products.length) {
            return _buildLoadMoreIndicator();
          }
          final product = controller.products[index];
          return _buildListCard(product);
        },
      ),
    );
  }

  Widget _buildListCard(Map<String, dynamic> product) {
    final price = (product['salePrice'] ?? 0).toDouble();
    final originalPrice = (product['price'] ?? 0).toDouble();
    final discount = product['discount'] as int? ?? 0;
    final rating = (product['rating'] ?? 0).toDouble();
    final imageUrl = product['image'] as String? ?? '';
    final name = product['name'] as String? ?? '';
    final brand = product['brand'] as String? ?? '';

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.productDetails,
        arguments: product['id'].toString(),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 120.w,
                      height: 120.h,
                      color: ColorConstants.grey100,
                      child: Icon(Icons.image, color: ColorConstants.grey400, size: 32.w),
                    ),
                  ),
                  if (discount > 0)
                    Positioned(
                      top: 6.w,
                      left: 6.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: ColorConstants.accentGreen,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '$discount% OFF',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.accentOrange,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: ColorConstants.starYellow, size: 16.w),
                        SizedBox(width: 2.w),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text(
                          '\u20B9${price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.accentOrange,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        if (discount > 0)
                          Text(
                            '\u20B9${originalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              decoration: TextDecoration.lineThrough,
                              color: ColorConstants.textTertiary,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(ColorConstants.accentOrange),
        ),
      ),
    );
  }
}
