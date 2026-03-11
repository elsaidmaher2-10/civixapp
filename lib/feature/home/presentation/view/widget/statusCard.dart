import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final int number;

  const StatusCard({
    required this.color,
    required this.iconcolor,
    super.key,
    required this.number,
    required this.title,
    required this.iconPath,
  });
  final Color? color;
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106.h,
      decoration: BoxDecoration(
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(iconcolor, BlendMode.srcATop),
              ),
              SizedBox(width: 8.w),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: ColorManger.Lightgrey6,
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
            style: GoogleFonts.publicSans(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtilsManager.s24,
            ),
          ),
        ],
      ),
    );
  }
}
