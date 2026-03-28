import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/tasks/taskScreen.dart';
import 'package:citifix/feature/workerFeature/tasks/testDummydata.dart';
import 'package:flutter/cupertino.dart';

import '../verfication/verficationinit.dart';

class TaskCardImage extends StatelessWidget {
  final TaskModel task;
  const TaskCardImage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          task.imageUrl!,
          height: 192,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        if (task.status == TaskStatus.inProgress)
          Container(
            height: 192,
            width: double.infinity,
            color: ColorManger.primary.withOpacity(0.2),
          ),
        if (task.isHighPriority)
          const Positioned(top: 16, left: 16, child: HighPriorityBadge()),
      ],
    );
  }
}
