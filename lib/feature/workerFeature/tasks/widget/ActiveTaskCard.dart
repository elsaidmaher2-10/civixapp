import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/DI/getit.dart';
import '../../../../core/widget/CustomSnackBar.dart';
import '../../../../core/widget/stautsBageApp.dart';
import '../../taskDetails/data/repos/reportdetails.dart';
import '../../taskDetails/presentation/manager/reportdetailsManger.dart';
import '../presentation/manager/cubit/task_report_cubit.dart';
import '../presentation/manager/cubit/task_report_state.dart';

class ActiveTaskCard extends StatelessWidget {
  final ReportModelWorker task;

  const ActiveTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.imagesUrls.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtilsManager.r16),
              ),
              child: Image.network(
                task.imagesUrls.first,
                height: ScreenUtilsManager.h150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(ScreenUtilsManager.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusBadgeApp(status: task.status),
                    Text(
                      "#${task.id}",
                      style: GoogleFonts.cairo(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilsManager.h12),
                Text(
                  task.title,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s18,
                    fontWeight: FontWeight.w800,
                    color: ColorManger.onSurface,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h6),
                _LocationRow(address: task.areaName),
              ],
            ),
          ),

          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(ScreenUtilsManager.w16),
            child:
                StatusReport.fromString(task.status) == StatusReport.inProgress
                ? _InProgressActions(id: task.id)
                : _AvailableActions(id: task.id, initstates: task.status),
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String address;
  const _LocationRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 14,
          color: ColorManger.primaryColor,
        ),
        SizedBox(width: ScreenUtilsManager.w4),
        Expanded(
          child: Text(
            address,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s13,
              color: Colors.grey.shade600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  final StatusReport status;
  const StatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    Color color = status == StatusReport.assigned
        ? Colors.orange
        : ColorManger.primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: GoogleFonts.cairo(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AvailableActions extends StatelessWidget {
  const _AvailableActions({required this.id, required this.initstates});
  final String initstates;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkerTasksCubit, WorkerTasksState>(
      listener: (BuildContext context, WorkerTasksState state) {
        if (state is WorkerChangeTasksSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ReportDetailsManager(
                  reportdetailsRepo: getIt<ReportdetailsRepo>(),
                )..getReportDetails(id: id),
                child: TaskDetailsPage(reportid: id),
              ),
            ),
          );
        } else if (state is WorkerChangeTasksError) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
        }
      },
      builder: (BuildContext context, WorkerTasksState state) {
        return Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManger.workerprimary,
                      ColorManger.workerprimary.withAlpha(200),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManger.workerprimary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<WorkerTasksCubit>().changeWorkerTaskStatus(
                      status: StatusReport.getNextStatus(
                        StatusReport.fromString(initstates),
                      ).value,
                      reportId: id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtilsManager.h12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r8,
                      ),
                    ),
                  ),
                  child: state is WorkerTasksLoading
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : Text(
                          'Start Task',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InProgressActions extends StatelessWidget {
  _InProgressActions({required this.id});
  final id;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ReportDetailsManager(
                  reportdetailsRepo: getIt<ReportdetailsRepo>(),
                )..getReportDetails(id: id),
                child: TaskDetailsPage(reportid: id),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'View Directions & Update',
          style: GoogleFonts.cairo(color: Colors.white),
        ),
      ),
    );
  }
}
