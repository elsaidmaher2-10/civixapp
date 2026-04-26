import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/controller/tasksController.dart';
import 'package:citifix/feature/workerFeature/tasks/data/repos/worker_task_Repo.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_cubit.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_state.dart';
import 'package:citifix/feature/workerFeature/tasks/tasksearchbar.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/ActiveTaskCard.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/CompeletedTask.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/TasksHeader.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/taskFilter.dart';
import 'package:citifix/generated/l10n.dart';
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
        backgroundColor: context.palette.tasksBackground,
        body: RefreshIndicator(
          color: context.palette.workerprimary,
          backgroundColor: context.palette.white,
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
                  filtersen: Taskscontroller.filtersen(context),
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                BlocBuilder<WorkerTasksCubit, WorkerTasksState>(
                  buildWhen: (previous, current) =>
                      current is WorkerTasksLoading ||
                      current is WorkerTasksSuccess ||
                      current is WorkerTasksError,
                  builder: (context, state) {
                    if (state is WorkerTasksLoading) {
                      return const TasksLoadingSkeleton();
                    }
                    if (state is WorkerTasksSuccess) {
                      final filteredTasks = state.response.items.where((task) {
                        if (Taskscontroller.selectedFilter ==
                                S.of(context).all ||
                            Taskscontroller.selectedFilter == 'all') {
                          return true;
                        }
                        return task.status.trim().toLowerCase() ==
                            Taskscontroller.selectedFilter.trim().toLowerCase();
                      }).toList();

                      if (filteredTasks.isEmpty) {
                        return _EmptyState(
                          filterName: Taskscontroller.selectedFilter,
                          onReset: () => setState(
                            () => Taskscontroller.selectedFilter = S
                                .of(context)
                                .all,
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
      key: const Key('error'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.palette.error.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 50,
                color: context.palette.error,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).errorTitle,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.palette.workerprimary,
                foregroundColor: context.palette.onPrimary,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w24,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => onRetry(),
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                S.of(context).tryAgain,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: ScreenUtilsManager.h40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_late_outlined,
            size: ScreenUtilsManager.r64,
            color: context.palette.grey300,
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Text(
            S
                .of(context)
                .noTasksFound(Taskscontroller.transalte(filterName, context)),
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s16,
              color: context.palette.grey600,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onReset,
            child: Text(
              S.of(context).showAllTasks,
              style: GoogleFonts.cairo(color: context.palette.workerprimary),
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
      baseColor: context.palette.grey300,
      highlightColor: context.palette.grey200,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
            height: ScreenUtilsManager.h150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.palette.white,
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            ),
          ),
        ),
      ),
    );
  }
}
