import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_boilerplate/core/constants/color_constants.dart';
import 'add_address_controller.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressController());

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
          'Add New Address',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Contact Information'),
              SizedBox(height: 12.h),
              _buildTextField(
                controller: controller.nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                prefixIcon: Icons.person_outline,
                validator: controller.validateName,
              ),
              SizedBox(height: 12.h),
              _buildTextField(
                controller: controller.phoneController,
                label: 'Phone Number',
                hint: 'Enter your phone number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: controller.validatePhone,
              ),
              SizedBox(height: 24.h),
              _buildSectionTitle('Address'),
              SizedBox(height: 12.h),
              _buildTextField(
                controller: controller.addressLine1Controller,
                label: 'Address Line 1',
                hint: 'Street address, P.O. box',
                prefixIcon: Icons.home_outlined,
                validator: controller.validateAddressLine1,
              ),
              SizedBox(height: 12.h),
              _buildTextField(
                controller: controller.addressLine2Controller,
                label: 'Address Line 2 (Optional)',
                hint: 'Apartment, suite, unit, etc.',
                prefixIcon: Icons.home_outlined,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: controller.cityController,
                      label: 'City',
                      hint: 'City',
                      prefixIcon: Icons.location_city_outlined,
                      validator: controller.validateCity,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildTextField(
                      controller: controller.stateController,
                      label: 'State',
                      hint: 'State',
                      prefixIcon: Icons.map_outlined,
                      validator: controller.validateState,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      controller: controller.zipCodeController,
                      label: 'Zip Code',
                      hint: 'Zip code',
                      prefixIcon: Icons.markunread_mailbox_outlined,
                      keyboardType: TextInputType.number,
                      validator: controller.validateZipCode,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: _buildCountryDropdown(controller),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Obx(() => SwitchListTile(
                title: Text(
                  'Set as default address',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textPrimary,
                  ),
                ),
                subtitle: Text(
                  'Use this address as your default for future orders',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorConstants.textSecondary,
                  ),
                ),
                value: controller.isDefault.value,
                onChanged: (value) {
                  controller.isDefault.value = value;
                },
                activeColor: ColorConstants.black,
                contentPadding: EdgeInsets.zero,
              )),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.black,
                    foregroundColor: ColorConstants.white,
                    disabledBackgroundColor: ColorConstants.grey400,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorConstants.white,
                          ),
                        )
                      : Text(
                          'Save Address',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                )),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ColorConstants.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 14.sp, color: ColorConstants.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp, color: ColorConstants.textTertiary),
        labelStyle: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
        prefixIcon: Icon(prefixIcon, size: 20.w, color: ColorConstants.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildCountryDropdown(AddAddressController controller) {
    return DropdownButtonFormField<String>(
      value: controller.selectedCountry.value,
      decoration: InputDecoration(
        labelText: 'Country',
        hintStyle: TextStyle(fontSize: 14.sp, color: ColorConstants.textTertiary),
        labelStyle: TextStyle(fontSize: 14.sp, color: ColorConstants.textSecondary),
        prefixIcon: Icon(Icons.public_outlined,
            size: 20.w, color: ColorConstants.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: ColorConstants.black, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
      items: controller.countries.map((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country, style: TextStyle(fontSize: 14.sp)),
        );
      }).toList(),
      onChanged: (String? value) {
        if (value != null) {
          controller.selectedCountry.value = value;
        }
      },
      icon: Icon(Icons.keyboard_arrow_down, size: 20.w),
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
