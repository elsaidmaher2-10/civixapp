import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/tasks/taskFilter.dart';
import 'package:citifix/feature/workerFeature/tasks/tasksearchbar.dart';
import 'package:citifix/feature/workerFeature/tasks/testDummydata.dart';
import 'package:flutter/material.dart';
import '../verfication/verficationinit.dart';
import 'ActiveTaskCard.dart';
import 'CompeletedTask.dart';
import 'TaskStatusBadge.dart';
import 'TasksHeader.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  static const List<String> _filters = [
    'All',
    'Available',
    'In Progress',
    'Completed',
    'High Priority',
    'Near',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TasksHeader(),
          const SizedBox(height: 32),
          TaskSearchBar(),
          const SizedBox(height: 24),
          TaskFilterChips(
            filters: _filters,
            filter: (String selecteFilter) {
              final filtredList = dummyTasks
                  .where(
                    (e) => e.status == TaskStatus.fromString(selecteFilter),
                  )
                  .toList();
            },
          ),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            itemCount: dummyTasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (dummyTasks[index].status == TaskStatus.completed) {
                return CompletedTaskCard(task: dummyTasks[index]);
              } else {
                return ActiveTaskCard(task: dummyTasks[index]);
              }
            },
          ),
        ],
      ),
    );
  }
}

class HighPriorityBadge extends StatelessWidget {
  const HighPriorityBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: ColorManger.errorContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Text(
        'HIGH PRIORITY',
        style: TextStyle(
          color: ColorManger.onErrorContainer,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class TaskAddressRow extends StatelessWidget {
  final String address;
  const TaskAddressRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 18,
          color: ColorManger.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          address,
          style: const TextStyle(
            fontSize: 14,
            color: ColorManger.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class TaskProgressBar extends StatelessWidget {
  final double progress;
  const TaskProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TASK COMPLETION',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: ColorManger.onSurfaceVariant,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: ColorManger.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManger.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.8,
            child: Container(
              decoration: BoxDecoration(
                gradient: ColorManger.kineticGradient,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AvailableActions extends StatelessWidget {
  const AvailableActions();
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFD32F2F),
            side: BorderSide(color: const Color(0xFFD32F2F).withOpacity(0.5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          child: const Text('Refuse'),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: ColorManger.kineticGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InProgressActions extends StatelessWidget {
  const InProgressActions();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: const Color(0xFFACADAD).withOpacity(0.3)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: ColorManger.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          child: const Text('View Details'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManger.onSurface,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 0,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          child: const Text('Update Status'),
        ),
      ],
    );
  }
}
