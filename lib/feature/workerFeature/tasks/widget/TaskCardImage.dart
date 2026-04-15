import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart'; // تم الإضافة
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:flutter/material.dart';

class TaskCardImage extends StatelessWidget {
  final ReportModelWorker task;
  const TaskCardImage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    if (task.imagesUrls.isEmpty) {
      return Container(
        height: ScreenUtilsManager.h192,
        width: double.infinity,
        color: ColorManger.grey200,
        child: Icon(Icons.image_not_supported, color: ColorManger.grey400),
      );
    }

    return Stack(
      children: [
        Image.network(
          task.imagesUrls.first,
          height: ScreenUtilsManager.h192,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: ScreenUtilsManager.h192,
              width: double.infinity,
              color: ColorManger.lightGrey,
              child: const Center(child: CircularProgressIndicator.adaptive()),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: ScreenUtilsManager.h192,
            width: double.infinity,
            color: ColorManger.grey200,
            child: Icon(Icons.broken_image, color: ColorManger.grey400),
          ),
        ),

        if (StatusReport.fromString(task.status) == StatusReport.inProgress)
          Container(
            height: ScreenUtilsManager.h192,
            width: double.infinity,
            color: ColorManger.primaryOpacity20,
          ),
      ],
    );
  }
}
