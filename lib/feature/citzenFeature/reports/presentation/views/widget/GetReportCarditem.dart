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

class ReportCardIem extends StatelessWidget {
  final ReportItem report;
  final Color statusColor;

  const ReportCardIem({
    super.key,
    required this.report,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtilsManager.h16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: ScreenUtilsManager.w8,
                              height: ScreenUtilsManager.h8,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: ScreenUtilsManager.h8),
                            Text(
                              _getTranslatedStatus(context, report.status),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: ScreenUtilsManager.s10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtilsManager.h8),
                        Text(
                          report.title,
                          style: GoogleFonts.publicSans(
                            fontSize: ScreenUtilsManager.s18,
                            fontWeight: FontWeight.bold,
                            color: ColorManger.kPrimary,
                          ),
                        ),
                        SizedBox(height: ScreenUtilsManager.h6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(width: ScreenUtilsManager.w4),
                            Expanded(
                              child: Text(
                                report.location,
                                style: GoogleFonts.publicSans(
                                  fontSize: ScreenUtilsManager.s12,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtilsManager.h12),
                        Text(
                          '${S.of(context).submitted} ${report.createdAt.timeAgo}',
                          style: TextStyle(
                            fontSize: ScreenUtilsManager.s11,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(
                            color: ColorManger.lightColor,
                          ),
                      width: ScreenUtilsManager.w80,
                      height: ScreenUtilsManager.h80,
                      fit: BoxFit.cover,
                      imageUrl: report.imagesUrls.isNotEmpty
                          ? report.imagesUrls.first
                          : Constantmanger.defualtImage,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilsManager.w16,
                vertical: ScreenUtilsManager.h12,
              ),
              decoration: BoxDecoration(
                color: ColorManger.white,
                border: Border(
                  top: BorderSide(color: Colors.black.withOpacity(0.05)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).reference} ${report.id.toString().padLeft(5, '0')}',
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: ColorManger.lightColor,
                    ),
                  ),
                  Material(
                    color: ColorManger.lightColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                    child: InkWell(
                      onTap: () async {
                        final reportCubit = context.read<ReportCubit>();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReportDetailsScreen(reportId: report.id),
                          ),
                        );
                        if (context.mounted) {
                          await reportCubit.fetchReports();
                        }
                      },
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r8,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilsManager.w12,
                          vertical: ScreenUtilsManager.h6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).details,
                              style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtilsManager.s12,
                                color: ColorManger.lightColor,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                              size: ScreenUtilsManager.h16,
                              color: ColorManger.lightColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTranslatedStatus(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return S.of(context).pending.toUpperCase();
      case 'resolved':
        return S.of(context).resolved.toUpperCase();
      case 'completed':
        return S.of(context).completed.toUpperCase();
      default:
        return status.toUpperCase();
    }
  }
}
