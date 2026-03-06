import 'dart:async';
import 'dart:io';

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
        dashPattern: [10, 5],
        borderPadding: EdgeInsets.all(5),
        strokeWidth: 0.8,
        radius: Radius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(25.h),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              SvgPicture.asset("assets/camera.svg"),
              SizedBox(height: 7.h),
              Text("add photo"),
            ],
          ),
        ),
      ),
    );
  }
}
