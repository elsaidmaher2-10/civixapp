import 'package:citifix/feature/workerFeature/tasks/testDummydata.dart';
import 'package:flutter/cupertino.dart';

import '../verfication/verficationinit.dart';

class TaskStatusBadge extends StatelessWidget {
  final TaskStatus status;
  const TaskStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, label) = switch (status) {
      TaskStatus.available => (
        AppColors.availableContainer,
        AppColors.onAvailableContainer,
        'AVAILABLE',
      ),
      TaskStatus.inProgress => (
        AppColors.inProgressContainer,
        AppColors.onInProgressContainer,
        'IN PROGRESS',
      ),
      TaskStatus.completed => (
        const Color(0xFFE8F5E9),
        const Color(0xFF2E7D32),
        'RESOLVED',
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
