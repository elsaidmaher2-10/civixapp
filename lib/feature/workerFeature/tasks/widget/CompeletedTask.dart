import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
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
          color: Colors.grey.shade50.withOpacity(0.8),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
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
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Completed from ${task.createdAt.timeAgo(context)}',
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
