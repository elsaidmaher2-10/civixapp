import 'dart:developer';

import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
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

  void _onStepTap(int index) {
    final tappedStatus = _stepsOrder[index];
    final currentIndex = _stepsOrder.indexOf(_currentStatus);
    if (index <= currentIndex) {
      return;
    }

    if (index > currentIndex + 1) {
      Customsnackbar.show(
        context: context,
        backgroundColor: ColorManger.red,
        message: "Next step: ${_stepsOrder[currentIndex + 1].value}",
      );
      return;
    }

    if (tappedStatus == StatusReport.resolved) {
      if (widget.isCompleted == false) {
        Customsnackbar.show(
          context: context,
          backgroundColor: ColorManger.red,
          message:
              "You must complete the required report\nimages before finishing the task.",
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ColorManger.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.event_repeat,
                  color: ColorManger.workerprimary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'ACTIVITY TIMELINE',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
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
                    width: 26,
                    height: 26,
                    indicator: GestureDetector(
                      onTap: () => _onStepTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCompletedStatus
                              ? ColorManger.workerprimary
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompletedStatus
                                ? ColorManger.workerprimary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: isCompletedStatus
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              )
                            : null,
                      ),
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: isCompletedStatus
                        ? ColorManger.workerprimary
                        : Colors.grey.shade200,
                    thickness: 2,
                  ),
                  afterLineStyle: LineStyle(
                    color:
                        (index < _stepsOrder.length - 1 && currentIndex > index)
                        ? ColorManger.workerprimary
                        : Colors.grey.shade200,
                    thickness: 2,
                  ),
                  endChild: GestureDetector(
                    onTap: () => _onStepTap(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stepStatus.value,
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isCompletedStatus
                                  ? Colors.black87
                                  : Colors.grey,
                            ),
                          ),

                          Text(
                            curdate.toString(),
                            style: GoogleFonts.cairo(
                              fontSize: 12,
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
