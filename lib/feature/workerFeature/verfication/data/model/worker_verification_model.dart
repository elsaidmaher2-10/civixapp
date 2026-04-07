import 'dart:convert';

class WorkerVerificationModel {
  final int id;
  final int workerId;
  final String workerName;
  final String workerEmail;
  final String workerNationalId;
  final String workerProfileImageUrl;
  final String? workerPhoneNumber;
  final int areaId;
  final String areaName;
  final int departmentId;
  final String departmentName;
  final String nationalIdFrontImageUrl;
  final String nationalIdBackImageUrl;
  final String? notes;
  final VerificationStatus status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  WorkerVerificationModel({
    required this.id,
    required this.workerId,
    required this.workerName,
    required this.workerEmail,
    required this.workerNationalId,
    required this.workerProfileImageUrl,
    this.workerPhoneNumber,
    required this.areaId,
    required this.areaName,
    required this.departmentId,
    required this.departmentName,
    required this.nationalIdFrontImageUrl,
    required this.nationalIdBackImageUrl,
    this.notes,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
  });

  factory WorkerVerificationModel.fromJson(Map<String, dynamic> json) {
    return WorkerVerificationModel(
      id: json['id'] ?? 0,
      workerId: json['workerId'] ?? 0,
      workerName: json['workerName'] ?? '',
      workerEmail: json['workerEmail'] ?? '',
      workerNationalId: json['workerNationalId'] ?? '',
      workerProfileImageUrl: json['workerProfileImageUrl'] ?? '',
      workerPhoneNumber: json['workerPhoneNumber'],
      areaId: json['areaId'] ?? 0,
      areaName: json['areaName'] ?? '',
      departmentId: json['departmentId'] ?? 0,
      departmentName: json['departmentName'] ?? '',
      nationalIdFrontImageUrl: json['nationalIdFrontImageUrl'] ?? '',
      nationalIdBackImageUrl: json['nationalIdBackImageUrl'] ?? '',
      notes: json['notes'],
      status: _parseStatus(json['status']),
      submittedAt: DateTime.parse(json['submittedAt']),
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'])
          : null,
      rejectionReason: json['rejectionReason'],
    );
  }

  static VerificationStatus _parseStatus(String? status) {
    switch (status) {
      case 'Approved':
        return VerificationStatus.approved;
      case 'Rejected':
        return VerificationStatus.rejected;
      case 'Pending':
      default:
        return VerificationStatus.pending;
    }
  }

  static List<WorkerVerificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => WorkerVerificationModel.fromJson(item))
        .toList();
  }
}

enum VerificationStatus { approved, pending, rejected }
