import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class CompletedCheckIcon extends StatelessWidget {
  const CompletedCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtilsManager.w48,
      height: ScreenUtilsManager.h48,
      decoration: BoxDecoration(
        color: ColorManger.surfaceLowest,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
      ),
      child: Icon(
        Icons.check_circle,
        color: ColorManger.green,
        size: ScreenUtilsManager.s28,
      ),
    );
  }
}
