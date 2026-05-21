import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final int number;
  final Color? color;
  final Color iconcolor;

  const StatusCard({
    super.key,
    required this.number,
    required this.title,
    required this.iconPath,
    this.color,
    required this.iconcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106.h,
      decoration: BoxDecoration(
        color: context.palette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.palette.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 18.w,
                height: 18.w,
                colorFilter: ColorFilter.mode(iconcolor, BlendMode.srcIn),
              ),
              SizedBox(width: 4.w),

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cairo(
                    color: context.palette.onSurfaceVariant,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              number.toString(),
              style: GoogleFonts.cairo(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
