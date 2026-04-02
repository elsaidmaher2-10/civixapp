import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_cubit.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_state.dart';
import 'package:citifix/feature/workerFeature/tasks/tasksearchbar.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/ActiveTaskCard.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/CompeletedTask.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/TasksHeader.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/taskFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  String selectedFilter = 'All';
  static const List<String> _filters = [
    'All',
    'Assigned',
    'InProgress',
    'Resolved',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: RefreshIndicator(
        onRefresh: () => context.read<WorkerTasksCubit>().getWorkerTasks(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            ScreenUtilsManager.w20,
            ScreenUtilsManager.h48,
            ScreenUtilsManager.w20,
            ScreenUtilsManager.h100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TasksHeader(),
              SizedBox(height: ScreenUtilsManager.h28),
              const TaskSearchBar(),
              SizedBox(height: ScreenUtilsManager.h24),
              TaskFilterChips(
                filters: _filters,
                onFilterSelected: (filter) =>
                    setState(() => selectedFilter = filter),
              ),
              SizedBox(height: ScreenUtilsManager.h16),

              BlocBuilder<WorkerTasksCubit, WorkerTasksState>(
                builder: (context, state) {
                  if (state is WorkerTasksLoading) {
                    return const TasksLoadingSkeleton();
                  }
                  if (state is WorkerTasksSuccess) {
                    final filteredTasks = state.response.items.where((task) {
                      if (selectedFilter == 'All') return true;
                      return task.status.toLowerCase() ==
                          selectedFilter.toLowerCase();
                    }).toList();

                    if (filteredTasks.isEmpty) {
                      return _EmptyState(
                        filterName: selectedFilter,
                        onReset: () => setState(() => selectedFilter = 'All'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredTasks.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        final isResolved =
                            StatusReport.fromString(task.status) ==
                            StatusReport.resolved;

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: ScreenUtilsManager.h16,
                          ),
                          child: isResolved
                              ? CompletedTaskCard(task: task)
                              : ActiveTaskCard(task: task),
                        );
                      },
                    );
                  }

                  if (state is WorkerTasksError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: GoogleFonts.cairo(color: Colors.red),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String filterName;
  final VoidCallback onReset;

  const _EmptyState({required this.filterName, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtilsManager.h6),
        child: Column(
          children: [
            Icon(
              Icons.assignment_late_outlined,
              size: 64,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            Text(
              "No tasks found for '$filterName'",
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (filterName != 'All')
              TextButton(onPressed: onReset, child: const Text("Clear Filter")),
          ],
        ),
      ),
    );
  }
}

class TasksLoadingSkeleton extends StatelessWidget {
  const TasksLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
          height: ScreenUtilsManager.h150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
          ),
        ),
      ),
    );
  }
}
