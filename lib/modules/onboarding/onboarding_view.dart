import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding_controller.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    final List<Map<String, dynamic>> pages = [
      {
        'icon': Icons.explore_rounded,
        'title': 'Discover Products',
        'description':
            'Browse thousands of products from top brands and find exactly what you need.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.shopping_cart_rounded,
        'title': 'Easy Checkout',
        'description':
            'Fast and secure checkout process. Complete your purchase in just a few taps.',
        'color': Colors.green,
      },
      {
        'icon': Icons.local_shipping_rounded,
        'title': 'Fast Delivery',
        'description':
            'Get your orders delivered to your doorstep quickly and reliably.',
        'color': Colors.orange,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Obx(
                () => controller.currentPage.value < 2
                    ? TextButton(
                        onPressed: controller.skip,
                        child: Text(
                          'Skip',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : const SizedBox(height: 48),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                (page['color'] as Color).withOpacity(0.2),
                                (page['color'] as Color).withOpacity(0.4),
                              ],
                            ),
                          ),
                          child: Icon(
                            page['icon'] as IconData,
                            size: 80.w,
                            color: page['color'] as Color,
                          ),
                        ),
                        SizedBox(height: 48.h),
                        Text(
                          page['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          page['description'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: controller.currentPage.value == index
                              ? 24.w
                              : 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: controller.currentPage.value == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: controller.next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          controller.currentPage.value < 2
                              ? 'Next'
                              : 'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
