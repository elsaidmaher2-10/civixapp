import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:citifix/feature/workerFeature/tasks/tasksearchbar.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/ActiveTaskCard.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/CompeletedTask.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/TasksHeader.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/taskFilter.dart';
import 'package:flutter/material.dart';

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
    final filteredTasks = dummyReports.where((task) {
      if (selectedFilter == 'All') return true;
      return task.status.toLowerCase() == selectedFilter.toLowerCase();
    }).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
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
              onFilterSelected: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
                ;
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: filteredTasks.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ReportModelWorker task = filteredTasks[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
                  child:
                      StatusReport.fromString(task.status) ==
                          StatusReport.resolved
                      ? CompletedTaskCard(task: task)
                      : ActiveTaskCard(task: task),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
