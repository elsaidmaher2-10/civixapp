import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportCard.dart';
import 'package:citifix/feature/home/presentation/view/widget/statusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManger.white,
      child: Column(
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
              "My Recent Reports",
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
              padding: const EdgeInsets.only(bottom: 40),
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
