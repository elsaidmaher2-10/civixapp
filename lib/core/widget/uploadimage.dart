import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart'; 

class Uploadimage extends StatelessWidget {
  const Uploadimage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: const Color(0xff64748B),
        dashPattern: const [10, 5],
        borderPadding: const EdgeInsets.all(5),
        strokeWidth: 0.8,
        radius: const Radius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(25.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/camera.svg", width: 20.w, height: 22.h),
              SizedBox(height: 7.h),
              Text(
                S.of(context).addPhoto,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s12,
                  color: context.palette.lightGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
