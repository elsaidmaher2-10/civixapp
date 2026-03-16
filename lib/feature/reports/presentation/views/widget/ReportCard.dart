import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Reportcard extends StatelessWidget {
  final ReportResponseModel report;

  const Reportcard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 108.h,
        decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              SizedBox(width: 11.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(color: ColorManger.Lightblue),
                  fit: BoxFit.cover,
                  height: 80.h,
                  width: 80.w,
                  imageUrl: report.imagesUrls.isNotEmpty
                      ? report.imagesUrls.first
                      : Constantmanger.defualtImage,
                ),
              ),
              SizedBox(width: 23.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      report.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            report.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorManger.Lightgrey6,
                              fontSize: ScreenUtilsManager.s12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined, size: 12.h),
                        SizedBox(width: 5.w),
                        Text(
                          DateFormat.yMMMd().format(report.createdAt),
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
              ),

              // --- Dynamic Status Badge ---
              Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: _getStatusColor(report.status).withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: _getStatusColor(report.status),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      report.status.toLowerCase(),
                      style: TextStyle(
                        color: _getStatusColor(report.status),
                        fontSize: ScreenUtilsManager.s12,
                        fontWeight: FontWeight.bold,
                      ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFF7A07);
      case 'completed':
      case 'resolved':
        return Colors.green;
      default:
        return ColorManger.kprimary;
    }
  }
}
