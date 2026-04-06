import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

enum StatusReport {
  assigned("Assigned", Color(0xFF3F51B5)),
  pending("Pending", Color(0xFFFFB300)),
  inProgress("InProgress", ColorManger.kPrimary),
  resolved("Resolved", Colors.green),
  completed("Completed", Colors.green),
  rejected("Rejected", Colors.red);

  final String value;
  final Color color;
  const StatusReport(this.value, this.color);
  static StatusReport fromString(String? status) {
    if (status == null) return StatusReport.pending;
    return StatusReport.values.firstWhere(
      (e) => e.value.toLowerCase() == status.toLowerCase(),
      orElse: () => StatusReport.pending,
    );
  }
}

enum VerificationStatus {
  assigned("init"),
  pending("Pending"),
  completed("Completed"),
  rejected("Rejected");
  final String value;
  const VerificationStatus(this.value);
  static VerificationStatus fromString(String? status) {
    if (status == null) return VerificationStatus.pending;
    return VerificationStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == status.toLowerCase(),
      orElse: () => VerificationStatus.pending,
    );
  }
}
