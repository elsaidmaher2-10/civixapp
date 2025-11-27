import 'package:flutter/material.dart';
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
      effect: WormEffect(
        offset: 2,
        spacing: 20.0,
        radius: 16.0,
        dotWidth: 24.0,
        dotHeight: 24.0,
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 1.5,
        dotColor: Colors.grey,
        activeDotColor: Color(0xff003366),
      ),
    );
  }
}
