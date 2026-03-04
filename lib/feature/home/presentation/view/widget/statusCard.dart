import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final int number;

  const StatusCard({
    super.key,
    required this.number,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101.h,
      decoration: BoxDecoration(
        color: ColorManger.Lightgrey4,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SvgPicture.asset(iconPath),
              SizedBox(width: 8.w),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  text: title,
                ),
              ),
            ],
          ),
          Text(
            number.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
