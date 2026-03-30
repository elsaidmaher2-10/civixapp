import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:flutter/cupertino.dart';

class TaskCardImage extends StatelessWidget {
  final ReportModelWorker task;
  const TaskCardImage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          task.imagesUrls.first,
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
      ],
    );
  }
}
