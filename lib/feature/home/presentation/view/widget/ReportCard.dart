import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Reportcard extends StatelessWidget {
  const Reportcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Container(
        height: 108.h,
        decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              SizedBox(width: 11.w),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(5),
                child: Image.network(
                  fit: BoxFit.fill,
                  height: 80.h,
                  width: 80.w,
                  "https://www.shutterstock.com/shutterstock/photos/298199573/display_1500/stock-vector-business-report-paper-on-blue-background-with-long-shadow-modern-vector-illustration-flat-style-298199573.jpg",
                ),
              ),
              SizedBox(width: 23.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Street Hole",
                    style: GoogleFonts.publicSans(
                      color: ColorManger.kprimarydark,
                      fontSize: ScreenUtilsManager.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, size: 12.h),
                      SizedBox(width: 2.w),
                      Text(
                        "22-oraby street",
                        style: TextStyle(
                          color: ColorManger.Lightgrey6,
                          fontSize: ScreenUtilsManager.s12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilsManager.h16),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined, size: 12.h),
                      SizedBox(width: 5.w),
                      Text(
                        "2 hours ago",
                        style: TextStyle(
                          color: ColorManger.Lightgrey6,
                          fontSize: ScreenUtilsManager.s11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Spacer(),

              Container(
                margin: EdgeInsets.only(right: 22),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffF6DAC27D).withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/inprogress.svg"),
                    SizedBox(width: 5),
                    Text(
                      "inprogress",
                      style: TextStyle(color: Color(0xffFF7A07)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
