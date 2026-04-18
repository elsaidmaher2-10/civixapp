import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String title;
  final bool isFirst;
  final bool isLast;
  final bool isDone;
  final String timeline;

  const CustomTimelineTile({
    super.key,
    required this.title,
    required this.timeline,
    this.isFirst = false,
    this.isLast = false,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 24.w,
          height: 24.w,
          indicator: _buildIndicator(context),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
        ),
        beforeLineStyle: LineStyle(
          color: isDone ? context.palette.kPrimary : Colors.grey[300]!,
          thickness: 3,
        ),
        endChild: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                  color: isDone ? Colors.black : Colors.grey[600],
                ),
              ),
              Text(
                timeline,
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? context.palette.kPrimary : Colors.white,
        border: Border.all(
          color: isDone ? context.palette.kPrimary : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: isDone ? Icon(Icons.check, size: 14.w, color: Colors.white) : null,
    );
  }
}
