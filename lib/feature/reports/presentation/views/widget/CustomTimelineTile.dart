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
        alignment: TimelineAlign.start,
        lineXY: 0,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 24.w,
          height: 24.w,
          padding: EdgeInsets.zero, 
          color: isDone ? ColorManger.kPrimary : Colors.grey[300]!,
        ),

        endChild: Container(
          padding: EdgeInsetsDirectional.only(
            start: 12.w, 
            top: 20.h,
            bottom: 20.h,
          ),
          alignment: AlignmentDirectional
              .centerStart,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.sp,
              color: isDone ? Colors.black : Colors.grey[600],
              // ...
            ),
          ),
        ),

        beforeLineStyle: LineStyle(
          color: isDone ? ColorManger.kPrimary : Colors.grey[300]!,
          thickness: 2,
        ),
      ),
    );
  }
}
