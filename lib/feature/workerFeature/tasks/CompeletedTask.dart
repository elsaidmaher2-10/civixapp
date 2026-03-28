import 'package:citifix/feature/workerFeature/tasks/taskScreen.dart';
import 'package:citifix/feature/workerFeature/tasks/testDummydata.dart';
import 'package:flutter/material.dart';

import '../verfication/verficationinit.dart';
import 'CompletedCheckIcon.dart';
import 'ManinfoItem.dart';
import 'TaskCardImage.dart';
import 'TaskStatusBadge.dart';

class CompletedTaskCard extends StatelessWidget {
  final TaskModel task;

  const CompletedTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          color: AppColors.surfaceLowest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.imageUrl != null) TaskCardImage(task: task),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                      const CompletedCheckIcon(),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const TaskStatusBadge(status: TaskStatus.completed),
                  const SizedBox(height: 8),
                  TaskAddressRow(address: task.address),
                  const SizedBox(height: 12),
                  Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.surfaceContainer, height: 1),
                  const SizedBox(height: 16),
                  if (task.completedDate != null)
                    MetaInfoItem(
                      icon: Icons.calendar_today_outlined,
                      label: task.completedDate!,
                      muted: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
