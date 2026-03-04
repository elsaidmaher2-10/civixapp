import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportCard.dart';
import 'package:citifix/feature/home/presentation/view/widget/statusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      floatingActionButton: SizedBox(
        height: ScreenUtilsManager.h70,
        width: ScreenUtilsManager.h70,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -74,
              right: -5,
              child: FloatingActionButton(
                splashColor: ColorManger.Lightgrey3,
                onPressed: () {},
                foregroundColor: ColorManger.white,
                backgroundColor: ColorManger.kprimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(50),
                ),
                child: Icon(Icons.add, size: 28.sp),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 22.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Over View",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: ColorManger.kprimary,
              ),
            ),
          ),
          SizedBox(height: 27.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatusCard(
                        number: 15,
                        title: Constantmanger.kActive,
                        iconPath: AssetValueManager.active,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        number: 10,
                        title: Constantmanger.kPending,
                        iconPath: AssetValueManager.pending,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        number: 20,
                        title: Constantmanger.kCompleted,
                        iconPath: AssetValueManager.resolved,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 22.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "My Resent Reports",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorManger.kprimary,
              ),
            ),
          ),
          SizedBox(height: 22.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 40),
              clipBehavior: Clip.none,
              itemCount: 10,
              itemBuilder: (context, index) => Reportcard(),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            ),
          ),
        ],
      ),
    );
  }
}
