import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/reportdetails.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'deleteReportDialog.dart';

class Reportcard extends StatelessWidget {
  final ReportItem report;

  const Reportcard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    String translatedStatus = _getTranslatedStatus(context, report.status);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetailsScreen(reportId: report.id),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await showDeleteDialog(context, ReportID: report.id);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: S.of(context).delete,
              ),
            ],
          ),
          child: Container(
            height: 108.h,
            decoration: BoxDecoration(
              color: ColorManger.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Row(
                children: [
                  SizedBox(width: 11.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(
                            color: ColorManger.lightBlue,
                          ),
                      fit: BoxFit.cover,
                      height: 80.h,
                      width: 80.w,
                      imageUrl: report.imagesUrls.isNotEmpty
                          ? report.imagesUrls.first
                          : Constantmanger.defualtImage,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          report.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            color: ColorManger.kPrimaryDark,
                            fontSize: ScreenUtilsManager.s16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        _buildInfoRow(Icons.place_outlined, report.location),
                        _buildInfoRow(
                          Icons.watch_later_outlined,
                          report.createdAt.timeAgo(context),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusTag(context, report.status, translatedStatus),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14.h, color: ColorManger.lightGrey6),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              color: ColorManger.lightGrey6,
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTag(BuildContext context, String rawStatus, String label) {
    Color statusColor = _getStatusColor(rawStatus);
    return Container(
      margin: EdgeInsetsDirectional.only(end: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: statusColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: statusColor),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.cairo(
              color: statusColor,
              fontSize: ScreenUtilsManager.s12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
        return ColorManger.kPrimary;
    }
  }

  String _getTranslatedStatus(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return S.of(context).pending;
      case 'resolved':
        return S.of(context).resolved;
      case 'completed':
        return S.of(context).completed;
      default:
        return S.of(context).unknownStatus;
    }
  }
}
