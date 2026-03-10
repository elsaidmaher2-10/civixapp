

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Uploadimage extends StatelessWidget {
  Uploadimage({super.key, required this.onTap});
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: Color(0xff64748B),
        dashPattern: [10, 5],
        borderPadding: EdgeInsets.all(5),
        strokeWidth: 0.8,
        radius: Radius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(25.w),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/camera.svg", width: 20.w, height: 22.h),
              SizedBox(height: 7.h),
              Text(
                "Add Photo",
                style: TextStyle(
                  fontSize: ScreenUtilsManager.s12,
                  color: ColorManger.Lightgrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
