import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'contact_us_controller.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactUsController());

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
          'Contact Us',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Get in Touch'),
            SizedBox(height: 12.h),
            _buildContactCard(
              icon: Icons.phone,
              iconColor: ColorConstants.accentGreen,
              title: 'Phone',
              subtitle: '+1 (800) 123-4567',
              trailing: 'Call',
              onTap: controller.callSupport,
            ),
            _buildContactCard(
              icon: Icons.email,
              iconColor: ColorConstants.accentBlue,
              title: 'Email',
              subtitle: 'support@flutterboilerplate.com',
              trailing: 'Email',
              onTap: controller.emailSupport,
            ),
            _buildContactCard(
              icon: Icons.location_on,
              iconColor: ColorConstants.error,
              title: 'Address',
              subtitle: '123 Main Street\nNew York, NY 10001',
              trailing: 'Map',
              onTap: controller.openMap,
            ),
            _buildContactCard(
              icon: Icons.access_time,
              iconColor: ColorConstants.accentOrange,
              title: 'Working Hours',
              subtitle: 'Mon - Fri: 9:00 AM - 6:00 PM\nSat - Sun: Closed',
              trailing: null,
              onTap: null,
            ),
            SizedBox(height: 24.h),
            _buildSectionTitle('Follow Us'),
            SizedBox(height: 12.h),
            _buildSocialLinks(controller),
            SizedBox(height: 28.h),
            _buildSectionTitle('Send Us a Message'),
            SizedBox(height: 12.h),
            _buildMessageForm(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: ColorConstants.textPrimary),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 22.w),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: ColorConstants.textPrimary),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13.sp, color: ColorConstants.textSecondary, height: 1.4),
        ),
        trailing: trailing != null
            ? TextButton(
                onPressed: onTap,
                child: Text(
                  trailing,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: ColorConstants.accentOrange),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSocialLinks(ContactUsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _socialIcon(Icons.facebook, 'Facebook', ColorConstants.accentBlue, () => controller.openSocialLink('facebook')),
          _socialIcon(Icons.camera_alt, 'Instagram', ColorConstants.accentPink, () => controller.openSocialLink('instagram')),
          _socialIcon(Icons.alternate_email, 'Twitter', ColorConstants.accentBlue, () => controller.openSocialLink('twitter')),
          _socialIcon(Icons.play_circle_fill, 'YouTube', ColorConstants.error, () => controller.openSocialLink('youtube')),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(height: 6.h),
          Text(label, style: TextStyle(fontSize: 11.sp, color: ColorConstants.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildMessageForm(ContactUsController controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: controller.nameController,
            label: 'Name',
            icon: Icons.person_outline,
          ),
          SizedBox(height: 12.h),
          _buildTextField(
            controller: controller.emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.h),
          _buildSubjectDropdown(controller),
          SizedBox(height: 12.h),
          _buildTextField(
            controller: controller.messageController,
            label: 'Message',
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          SizedBox(height: 16.h),
          Obx(() => SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.accentOrange,
                    foregroundColor: ColorConstants.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.white),
                          ),
                        )
                      : Text(
                          'Send Message',
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: ColorConstants.textTertiary),
        prefixIcon: Icon(icon, size: 20.w, color: ColorConstants.textTertiary),
        filled: true,
        fillColor: ColorConstants.scaffoldBackgroundLight,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildSubjectDropdown(ContactUsController controller) {
    return Obx(() => DropdownButtonFormField<String>(
          value: controller.selectedSubject.value,
          decoration: InputDecoration(
            labelText: 'Subject',
            labelStyle: TextStyle(color: ColorConstants.textTertiary),
            prefixIcon: Icon(Icons.subject, size: 20.w, color: ColorConstants.textTertiary),
            filled: true,
            fillColor: ColorConstants.scaffoldBackgroundLight,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          items: controller.subjects.map((subject) {
            return DropdownMenuItem(
              value: subject,
              child: Text(subject, style: TextStyle(fontSize: 14.sp, color: ColorConstants.textPrimary)),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) controller.selectedSubject.value = val;
          },
        ));
  }
}
