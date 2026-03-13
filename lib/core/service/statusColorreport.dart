import 'package:flutter/material.dart';

enum StatusReport {
  pending("Pending", Colors.orange),
  inProgress("In Progress", Colors.amber),
  resolved("Resolved", Colors.green),
  rejected("Rejected", Colors.red);

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
