import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:flutter/material.dart';

class CompletedTaskCard extends StatelessWidget {
  final ReportModelWorker task;
  const CompletedTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50.withOpacity(0.8),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
          SizedBox(width: ScreenUtilsManager.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Completed on ${task.createdAt}',
                  style: TextStyle(
                    fontSize: ScreenUtilsManager.s12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
