import 'package:flutter/material.dart';
import 'package:citifix/core/resource/colormanager.dart';

class TaskStatusBadge extends StatelessWidget {
  final String status;

  const TaskStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, label) = switch (status) {
      'Assigned' => (
        ColorManger.availableContainer,
        ColorManger.onAvailableContainer,
        'ASSIGNED',
      ),
      'InProgress' => (
        ColorManger.inProgressContainer,
        ColorManger.onInProgressContainer,
        'IN PROGRESS',
      ),
      'Resolved' => (
        const Color(0xFFE8F5E9), 
        const Color(0xFF2E7D32),
        'RESOLVED',
      ),
      _ => (Colors.grey.shade100, Colors.grey.shade600, status.toUpperCase()),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w900, // Extra bold for that "badge" look
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
