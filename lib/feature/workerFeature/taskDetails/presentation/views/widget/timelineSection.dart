import 'dart:developer';

import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../../core/service/StatusReport.dart';
import '../../../../tasks/presentation/manager/cubit/task_report_cubit.dart';
import '../../../../tasks/presentation/manager/cubit/task_report_state.dart';
import '../../../data/model/taskdetailsmodel.dart';

class ActivityTimelineSection extends StatefulWidget {
  final String initialStatus;
  final int id;
  final List<TimelineModel> timeline;
  final bool isCompleted;
  const ActivityTimelineSection({
    super.key,
    required this.initialStatus,
    required this.isCompleted,
    required this.timeline,
    required this.id,
  });

  @override
  State<ActivityTimelineSection> createState() =>
      _ActivityTimelineSectionState();
}

class _ActivityTimelineSectionState extends State<ActivityTimelineSection> {
  // رجعناها زي ما كانت عشان تحافظ على الـ Logic والـ indexOf يشتغل صح
  final List<StatusReport> _stepsOrder = [
    StatusReport.pending,
    StatusReport.assigned,
    StatusReport.inProgress,
    StatusReport.resolved,
  ];

  late StatusReport _currentStatus;
  late StatusReport _previousStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = StatusReport.fromString(widget.initialStatus);
    _previousStatus = _currentStatus;
  }

  String _getLocalizedStepName(BuildContext context, StatusReport status) {
    if (status == StatusReport.pending) return S.of(context).pending;
    if (status == StatusReport.assigned) return S.of(context).assigned;
    if (status == StatusReport.inProgress) return S.of(context).inProgress;
    if (status == StatusReport.resolved) return S.of(context).resolved;
    return status.value;
  }

  void _onStepTap(int index) {
    final tappedStatus = _stepsOrder[index];
    final currentIndex = _stepsOrder.indexOf(_currentStatus);
    if (index <= currentIndex) {
      return;
    }

    if (index > currentIndex + 1) {
      final nextStepName = _getLocalizedStepName(
        context,
        _stepsOrder[currentIndex + 1],
      );
      Customsnackbar.show(
        context: context,
        backgroundColor: ColorManger.red,
        message: S.of(context).nextStep(nextStepName),
      );
      return;
    }

    if (tappedStatus == StatusReport.resolved) {
      if (widget.isCompleted == false) {
        Customsnackbar.show(
          context: context,
          backgroundColor: ColorManger.red,
          message: S.of(context).mustCompleteReportImages,
        );
        return;
      }
    }

    setState(() {
      _previousStatus = _currentStatus;
      _currentStatus = tappedStatus;
    });

    context.read<WorkerTasksCubit>().changeWorkerTaskStatus(
      status: tappedStatus.value,
      reportId: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerTasksCubit, WorkerTasksState>(
      listener: (BuildContext context, WorkerTasksState state) {
        if (state is WorkerChangeTasksError) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
          setState(() {
            _currentStatus = _previousStatus;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtilsManager.w24),
        decoration: BoxDecoration(
          color: ColorManger.surface,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          border: Border.all(color: ColorManger.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.event_repeat,
                  color: ColorManger.workerprimary,
                  size: ScreenUtilsManager.s16,
                ),
                SizedBox(width: ScreenUtilsManager.w8),
                Text(
                  S.of(context).activityTimeline,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _stepsOrder.length,
              itemBuilder: (context, index) {
                final stepStatus = _stepsOrder[index];
                final int currentIndex = _stepsOrder.indexOf(_currentStatus);
                final bool isCompletedStatus = currentIndex >= index;

                String curdate = "";
                if (index <= widget.timeline.length - 1) {
                  final parsedDate = DateTime.tryParse(
                    widget.timeline[index].date,
                  );
                  curdate = parsedDate?.timeAgo(context) ?? "";
                }

                return TimelineTile(
                  alignment: TimelineAlign.start,
                  isFirst: index == 0,
                  isLast: index == _stepsOrder.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: ScreenUtilsManager.w26,
                    height: ScreenUtilsManager.h26,
                    indicator: GestureDetector(
                      onTap: () => _onStepTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCompletedStatus
                              ? ColorManger.workerprimary
                              : ColorManger.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompletedStatus
                                ? ColorManger.workerprimary
                                : ColorManger.grey300,
                            width: ScreenUtilsManager.w2,
                          ),
                        ),
                        child: isCompletedStatus
                            ? Icon(
                                Icons.check,
                                color: ColorManger.white,
                                size: ScreenUtilsManager.s14,
                              )
                            : null,
                      ),
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: isCompletedStatus
                        ? ColorManger.workerprimary
                        : ColorManger.grey200,
                    thickness: ScreenUtilsManager.w2,
                  ),
                  afterLineStyle: LineStyle(
                    color:
                        (index < _stepsOrder.length - 1 && currentIndex > index)
                        ? ColorManger.workerprimary
                        : ColorManger.grey200,
                    thickness: ScreenUtilsManager.w2,
                  ),
                  endChild: GestureDetector(
                    onTap: () => _onStepTap(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w16,
                        vertical: ScreenUtilsManager.h12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getLocalizedStepName(context, stepStatus),
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s14,
                              fontWeight: FontWeight.bold,
                              color: isCompletedStatus
                                  ? ColorManger.black87
                                  : ColorManger.grey,
                            ),
                          ),

                          Text(
                            curdate.toString(),
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s12,
                              color: ColorManger.lightGrey6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
