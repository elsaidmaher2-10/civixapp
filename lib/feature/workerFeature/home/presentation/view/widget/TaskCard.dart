import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customShimerwidget.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/repos/reportdetails.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final RecentReportModel report;

  const TaskCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtilsManager.w280,
      margin: EdgeInsets.only(right: ScreenUtilsManager.w16),
      padding: EdgeInsets.all(ScreenUtilsManager.w12),
      decoration: BoxDecoration(
        color: context.palette.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        border: Border.all(
          color: context.palette.outline.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: ScreenUtilsManager.s10,
            offset: Offset(ScreenUtilsManager.w0, ScreenUtilsManager.h4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => BlocProvider(
                        create: (c) => ReportDetailsManager(
                          reportdetailsRepo: getIt<ReportdetailsRepo>(),
                        ),
                        child: TaskDetailsPage(reportid: report.id),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return customShimer(context, ScreenUtilsManager.h150);
                    },
                    height: ScreenUtilsManager.h130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: report.imageUrls.isNotEmpty
                        ? report.imageUrls.first
                        : Constantmanger.defualtImage,
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtilsManager.h8,
                right: ScreenUtilsManager.w8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w10,
                    vertical: ScreenUtilsManager.h4,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
                  ),
                  child: Text(
                    report.status,
                    style: GoogleFonts.cairo(
                      color: context.palette.onPrimary,
                      fontSize: ScreenUtilsManager.s10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          Text(
            report.categoryName.toUpperCase(),
            style: GoogleFonts.cairo(
              color: context.palette.primaryColor,
              fontSize: ScreenUtilsManager.s10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h4),
          Text(
            report.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s16,
              color: context.palette.onSurface,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant,
              ),
              SizedBox(width: ScreenUtilsManager.w4),
              Expanded(
                child: Text(
                  report.areaName,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s12,
                    color: context.palette.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                "${report.createdAt.day}/${report.createdAt.month}",
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s11,
                  color: context.palette.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
