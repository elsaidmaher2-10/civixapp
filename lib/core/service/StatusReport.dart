import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

enum StatusReport {
  pending("Pending", Colors.orange),
  inpprogress("Assigned", ColorManger.kPrimary),
  resolved("Resolved", Colors.green);

  final String value;
  final Color color;
  const StatusReport(this.value, this.color);
  static StatusReport fromString(String status) {
    return StatusReport.values.firstWhere(
      (e) => e.value.toLowerCase() == status.toLowerCase(),
      orElse: () => StatusReport.pending,
    );
  }
}

enum TaskStatus {
  assigned,
  inProgress,
  resolved;

  static TaskStatus fromString(String? status) {
    switch (status) {
      case 'InProgress':
        return TaskStatus.inProgress;
      case 'Resolved':
        return TaskStatus.resolved;
      case 'Assigned':
        return TaskStatus.assigned;
      default:
        return TaskStatus.assigned;
    }
  }
}
