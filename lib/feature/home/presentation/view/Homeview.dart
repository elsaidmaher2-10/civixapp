import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/view/ReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/allReportsScree.dart';
import 'package:citifix/feature/home/presentation/view/widget/MainscreenAppbar.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportCard.dart';
import 'package:citifix/feature/home/presentation/view/widget/statusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.Lightgrey5,
      appBar: const MainscreenAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtilsManager.h24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w16),
            child: Row(
              children: [
                SvgPicture.asset(AssetValueManager.overVeiw),
                SizedBox(width: ScreenUtilsManager.w8),
                Text(
                  Constantmanger.overview,
                  style: GoogleFonts.publicSans(
                    letterSpacing: -0.8,
                    color: ColorManger.kprimarydark,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtilsManager.s20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatusCard(
                        color: ColorManger.kprimary,
                        number: 15,
                        title: Constantmanger.kActive,
                        iconPath: AssetValueManager.active,
                        iconcolor: ColorManger.kprimary,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        color: ColorManger.orange,
                        number: 10,
                        title: Constantmanger.kPending,
                        iconPath: AssetValueManager.pending,
                        iconcolor: ColorManger.orange,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        number: 20,
                        title: Constantmanger.kCompleted,
                        iconPath: AssetValueManager.resolved,
                        color: ColorManger.green,
                        iconcolor: ColorManger.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: ScreenUtilsManager.h22),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w16),
            child: Row(
              children: [
                Text(
                  Constantmanger.recenreport,
                  style: GoogleFonts.publicSans(
                    fontSize: ScreenUtilsManager.s18,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.kprimarydark,
                  ),
                ),
                Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color.fromRGBO(0, 51, 102, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => ReportsPage()),
                    );
                  },
                  child: Text(
                    Constantmanger.seeall,
                    style: GoogleFonts.publicSans(
                      fontSize: ScreenUtilsManager.s14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h22),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 40),
              itemCount: 3,
              itemBuilder: (context, index) => Reportcard(),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            ),
          ),
        ],
      ),
    );
  }
}
