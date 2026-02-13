import 'package:civixapp/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class customindicator extends StatelessWidget {
  const customindicator({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: JumpingDotEffect(
        offset: 2,
        spacing: 20.0,
        radius: 12.r,
        dotWidth: 16.w,
        dotHeight: 16.h,
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 1.5,
        dotColor: Colors.grey,
        activeDotColor: ColorManger.kprimary,
      ),
    );
  }
}
