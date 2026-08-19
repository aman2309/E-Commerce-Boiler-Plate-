import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildProfileHeader(controller),
            SizedBox(height: 16.h),
            _buildQuickActionsCard(),
            SizedBox(height: 12.h),
            _buildMenuSection(
              title: 'Shopping',
              items: [
                _MenuItemData('My Orders', Icons.shopping_bag_outlined, AppRoutes.orders),
                _MenuItemData('Wishlist', Icons.favorite_border, AppRoutes.wishlist),
                _MenuItemData('Addresses', Icons.location_on_outlined, AppRoutes.profile),
              ],
            ),
            _buildMenuSection(
              title: 'Account',
              items: [
                _MenuItemData('Notifications', Icons.notifications_outlined, AppRoutes.notifications),
                _MenuItemData('Settings', Icons.settings_outlined, AppRoutes.settings),
                _MenuItemData('Help & Support', Icons.help_outline, AppRoutes.contactUs),
              ],
            ),
            _buildMenuSection(
              title: 'Legal',
              items: [
                _MenuItemData('Contact Us', Icons.mail_outline, AppRoutes.contactUs),
                _MenuItemData('Privacy Policy', Icons.privacy_tip_outlined, null),
                _MenuItemData('Terms & Conditions', Icons.description_outlined, null),
              ],
            ),
            _buildLogoutSection(controller),
            SizedBox(height: 32.h),
          ],
        );
      }),
    );
  }

  Widget _buildProfileHeader(ProfileController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 60.h, bottom: 32.h, left: 24.w, right: 24.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstants.black, Color(0xFF1A1A2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Obx(() {
            final user = controller.user;
            final initials = user['initials'] ?? 'U';
            return Container(
              width: 96.r,
              height: 96.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstants.accentOrange, width: 3),
              ),
              child: CircleAvatar(
                radius: 46.r,
                backgroundColor: const Color(0xFF2A2A3E),
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.accentOrange,
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 16.h),
          Obx(() => Text(
                controller.user['name'] ?? 'User',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.white,
                ),
              )),
          SizedBox(height: 4.h),
          Obx(() => Text(
                controller.user['email'] ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorConstants.white.withValues(alpha: 0.7),
                ),
              )),
          SizedBox(height: 2.h),
          Obx(() => Text(
                controller.user['phone'] ?? '',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: ColorConstants.white.withValues(alpha: 0.6),
                ),
              )),
          SizedBox(height: 20.h),
          OutlinedButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.profile),
            icon: Icon(Icons.edit_outlined, size: 16.sp, color: ColorConstants.white),
            label: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorConstants.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: ColorConstants.white, width: 1.5),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAction(icon: Icons.shopping_bag_outlined, label: 'Orders', route: AppRoutes.orders),
          _buildQuickAction(icon: Icons.favorite_border, label: 'Wishlist', route: AppRoutes.wishlist),
          _buildQuickAction(icon: Icons.location_on_outlined, label: 'Address', route: AppRoutes.profile),
          _buildQuickAction(icon: Icons.settings_outlined, label: 'Settings', route: AppRoutes.settings),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Column(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: ColorConstants.scaffoldBackgroundLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: ColorConstants.textPrimary, size: 22.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<_MenuItemData> items,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 4.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textTertiary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...items.map((item) => _buildMenuTile(item)),
        ],
      ),
    );
  }

  Widget _buildMenuTile(_MenuItemData item) {
    final bool isLogout = item.title == 'Logout';

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: (isLogout ? ColorConstants.error : ColorConstants.scaffoldBackgroundLight)
              .withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          item.icon,
          color: isLogout ? ColorConstants.error : ColorConstants.textPrimary,
          size: 20.sp,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isLogout ? ColorConstants.error : ColorConstants.textPrimary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: ColorConstants.textTertiary,
        size: 22.sp,
      ),
      onTap: () {
        if (item.route != null) {
          Get.toNamed(item.route!);
        } else {
          Get.snackbar('Info', '${item.title} feature coming soon',
              snackPosition: SnackPosition.BOTTOM);
        }
      },
    );
  }

  Widget _buildLogoutSection(ProfileController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        leading: Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: ColorConstants.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.logout_rounded, color: ColorConstants.error, size: 20.sp),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: ColorConstants.error,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: ColorConstants.error.withValues(alpha: 0.5),
          size: 22.sp,
        ),
        onTap: controller.logout,
      ),
    );
  }
}

class _MenuItemData {
  final String title;
  final IconData icon;
  final String? route;

  const _MenuItemData(this.title, this.icon, this.route);
}
