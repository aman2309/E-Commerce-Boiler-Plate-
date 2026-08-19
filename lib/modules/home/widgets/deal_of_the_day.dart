import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/core/constants/color_constants.dart';

class DealOfTheDay extends StatefulWidget {
  final String name;
  final double price;
  final double discountPrice;
  final int discount;
  final double rating;
  final int reviews;
  final String? imageUrl;
  final VoidCallback? onShopNow;
  final int hours;
  final int minutes;
  final int seconds;

  const DealOfTheDay({
    super.key,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    this.imageUrl,
    this.onShopNow,
    this.hours = 23,
    this.minutes = 59,
    this.seconds = 59,
  });

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  late int _hours;
  late int _minutes;
  late int _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _hours = widget.hours;
    _minutes = widget.minutes;
    _seconds = widget.seconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else if (_minutes > 0) {
        _minutes--;
        _seconds = 59;
      } else if (_hours > 0) {
        _hours--;
        _minutes = 59;
        _seconds = 59;
      } else {
        timer.cancel();
      }
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final savings = widget.price - widget.discountPrice;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.accentOrange,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${widget.discount}% OFF',
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'DEAL OF THE DAY',
                    style: TextStyle(
                      color: ColorConstants.accentOrange,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.local_fire_department,
                  color: ColorConstants.accentOrange,
                  size: 22.w,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: widget.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildProductPlaceholder(),
                          ),
                        )
                      : _buildProductPlaceholder(),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorConstants.starYellow,
                            size: 16.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${widget.rating}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(${widget.reviews})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorConstants.grey500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            '\$${widget.discountPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.accentOrange,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorConstants.grey500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'You save \$${savings.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConstants.accentGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
            child: Row(
              children: [
                Text(
                  'Ends in:',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorConstants.grey500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),
                _buildTimerBox(
                  _hours.toString().padLeft(2, '0'),
                  'H',
                ),
                SizedBox(width: 4.w),
                Text(
                  ':',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.white,
                  ),
                ),
                SizedBox(width: 4.w),
                _buildTimerBox(
                  _minutes.toString().padLeft(2, '0'),
                  'M',
                ),
                SizedBox(width: 4.w),
                Text(
                  ':',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.white,
                  ),
                ),
                SizedBox(width: 4.w),
                _buildTimerBox(
                  _seconds.toString().padLeft(2, '0'),
                  'S',
                ),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onShopNow,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.accentOrange,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String value, String label) {
    return Column(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: ColorConstants.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.white,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            color: ColorConstants.grey500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProductPlaceholder() {
    return Center(
      child: Icon(
        Icons.shopping_bag,
        size: 40.w,
        color: ColorConstants.grey600,
      ),
    );
  }
}
