import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key, this.itemCount, this.isGrid = true});

  final int? itemCount;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return productGridSkeleton(itemCount: itemCount ?? 6);
    }
    return productListSkeleton(itemCount: itemCount ?? 5);
  }

  static Widget productGridSkeleton({int itemCount = 6}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => _productCardSkeleton(),
    );
  }

  static Widget productListSkeleton({int itemCount = 5}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => _productItemSkeleton(),
    );
  }

  static Widget bannerSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 180.h,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  static Widget searchSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 52.h,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }

  static Widget categorySkeleton() {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Shimmer.fromColors(
            baseColor: ColorConstants.grey300,
            highlightColor: ColorConstants.grey100,
            child: Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: const BoxDecoration(
                    color: ColorConstants.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: 50.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget productHorizontalSkeleton({int itemCount = 5}) {
    return SizedBox(
      height: 240.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: itemCount,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Shimmer.fromColors(
            baseColor: ColorConstants.grey300,
            highlightColor: ColorConstants.grey100,
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 12.h,
                            color: ColorConstants.white,
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            width: 80.w,
                            height: 10.h,
                            color: ColorConstants.white,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                width: 60.w,
                                height: 14.h,
                                color: ColorConstants.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 50.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  color: ColorConstants.white,
                                  borderRadius: BorderRadius.circular(10.r),
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
          ),
        ),
      ),
    );
  }

  static Widget profileSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: const BoxDecoration(
                color: ColorConstants.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140.w,
                    height: 16.h,
                    color: ColorConstants.white,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 200.w,
                    height: 12.h,
                    color: ColorConstants.white,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: 120.w,
                    height: 12.h,
                    color: ColorConstants.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listSkeleton({int itemCount = 5}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => _listItemSkeleton(),
    );
  }

  static Widget _productCardSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 12.h,
                      color: ColorConstants.white,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 80.w,
                      height: 10.h,
                      color: ColorConstants.white,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60.w,
                          height: 14.h,
                          color: ColorConstants.white,
                        ),
                        Container(
                          width: 50.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(10.r),
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

  static Widget _productItemSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(12.r),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.w,
                      height: 10.h,
                      color: ColorConstants.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      height: 12.h,
                      color: ColorConstants.white,
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 150.w,
                      height: 12.h,
                      color: ColorConstants.white,
                    ),
                    const Spacer(),
                    Container(
                      width: 60.w,
                      height: 14.h,
                      color: ColorConstants.white,
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

  static Widget _listItemSkeleton() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.grey300,
      highlightColor: ColorConstants.grey100,
      child: Container(
        height: 72.h,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  color: ColorConstants.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160.w,
                      height: 12.h,
                      color: ColorConstants.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 100.w,
                      height: 10.h,
                      color: ColorConstants.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
