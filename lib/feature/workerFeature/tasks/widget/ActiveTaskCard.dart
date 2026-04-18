import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:citifix/generated/l10n.dart';
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
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        border: Border.all(color: ColorManger.grey200.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: ColorManger.black.withOpacity(0.04),
            blurRadius: ScreenUtilsManager.r20,
            offset: Offset(0, ScreenUtilsManager.h10),
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
                        color: ColorManger.grey400,
                        fontSize: ScreenUtilsManager.s12,
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
          size: ScreenUtilsManager.s14,
          color: ColorManger.primaryColor,
        ),
        SizedBox(width: ScreenUtilsManager.w4),
        Expanded(
          child: Text(
            address,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s13,
              color: ColorManger.grey600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _AvailableActions extends StatefulWidget {
  const _AvailableActions({required this.id, required this.initstates});
  final String initstates;
  final int id;

  @override
  State<_AvailableActions> createState() => _AvailableActionsState();
}

class _AvailableActionsState extends State<_AvailableActions> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerTasksCubit, WorkerTasksState>(
      listener: (BuildContext context, WorkerTasksState state) {
        if (state is WorkerChangeTasksSuccess) {
          setState(() => isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ReportDetailsManager(
                  reportdetailsRepo: getIt<ReportdetailsRepo>(),
                )..getReportDetails(id: widget.id),
                child: TaskDetailsPage(reportid: widget.id),
              ),
            ),
          );
        } else if (state is WorkerChangeTasksError) {
          setState(() => isLoading = false);
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
        }
      },
      child: Row(
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
                    blurRadius: ScreenUtilsManager.s10,
                    offset: Offset(0, ScreenUtilsManager.h4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        setState(() => isLoading = true);
                        context.read<WorkerTasksCubit>().changeWorkerTaskStatus(
                          status: StatusReport.getNextStatus(
                            StatusReport.fromString(widget.initstates),
                          ).value,
                          reportId: widget.id,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                  ),
                ),
                child: isLoading
                    ? CupertinoActivityIndicator(color: ColorManger.white)
                    : Text(
                        S.of(context).startTask,
                        style: GoogleFonts.cairo(
                          color: ColorManger.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InProgressActions extends StatelessWidget {
  const _InProgressActions({required this.id});
  final int id;
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
          ),
          padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h12),
        ),
        child: Text(
          S.of(context).viewDirectionsUpdate,
          style: GoogleFonts.cairo(
            color: ColorManger.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
