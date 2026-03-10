import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedMarker extends StatefulWidget {
  const AnimatedMarker({super.key});

  @override
  State<AnimatedMarker> createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (context, child) {
        return CircleAvatar(
          backgroundColor: ColorManger.kprimaryLight.withOpacity(
            opacityAnimation.value,
          ),
          child: SvgPicture.asset(
            "assets/marker.svg",
            width: opacityAnimation.value * 35,
            height: opacityAnimation.value * 35,
          ),
        );
      },
    );
  }
}
