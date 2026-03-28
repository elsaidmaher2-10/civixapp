import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/tasks/taskScreen.dart';
import 'package:citifix/feature/workerFeature/tasks/testDummydata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../verfication/verficationinit.dart';
import 'ManinfoItem.dart';
import 'TaskCardImage.dart';
import 'TaskStatusBadge.dart';

class ActiveTaskCard extends StatelessWidget {
  final TaskModel task;

  const ActiveTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool isInProgress = task.status == TaskStatus.inProgress;

    return Container(
      decoration: BoxDecoration(
        color: ColorManger.surfaceLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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
                          color: ColorManger.onSurface,
                        ),
                      ),
                    ),
                    TaskStatusBadge(status: task.status),
                  ],
                ),
                const SizedBox(height: 8),
                TaskAddressRow(address: task.address),
                const SizedBox(height: 12),
                Text(
                  task.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorManger.onSurfaceVariant,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),
                if (isInProgress && task.progress != null) ...[
                  TaskProgressBar(progress: task.progress!),
                  const SizedBox(height: 24),
                ],
                Divider(color: ColorManger.surfaceContainer, height: 1),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          if (task.distance != null)
                            MetaInfoItem(
                              icon: Icons.social_distance,
                              label: '${task.distance} miles',
                            ),
                          if (task.duration != null)
                            MetaInfoItem(
                              icon: Icons.schedule,
                              label: '${task.duration} min',
                            ),
                        ],
                      ),
                      if (task.status == TaskStatus.available)
                        const AvailableActions()
                      else if (isInProgress)
                        const InProgressActions(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
