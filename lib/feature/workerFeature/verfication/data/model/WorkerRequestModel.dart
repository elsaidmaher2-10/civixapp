class WorkerRequestModel {
  final int requestId;
  final String workerName;
  final String workerEmail;
  final String workerPhoneNumber;
  final String workerNationalId;
  final String workerProfileImageUrl;
  final int areaId;
  final String areaName;
  final int departmentId;
  final String departmentName;
  final String nationalIdFrontImageUrl;
  final String nationalIdBackImageUrl;
  final String notes;
  final String status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? rejectionReason;

  WorkerRequestModel({
    required this.requestId,
    required this.workerName,
    required this.workerEmail,
    required this.workerPhoneNumber,
    required this.workerNationalId,
    required this.workerProfileImageUrl,
    required this.areaId,
    required this.areaName,
    required this.departmentId,
    required this.departmentName,
    required this.nationalIdFrontImageUrl,
    required this.nationalIdBackImageUrl,
    required this.notes,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.rejectionReason,
  });

  factory WorkerRequestModel.fromJson(Map<String, dynamic> json) {
    return WorkerRequestModel(
      requestId: json['requestId'] ?? 0,
      workerName: json['workerName'] ?? '',
      workerEmail: json['workerEmail'] ?? '',
      workerPhoneNumber: json['workerPhoneNumber'] ?? '',
      workerNationalId: json['workerNationalId'] ?? '',
      workerProfileImageUrl: json['workerProfileImageUrl'] ?? '',
      areaId: json['areaId'] ?? 0,
      areaName: json['areaName'] ?? '',
      departmentId: json['departmentId'] ?? 0,
      departmentName: json['departmentName'] ?? '',
      nationalIdFrontImageUrl: json['nationalIdFrontImageUrl'] ?? '',
      nationalIdBackImageUrl: json['nationalIdBackImageUrl'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      submittedAt: DateTime.parse(json['submittedAt']),
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'])
          : null,
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'workerName': workerName,
      'workerEmail': workerEmail,
      'workerPhoneNumber': workerPhoneNumber,
      'workerNationalId': workerNationalId,
      'workerProfileImageUrl': workerProfileImageUrl,
      'areaId': areaId,
      'areaName': areaName,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'nationalIdFrontImageUrl': nationalIdFrontImageUrl,
      'nationalIdBackImageUrl': nationalIdBackImageUrl,
      'notes': notes,
      'status': status,
      'submittedAt': submittedAt.toIso8601String(),
      'reviewedAt': reviewedAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }
}
