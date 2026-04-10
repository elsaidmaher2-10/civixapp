import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../../core/service/StatusReport.dart';
import '../../../../tasks/data/repos/worker_task_Repo.dart';
import '../../../../tasks/presentation/manager/cubit/task_report_cubit.dart';
import '../../../../tasks/presentation/manager/cubit/task_report_state.dart';
import '../../manager/reportdetailsManger.dart';

class ActivityTimelineSection extends StatefulWidget {
  final String initialStatus;
  final int id;
  final bool isCompleted;

  const ActivityTimelineSection({
    super.key,
    required this.initialStatus,
    required this.isCompleted,
    required this.id,
  });

  @override
  State<ActivityTimelineSection> createState() =>
      _ActivityTimelineSectionState();
}

class _ActivityTimelineSectionState extends State<ActivityTimelineSection> {
  final List<StatusReport> _stepsOrder = [
    StatusReport.assigned,
    StatusReport.inProgress,
    StatusReport.resolved,
  ];

  late StatusReport _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = StatusReport.fromString(widget.initialStatus);
    print("_currentStatus $_currentStatus");
  }

  void _onStepTap(int index) {
    final tappedStatus = _stepsOrder[index];

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

    if (tappedStatus == _currentStatus.getNextStatus(_currentStatus)) {
      setState(() {
        _currentStatus = tappedStatus;
      });

      context.read<WorkerTasksCubit>().changeWorkerTaskStatus(
        status: tappedStatus.value,
        reportId: widget.id,
      );
    } else {
      if (_stepsOrder.indexOf(tappedStatus) <=
          _stepsOrder.indexOf(_currentStatus)) {
        return;
      }

      Customsnackbar.show(
        context: context,
        backgroundColor: ColorManger.red,
        message:
            "Next step: ${_currentStatus.getNextStatus(_currentStatus).value}",
      );
    }
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
                final bool isCompleted = currentIndex >= index;
                final bool isCurrent = currentIndex == index;

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
                          color: isCompleted
                              ? ColorManger.workerprimary
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompleted
                                ? ColorManger.workerprimary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: isCompleted
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
                    color: isCompleted
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
                              color: isCompleted ? Colors.black87 : Colors.grey,
                            ),
                          ),
                          if (isCurrent)
                            Text(
                              "Current Stage",
                              style: GoogleFonts.cairo(
                                fontSize: 10,
                                color: ColorManger.workerprimary,
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
