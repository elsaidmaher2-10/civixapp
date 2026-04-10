import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/repos/reportdetails.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import 'package:citifix/feature/workerFeature/tasks/controller/tasksController.dart';
import 'package:citifix/feature/workerFeature/tasks/data/repos/worker_task_Repo.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_cubit.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_state.dart';
import 'package:citifix/feature/workerFeature/tasks/tasksearchbar.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/ActiveTaskCard.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/CompeletedTask.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/TasksHeader.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/taskFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late WorkerTasksCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = WorkerTasksCubit(getIt<WorkerTaskRepo>())..getWorkerTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: RefreshIndicator(
          color: ColorManger.workerprimary,
          backgroundColor: ColorManger.white,
          onRefresh: () => _cubit.getWorkerTasks(),
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
                  filters: Taskscontroller.filters(context),
                  onFilterSelected: (filter) {
                    setState(() {
                      Taskscontroller.selectedFilter = filter;
                    });
                  },
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                BlocBuilder<WorkerTasksCubit, WorkerTasksState>(
                  builder: (context, state) {
                    if (state is WorkerTasksLoading) {
                      return const TasksLoadingSkeleton();
                    }

                    if (state is WorkerTasksSuccess) {
                      final filteredTasks = state.response.items.where((task) {
                        if (Taskscontroller.selectedFilter == 'All') {
                          return true;
                        }
                        return task.status.trim().toLowerCase() ==
                            Taskscontroller.selectedFilter.trim().toLowerCase();
                      }).toList();

                      if (filteredTasks.isEmpty) {
                        return _EmptyState(
                          filterName: Taskscontroller.selectedFilter,
                          onReset: () => setState(
                            () => Taskscontroller.selectedFilter = 'All',
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredTasks.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          final status = StatusReport.fromString(task.status);
                          bool isResolved =
                              status == StatusReport.resolved ||
                              status == StatusReport.completed;

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
                      return _ErrorState(
                        errorMessage: state.message,
                        onRetry: () => _cubit.getWorkerTasks(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorState({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isNoInternet = errorMessage.contains(Constantmanger.nointernet);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Icon(
            isNoInternet ? Icons.wifi_off : Icons.error_outline,
            size: 60.r,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            isNoInternet ? "No Internet Connection" : "Something went wrong",
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(color: Colors.grey, fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManger.workerprimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: onRetry,
            child: Text(
              "Retry",
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: ScreenUtilsManager.h40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_late_outlined,
            size: 64.r,
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
          TextButton(
            onPressed: onReset,
            child: Text(
              "Show all tasks",
              style: GoogleFonts.cairo(color: ColorManger.workerprimary),
            ),
          ),
        ],
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
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
            height: ScreenUtilsManager.h150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            ),
          ),
        ),
      ),
    );
  }
}
