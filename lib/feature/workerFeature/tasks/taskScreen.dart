import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/ActiveTaskCard.dart';
import 'package:citifix/feature/workerFeature/tasks/widget/CompeletedTask.dart';
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
    'Available',
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
            const _TaskSearchBar(),
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

class TasksHeader extends StatelessWidget {
  const TasksHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800,
                fontSize: ScreenUtilsManager.s32,
                color: ColorManger.onSurface,
                letterSpacing: -1,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: ColorManger.primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.notifications_none,
                color: ColorManger.primaryColor,
              ),
            ),
          ],
        ),
        Text(
          'Keep track of your daily progress',
          style: TextStyle(
            fontSize: ScreenUtilsManager.s15,
            color: ColorManger.onSurfaceVariant.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TaskSearchBar extends StatelessWidget {
  const _TaskSearchBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for tasks...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: ScreenUtilsManager.s14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: ColorManger.primaryColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtilsManager.h16,
          ),
        ),
      ),
    );
  }
}
