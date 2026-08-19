import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundLight,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorConstants.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
        ),
        centerTitle: true,
      ),
      body: Obx(() => ListView(
            children: [
              _buildSectionHeader('Account'),
              _buildCardSection([
                _buildNavTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: () => Get.back(),
                ),
                _buildNavTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: controller.changePassword,
                ),
              ]),
              _buildSectionHeader('Preferences'),
              _buildCardSection([
                _buildSwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive push notifications',
                  value: controller.isNotificationsEnabled.value,
                  onChanged: (_) => controller.toggleNotifications(),
                ),
                _buildLanguageTile(context, controller),
                _buildSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  value: controller.isDarkMode.value,
                  onChanged: (val) => controller.changeTheme(val),
                ),
              ]),
              _buildSectionHeader('Legal'),
              _buildCardSection([
                _buildNavTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'How we handle your data',
                  onTap: () => Get.snackbar('Privacy Policy', 'Opening privacy policy...'),
                ),
                _buildNavTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  subtitle: 'Our terms of service',
                  onTap: () => Get.snackbar('Terms & Conditions', 'Opening terms...'),
                ),
              ]),
              _buildSectionHeader('About'),
              _buildCardSection([
                _buildNavTile(
                  icon: Icons.info_outline,
                  title: 'App Version',
                  subtitle: controller.appVersion,
                  onTap: () {},
                  trailing: null,
                ),
                _buildNavTile(
                  icon: Icons.star_outline,
                  title: 'Rate App',
                  subtitle: 'Rate us on the app store',
                  onTap: () => Get.snackbar('Rate App', 'Thank you for your support!'),
                ),
                _buildNavTile(
                  icon: Icons.share_outlined,
                  title: 'Share App',
                  subtitle: 'Share with friends and family',
                  onTap: () => Get.snackbar('Share App', 'Share link copied to clipboard'),
                ),
              ]),
              _buildSectionHeader('Account Management'),
              _buildCardSection([
                _buildNavTile(
                  icon: Icons.delete_forever_outlined,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account',
                  titleColor: ColorConstants.error,
                  iconColor: ColorConstants.error,
                  onTap: controller.deleteAccount,
                ),
              ]),
              SizedBox(height: 40.h),
            ],
          )),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 8.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: ColorConstants.textTertiary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCardSection(List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: (iconColor ?? ColorConstants.textSecondary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: iconColor ?? ColorConstants.textSecondary, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: titleColor ?? ColorConstants.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary),
      ),
      trailing: trailing ?? Icon(Icons.chevron_right, color: ColorConstants.textTertiary, size: 20.sp),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: ColorConstants.textSecondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: ColorConstants.textSecondary, size: 20.sp),
      ),
      title: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorConstants.textPrimary)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: ColorConstants.accentGreen,
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, SettingsController controller) {
    final languages = ['English', 'Spanish', 'French', 'German', 'Arabic', 'Hindi'];

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: ColorConstants.textSecondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.language, color: ColorConstants.textSecondary, size: 20.sp),
      ),
      title: Text('Language', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorConstants.textPrimary)),
      subtitle: Text(
        controller.selectedLanguage.value,
        style: TextStyle(fontSize: 12.sp, color: ColorConstants.textTertiary),
      ),
      trailing: DropdownButton<String>(
        value: controller.selectedLanguage.value,
        underline: const SizedBox(),
        items: languages.map((lang) {
          return DropdownMenuItem(
            value: lang,
            child: Text(lang, style: TextStyle(fontSize: 13.sp, color: ColorConstants.textPrimary)),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) controller.changeLanguage(val);
        },
      ),
    );
  }
}
