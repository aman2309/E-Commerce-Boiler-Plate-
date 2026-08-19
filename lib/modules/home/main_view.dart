import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/modules/products/categories/categories_view.dart';
import 'package:flutter_boilerplate/modules/wishlist/wishlist_view.dart';
import 'package:flutter_boilerplate/modules/cart/cart_view.dart';
import 'package:flutter_boilerplate/modules/profile/profile_view.dart';
import 'home_view.dart';
import 'main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: ColorConstants.scaffoldBackgroundLight,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            _HomeTab(),
            CategoriesView(),
            WishlistView(),
            CartView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: _buildCustomBottomBar(controller),
      );
    });
  }

  Widget _buildCustomBottomBar(MainController controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                controller: controller,
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
              ),
              _buildNavItem(
                controller: controller,
                index: 1,
                icon: Icons.grid_view_outlined,
                activeIcon: Icons.grid_view_rounded,
                label: 'Categories',
              ),
              _buildNavItem(
                controller: controller,
                index: 2,
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite_rounded,
                label: 'Wishlist',
              ),
              _buildCartNavItem(controller: controller),
              _buildNavItem(
                controller: controller,
                index: 4,
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required MainController controller,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14.w : 8.w,
          vertical: 6.h,
        ),
        decoration: isActive
            ? BoxDecoration(
                color: ColorConstants.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 22.w,
              color: isActive
                  ? ColorConstants.accentOrange
                  : ColorConstants.grey500,
            ),
            if (isActive) ...[
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.accentOrange,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCartNavItem({required MainController controller}) {
    final isActive = controller.currentIndex.value == 3;
    final cartCount = controller.cartCount.value;

    return GestureDetector(
      onTap: () => controller.changeTab(3),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14.w : 8.w,
          vertical: 6.h,
        ),
        decoration: isActive
            ? BoxDecoration(
                color: ColorConstants.accentOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              )
            : null,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              isActive
                  ? Icons.shopping_cart_rounded
                  : Icons.shopping_cart_outlined,
              size: 22.w,
              color: isActive
                  ? ColorConstants.accentOrange
                  : ColorConstants.grey500,
            ),
            if (cartCount > 0)
              Positioned(
                right: -6.w,
                top: -6.h,
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
                      cartCount > 99 ? '99+' : '$cartCount',
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
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();
  @override
  Widget build(BuildContext context) => const HomeView();
}
