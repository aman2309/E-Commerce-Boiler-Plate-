import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/constants/dimensions.dart';
import 'package:flutter_boilerplate/widgets/banner_carousel.dart';
import 'package:flutter_boilerplate/widgets/loading_skeleton.dart';
import 'package:flutter_boilerplate/widgets/app_search_bar.dart';
import 'home_controller.dart';
import 'widgets/category_section.dart';
import 'widgets/product_section.dart';
import 'widgets/deal_of_the_day.dart';
import 'widgets/brand_card.dart';
import 'widgets/promo_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoadingSkeleton();
      }

      return RefreshIndicator(
        onRefresh: () async => controller.onInit(),
        color: ColorConstants.accentOrange,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(controller),
              SizedBox(height: AppDimens.md.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
                child: const AppSearchBar(),
              ),
              SizedBox(height: AppDimens.lg.h),
              _buildBannerSection(controller),
              SizedBox(height: AppDimens.lg.h),
              CategorySection(
                title: 'Categories',
                categories: controller.categories,
                onSeeAll: () {},
              ),
              SizedBox(height: AppDimens.lg.h),
              ProductSection(
                title: 'Featured Products',
                products: controller.featuredProducts,
                onSeeAll: () {},
              ),
              SizedBox(height: AppDimens.lg.h),
              _buildDealOfTheDaySection(controller),
              SizedBox(height: AppDimens.lg.h),
              ProductSection(
                title: 'Trending Now',
                products: controller.trendingProducts,
                onSeeAll: () {},
              ),
              SizedBox(height: AppDimens.lg.h),
              _buildBestSellersSection(controller),
              SizedBox(height: AppDimens.lg.h),
              ProductSection(
                title: 'New Arrivals',
                products: controller.newArrivals,
                onSeeAll: () {},
              ),
              SizedBox(height: AppDimens.lg.h),
              _buildTopBrandsSection(controller),
              SizedBox(height: AppDimens.lg.h),
              _buildRecommendedSection(controller),
              SizedBox(height: AppDimens.lg.h),
              PromoBanner(
                title: 'Free Shipping',
                subtitle: 'On your first order over \$50',
                buttonText: 'Shop Now',
                gradientStart: const Color(0xFF00C853),
                gradientEnd: const Color(0xFF69F0AE),
                icon: Icons.local_shipping_rounded,
                onButtonTap: () {},
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(HomeController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      decoration: const BoxDecoration(
        color: ColorConstants.white,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Aman \uD83D\uDC4B',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.w,
                        color: ColorConstants.accentOrange,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '123, Sector 45, Gurgaon',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18.w,
                        color: ColorConstants.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildHeaderIcon(
              icon: Icons.notifications_outlined,
              badgeCount: 2,
            ),
            SizedBox(width: 12.w),
            _buildHeaderIcon(
              icon: Icons.shopping_cart_outlined,
              badgeCount: controller.cartCount.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon({required IconData icon, int badgeCount = 0}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: ColorConstants.grey50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            size: 22.w,
            color: ColorConstants.textPrimary,
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            right: -4.w,
            top: -4.w,
            child: Container(
              padding: EdgeInsets.all(3.w),
              constraints: BoxConstraints(
                minWidth: 16.w,
                minHeight: 16.w,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.accentOrange,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConstants.white,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  badgeCount > 99 ? '99+' : '$badgeCount',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBannerSection(HomeController controller) {
    return BannerCarousel(
      banners: controller.banners,
      height: 160,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 4),
      onTap: (index) {},
    );
  }

  Widget _buildDealOfTheDaySection(HomeController controller) {
    final deal = controller.dealOfTheDay;
    if (deal.isEmpty) return const SizedBox.shrink();

    return DealOfTheDay(
      name: deal['name'] ?? '',
      price: (deal['price'] ?? 0).toDouble(),
      discountPrice: (deal['discountPrice'] ?? 0).toDouble(),
      discount: deal['discount'] ?? 0,
      rating: (deal['rating'] ?? 0).toDouble(),
      reviews: deal['reviews'] ?? 0,
      imageUrl: deal['image'],
      onShopNow: () {},
    );
  }

  Widget _buildBestSellersSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Sellers',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.md.h),
        SizedBox(
          height: 280.h,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppDimens.md.w,
              crossAxisSpacing: AppDimens.md.w,
              childAspectRatio: 0.78,
            ),
            itemCount: controller.bestSellers.length,
            itemBuilder: (context, index) {
              final product = controller.bestSellers[index];
              return _buildBestSellerCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellerCard(Map<String, dynamic> product) {
    final price = (product['discountPrice'] ?? product['price'] ?? 0)
        .toDouble();
    final originalPrice = (product['price'] ?? 0).toDouble();
    final hasDiscount = originalPrice > price;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
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
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.grey50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 30.w,
                color: ColorConstants.grey400,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            product['name'] ?? '',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: ColorConstants.starYellow,
                size: 12.w,
              ),
              SizedBox(width: 2.w),
              Text(
                '${product['rating'] ?? 0}',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: ColorConstants.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.accentOrange,
                ),
              ),
              if (hasDiscount) ...[
                SizedBox(width: 4.w),
                Text(
                  '\$${originalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: ColorConstants.textTertiary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBrandsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Brands',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.md.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: AppDimens.lg.w),
            itemCount: controller.topBrands.length,
            itemBuilder: (context, index) {
              final brand = controller.topBrands[index];
              return Padding(
                padding: EdgeInsets.only(right: AppDimens.md.w),
                child: BrandCard(
                  name: brand['name'] ?? '',
                  icon: brand['icon'] as IconData?,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection(HomeController controller) {
    return ProductSection(
      title: 'Recommended For You',
      products: controller.featuredProducts,
      onSeeAll: () {},
    );
  }

  Widget _buildLoadingSkeleton() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 56.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.grey200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 100.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.grey200,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.grey200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.grey200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          LoadingSkeleton.searchSkeleton(),
          SizedBox(height: 16.h),
          LoadingSkeleton.bannerSkeleton(),
          SizedBox(height: 24.h),
          LoadingSkeleton.categorySkeleton(),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  width: 140.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.grey200,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 60.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.grey200,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          LoadingSkeleton.productHorizontalSkeleton(itemCount: 5),
          SizedBox(height: 24.h),
          LoadingSkeleton.productHorizontalSkeleton(itemCount: 5),
        ],
      ),
    );
  }
}
