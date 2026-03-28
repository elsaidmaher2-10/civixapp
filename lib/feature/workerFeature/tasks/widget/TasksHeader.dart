import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان الرئيسي مع تأثير حرفي
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800, // وزن أثقل ليعطي فخامة
                fontSize: ScreenUtilsManager.s34, // متجاوب
                color: ColorManger.onSurface,
                letterSpacing: -1.5,
                height: 1.1,
              ),
            ),
            // نقطة جمالية بلون الهوية (اختياري حسب ذوقك)
            Container(
              margin: EdgeInsets.only(left: ScreenUtilsManager.w2),
              width: ScreenUtilsManager.w6,
              height: ScreenUtilsManager.w6,
              decoration: BoxDecoration(
                color: ColorManger.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),

        SizedBox(height: ScreenUtilsManager.h8),

        Opacity(
          opacity: 0.8, // تعطي عمق بصري (Visual Depth)
          child: Text(
            'Manage your work efficiently',
            style: TextStyle(
              fontSize: ScreenUtilsManager.s16, // تصغير بسيط ليبرز العنوان أكثر
              fontWeight: FontWeight.w500,
              color: ColorManger.onSurfaceVariant, // استخدام لون أهدأ قليلاً
              letterSpacing: 0.2,
            ),
          ),
        ),

        SizedBox(height: ScreenUtilsManager.h12),
        Container(
          width: ScreenUtilsManager.w40,
          height: ScreenUtilsManager.h4,
          decoration: BoxDecoration(
            gradient: ColorManger.kineticGradient,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
          ),
        ),
      ],
    );
  }
}
