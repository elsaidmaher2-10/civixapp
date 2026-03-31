import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Achievment/achievementModel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/resource/colormanager.dart';
import '../../../../../../core/resource/constantmanger.dart';
import '../../../../../../core/resource/screenutilsmaanger.dart';
import '../reportdetails.dart';

class AchievementReportCard extends StatelessWidget {
  final Achievementmodel report;

  const AchievementReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReportImage(),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusBadge(context),
                      SizedBox(height: 4.h),
                      Text(
                        report.title,
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManger.kPrimary,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      _buildInfoRow(
                        Icons.location_on_rounded,
                        report.areaName,
                        Colors.redAccent,
                      ),
                      _buildInfoRow(
                        Icons.business_rounded,
                        report.departmentName,
                        Colors.blueGrey,
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        "${S.of(context).worker}: ${report.workerName}",
                        style: GoogleFonts.cairo(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),

                      Text(
                        "${S.of(context).completed} ${report.resolvedAt.timeAgo(context)}",
                        style: GoogleFonts.cairo(
                          fontSize: 10.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar
          _buildBottomBar(context, isRtl),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 3.r, backgroundColor: Colors.green),
          SizedBox(width: 4.w),
          Text(
            S.of(context).completed.toUpperCase(),
            style: GoogleFonts.cairo(
              color: Colors.green,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 12.sp, color: iconColor),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.cairo(fontSize: 11.sp, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportImage() {
    return Hero(
      tag: "report_img_${report.reportId}",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CachedNetworkImage(
          width: 90.w,
          height: 90.w,
          fit: BoxFit.cover,
          placeholder: (_, __) =>
              const Center(child: CupertinoActivityIndicator()),
          errorWidget: (_, __, ___) =>
              Image.asset(Constantmanger.defualtImage, fit: BoxFit.cover),
          imageUrl: report.completionImageUrls.isNotEmpty
              ? report.completionImageUrls.first
              : Constantmanger.defualtImage,
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isRtl) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManger.lightColor.withOpacity(0.05),
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ID: #${report.reportId.toString().padLeft(5, '0')}",
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: ColorManger.kPrimary.withOpacity(0.7),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailsScreen(reportId: report.reportId),
              ),
            ),
            child: Row(
              children: [
                Text(
                  S.of(context).details,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: ColorManger.kPrimary,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: ColorManger.kPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
