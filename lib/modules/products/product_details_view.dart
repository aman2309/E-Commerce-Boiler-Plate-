import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/modules/products/product_details_controller.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.accentOrange,
            ),
          );
        }
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildImageSection(controller),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductInfo(controller),
                      SizedBox(height: 2.h),
                      _buildVariantSection(controller),
                      SizedBox(height: 2.h),
                      _buildQuantitySelector(controller),
                      SizedBox(height: 2.h),
                      _buildDescriptionSection(controller),
                      SizedBox(height: 2.h),
                      _buildSpecificationsSection(controller),
                      SizedBox(height: 2.h),
                      _buildReviewsSection(controller),
                      SizedBox(height: 2.h),
                      _buildRelatedProducts(controller),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.h,
              left: 8.w,
              child: _buildCircleButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () => Get.back(),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.h,
              right: 8.w,
              child: Row(
                children: [
                  Obx(() => _buildCircleButton(
                        icon: controller.isWishlisted.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isWishlisted.value
                            ? ColorConstants.error
                            : null,
                        onTap: controller.toggleWishlist,
                      )),
                  SizedBox(width: 8.w),
                  _buildCircleButton(
                    icon: Icons.share_outlined,
                    onTap: controller.shareProduct,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: _buildBottomBar(controller),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42.r,
        height: 42.r,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.black.withValues(alpha: 0.08),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, size: 20.w, color: color ?? ColorConstants.textPrimary),
      ),
    );
  }

  Widget _buildImageSection(ProductDetailsController controller) {
    return Obx(() {
      final images = controller.product['images'] as List? ?? [];
      if (images.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverToBoxAdapter(
        child: Column(
          children: [
            Container(
              color: ColorConstants.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 380.h,
                    child: PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) =>
                          controller.selectedImageIndex.value = index,
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index].toString(),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: ColorConstants.grey100,
                            child: Icon(Icons.image,
                                size: 80.w, color: ColorConstants.grey400),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            width:
                                controller.selectedImageIndex.value == index
                                    ? 24.w
                                    : 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedImageIndex.value == index
                                      ? ColorConstants.accentOrange
                                      : ColorConstants.grey300,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    final imgs = controller.product['images'] as List? ?? [];
                    return SizedBox(
                      height: 64.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: imgs.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final isSelected =
                              controller.selectedImageIndex.value == index;
                          return GestureDetector(
                            onTap: () =>
                                controller.selectedImageIndex.value = index,
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? ColorConstants.accentOrange
                                      : ColorConstants.grey200,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.r),
                                child: Image.network(
                                  imgs[index].toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: ColorConstants.grey100,
                                    child: Icon(Icons.image,
                                        size: 20.w,
                                        color: ColorConstants.grey400),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProductInfo(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
                controller.product['brand'] ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.accentOrange,
                ),
              )),
          SizedBox(height: 6.h),
          Obx(() => Text(
                controller.product['name'] ?? '',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                  height: 1.3,
                ),
              )),
          SizedBox(height: 10.h),
          Obx(() => Row(
                children: [
                  ...List.generate(5, (i) {
                    final rating =
                        (controller.product['rating'] ?? 0).toDouble();
                    return Icon(
                      i < rating.round()
                          ? Icons.star
                          : (i < rating ? Icons.star_half : Icons.star_border),
                      color: ColorConstants.starYellow,
                      size: 18.w,
                    );
                  }),
                  SizedBox(width: 6.w),
                  Text(
                    '${controller.product['rating'] ?? 0}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '(${controller.product['reviewCount'] ?? 0} reviews)',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorConstants.textTertiary,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 14.h),
          Obx(() {
            final price = (controller.product['price'] ?? 0).toDouble();
            final salePrice =
                (controller.product['salePrice'] ?? 0).toDouble();
            final discount = controller.product['discount'] as int? ?? 0;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\u20B9${salePrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                if (discount > 0) ...[
                  SizedBox(width: 8.w),
                  Text(
                    '\u20B9${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      decoration: TextDecoration.lineThrough,
                      color: ColorConstants.textTertiary,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.accentGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      '$discount% OFF',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.accentGreen,
                      ),
                    ),
                  ),
                ],
              ],
            );
          }),
          SizedBox(height: 10.h),
          Obx(() {
            final inStock = controller.product['inStock'] ?? true;
            final stock = controller.product['stock'] ?? 0;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: (inStock
                        ? ColorConstants.accentGreen
                        : ColorConstants.error)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    inStock ? Icons.check_circle_outline : Icons.cancel_outlined,
                    size: 14.w,
                    color: inStock
                        ? ColorConstants.accentGreen
                        : ColorConstants.error,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    inStock ? 'In Stock ($stock)' : 'Out of Stock',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: inStock
                          ? ColorConstants.accentGreen
                          : ColorConstants.error,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildVariantSection(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() {
            final sizes = controller.product['sizes'] as List? ?? [];
            return Wrap(
              spacing: 10.w,
              runSpacing: 8.h,
              children: sizes.map((size) {
                final isSelected =
                    controller.selectedSize.value == size.toString();
                return GestureDetector(
                  onTap: () => controller.selectSize(size.toString()),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorConstants.black
                          : ColorConstants.scaffoldBackgroundLight,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstants.black
                            : ColorConstants.grey200,
                      ),
                    ),
                    child: Text(
                      size.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? ColorConstants.white
                            : ColorConstants.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          SizedBox(height: 16.h),
          Text(
            'Color',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() {
            final colors = controller.product['colors'] as List? ?? [];
            return Wrap(
              spacing: 14.w,
              runSpacing: 8.h,
              children: colors.map((color) {
                final colorName = color['name'] ?? '';
                final colorHex = color['hex'] ?? '#000000';
                final isSelected =
                    controller.selectedColor.value == colorName;
                return GestureDetector(
                  onTap: () => controller.selectColor(colorName),
                  child: Column(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse(colorHex.replaceAll('#', '0xFF'))),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.accentOrange
                                : ColorConstants.grey200,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 20)
                            : null,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        colorName,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? ColorConstants.textPrimary
                              : ColorConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Row(
        children: [
          Text(
            'Quantity',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.scaffoldBackgroundLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                _buildQuantityButton(
                    icon: Icons.remove, onTap: controller.decrementQuantity),
                Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        '${controller.quantity.value}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.textPrimary,
                        ),
                      ),
                    )),
                _buildQuantityButton(
                    icon: Icons.add, onTap: controller.incrementQuantity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.r,
        height: 38.r,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 18.w, color: ColorConstants.textPrimary),
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.toggleDescription,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                Obx(() => Icon(
                      controller.isDescriptionExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorConstants.textSecondary,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() {
            final description = controller.product['description'] ?? '';
            final isExpanded = controller.isDescriptionExpanded.value;
            return AnimatedCrossFade(
              firstChild: Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: ColorConstants.textSecondary,
                  height: 1.5,
                ),
              ),
              secondChild: Text(
                description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: ColorConstants.textSecondary,
                  height: 1.5,
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpecificationsSection(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.toggleSpecifications,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Specifications',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                Obx(() => Icon(
                      controller.isSpecificationsExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorConstants.textSecondary,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() {
            final specs =
                controller.product['specifications'] as Map? ?? {};
            final isExpanded = controller.isSpecificationsExpanded.value;
            final entries = specs.entries.toList();
            return AnimatedCrossFade(
              firstChild: entries.isNotEmpty
                  ? _buildSpecRow(
                      entries.first.key, entries.first.value.toString())
                  : const SizedBox.shrink(),
              secondChild: Column(
                children: entries.map((entry) {
                  return _buildSpecRow(entry.key, entry.value.toString());
                }).toList(),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: ColorConstants.textSecondary),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(ProductDetailsController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      color: ColorConstants.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Write a Review',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: ColorConstants.accentOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() {
            final reviews = controller.reviews;
            if (reviews.isEmpty) return const SizedBox.shrink();
            return _buildRatingSummary(reviews);
          }),
          SizedBox(height: 16.h),
          Obx(() {
            final reviews = controller.reviews;
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(review);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRatingSummary(RxList<Map<String, dynamic>> reviews) {
    final total = reviews.length;
    final avgRating = reviews.fold<double>(
          0,
          (sum, r) => sum + ((r['rating'] ?? 0) as num).toDouble(),
        ) /
        total;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorConstants.scaffoldBackgroundLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                avgRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textPrimary,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < avgRating.round() ? Icons.star : Icons.star_border,
                    color: ColorConstants.starYellow,
                    size: 18.w,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '$total reviews',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorConstants.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorConstants.scaffoldBackgroundLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor:
                    ColorConstants.accentOrange.withValues(alpha: 0.1),
                child: Text(
                  (review['userName'] ?? 'U')[0].toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'] ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    Text(
                      review['date'] ?? '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: ColorConstants.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < (review['rating'] ?? 0)
                        ? Icons.star
                        : Icons.star_border,
                    color: ColorConstants.starYellow,
                    size: 14.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            review['title'] ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            review['comment'] ?? '',
            style: TextStyle(
              fontSize: 13.sp,
              color: ColorConstants.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined,
                  size: 14.w, color: ColorConstants.textTertiary),
              SizedBox(width: 4.w),
              Text(
                'Helpful (${review['helpful'] ?? 0})',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorConstants.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts(ProductDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: Text(
            'Related Products',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 220.h,
          child: Obx(() {
            final products = controller.relatedProducts;
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final p = products[index];
                return _buildRelatedProductCard(p);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRelatedProductCard(Map<String, dynamic> product) {
    final price = (product['salePrice'] ?? 0).toDouble();
    final discount = product['discount'] as int? ?? 0;

    return GestureDetector(
      onTap: () => Get.toNamed('/product-details',
          arguments: product['id'].toString()),
      child: Container(
        width: 150.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.network(
                    product['image'] ?? '',
                    width: double.infinity,
                    height: 130.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 130.h,
                      color: ColorConstants.grey100,
                      child: Icon(Icons.image,
                          color: ColorConstants.grey400, size: 32.w),
                    ),
                  ),
                ),
                if (discount > 0)
                  Positioned(
                    top: 6.w,
                    left: 6.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'] ?? '',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.accentOrange,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    product['name'] ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\u20B9${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.accentOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(ProductDetailsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() {
          final salePrice =
              (controller.product['salePrice'] ?? 0).toDouble();
          return Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: ColorConstants.textTertiary,
                    ),
                  ),
                  Text(
                    '\u20B9${salePrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.black,
                      foregroundColor: ColorConstants.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.buyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.accentOrange,
                      foregroundColor: ColorConstants.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
