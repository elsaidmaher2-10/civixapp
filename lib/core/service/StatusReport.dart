import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

enum StatusReport {
  pending("Pending", Colors.orange),
  active("6", ColorManger.kPrimary),
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
