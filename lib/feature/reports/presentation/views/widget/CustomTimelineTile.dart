import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String title;
  final bool isFirst;
  final bool isLast;
  final bool isDone;

  const CustomTimelineTile({
    super.key,
    required this.title,
    this.isFirst = false,
    this.isLast = false,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        alignment: TimelineAlign.start,
        lineXY: 0.1,
        beforeLineStyle: LineStyle(
          color: isDone
              ? isLast
                    ? ColorManger.green
                    : ColorManger.kPrimary
              : Colors.grey.shade300,
          thickness: 3,
        ),
        afterLineStyle: LineStyle(
          color: isDone
              ? isLast
                    ? ColorManger.green
                    : ColorManger.kPrimary
              : Colors.grey.shade300,
          thickness: 3,
        ),
        indicatorStyle: IndicatorStyle(
          width: 25.w,
          color: isDone
              ? isLast
                    ? ColorManger.green
                    : ColorManger.kPrimary
              : Colors.grey.shade400,
          iconStyle: isDone
              ? IconStyle(
                  iconData: Icons.check,
                  color: Colors.white,
                  fontSize: 14.sp,
                )
              : null,
        ),
        endChild: Container(
          padding: EdgeInsets.only(left: 16.w),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isDone && isLast
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 16.sp,
              color: isDone && isLast
                  ? ColorManger.green
                  : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
