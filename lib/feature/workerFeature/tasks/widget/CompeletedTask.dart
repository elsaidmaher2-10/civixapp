import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart'; 
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/DI/getit.dart';
import '../../taskDetails/TaskDetailsPage.dart';
import '../../taskDetails/data/repos/reportdetails.dart';
import '../../taskDetails/presentation/manager/reportdetailsManger.dart';

class CompletedTaskCard extends StatelessWidget {
  final ReportModelWorker task;
  const CompletedTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => ReportDetailsManager(
                reportdetailsRepo: getIt<ReportdetailsRepo>(),
              )..getReportDetails(id: task.id),
              child: TaskDetailsPage(reportid: task.id),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w16),
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
          border: Border.all(
            color: context.palette.outline.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w8),
              decoration: BoxDecoration(
                color: context.palette.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: context.palette.success,
                size: ScreenUtilsManager.s20,
              ),
            ),
            SizedBox(width: ScreenUtilsManager.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.cairo(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: context.palette.onSurfaceVariant.withOpacity(0.5),
                      color: context.palette.onSurfaceVariant.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtilsManager.s14,
                    ),
                  ),
                  Text(
                    S
                        .of(context)
                        .completedFrom(task.createdAt.timeAgo(context)),
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s12,
                      color: context.palette.onSurfaceVariant.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: ScreenUtilsManager.s14,
              color: context.palette.onSurfaceVariant.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
