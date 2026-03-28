// ==========================================
// 1. THEME & COLORS
// ==========================================

import 'package:flutter/cupertino.dart';

class Appolors {}

enum TaskStatus {
  available("available"),
  inProgress("inProgress"),
  completed("RESOLVED");

  final String value;
  const TaskStatus(this.value);
  factory TaskStatus.fromString(String status) {
    return TaskStatus.values.firstWhere(
      (element) => element.value == status,
      orElse: () => TaskStatus.available,
    );
  }
}

class TaskModel {
  final String title;
  final TaskStatus status;
  final String address;
  final String description;
  final String? imageUrl;
  final bool isHighPriority;
  final double? distance;
  final int? duration;
  final double? progress;
  final String? completedDate;

  const TaskModel({
    required this.title,
    required this.status,
    required this.address,
    required this.description,
    this.imageUrl,
    this.isHighPriority = false,
    this.distance,
    this.duration,
    this.progress,
    this.completedDate,
  });
}

List<TaskModel> dummyTasks = [
  const TaskModel(
    title: 'Emergency Pipe Burst',
    status: TaskStatus.available,
    address: '842 Riverside Dr, Apt 4B',
    description:
        'Emergency repair needed for main kitchen valve. Resident reports significant flooding in sub-flooring.',
    imageUrl:
        'https://images.unsplash.com/photo-1581094288338-2314dddb7ece?auto=format&fit=crop&q=80&w=800',
    isHighPriority: true,
    distance: 1.2,
    duration: 20,
  ),
  const TaskModel(
    title: 'Electrical Rewiring',
    status: TaskStatus.inProgress,
    address: '156 Industrial Pkwy',
    description:
        'Install new distribution board and test grounding across the main production floor circuitry.',
    imageUrl:
        'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&q=80&w=800',
    progress: 0.65,
    distance: 3.5,
    duration: 45,
  ),
  const TaskModel(
    title: 'HVAC Maintenance',
    status: TaskStatus.completed,
    address: '900 Corporate Blvd',
    description:
        'Quarterly filter replacement and system diagnostic. Verified all compressors are operating within standard parameters.',
    completedDate: 'Oct 24, 2023',
  ),
];
