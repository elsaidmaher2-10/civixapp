import 'package:latlong2/latlong.dart';

class DashBroadHome {
  final int totalReports;
  final int assignedReports;
  final int inProgressReports;
  final int resolvedReports;
  final String workerName;
  final bool verified;
  final String profileImageUrl;
  final String areaName;
  final String departmentName;
  final List<RecentReportModel> recentReports;
  final List<LatLng> areaCoordinates;
  DashBroadHome({
    required this.areaName,
    required this.departmentName,
    required this.profileImageUrl,
    required this.workerName,
    required this.totalReports,
    required this.assignedReports,
    required this.inProgressReports,
    required this.resolvedReports,
    required this.recentReports,
    required this.verified,
    required this.areaCoordinates,
  });

  factory DashBroadHome.fromJson(Map<String, dynamic> json) {
    return DashBroadHome(
      totalReports: json['totalReports'] ?? 0,
      assignedReports: json['assignedReports'] ?? 0,
      inProgressReports: json['inProgressReports'] ?? 0,
      resolvedReports: json['resolvedReports'] ?? 0,
      recentReports:
          (json['recentReports'] as List?)
              ?.map((report) => RecentReportModel.fromJson(report))
              .toList() ??
          [],
      areaName: json["areaName"],
      departmentName: json["departmentName"],
      profileImageUrl: json["profileImageUrl"],
      workerName: json["workerName"],
      verified: json["verified"],
      areaCoordinates:
          (json['areaCoordinates'] as List?)
              ?.map(
                (point) => LatLng(
                  (point['latitude'] as num).toDouble(),
                  (point['longitude'] as num).toDouble(),
                ),
              )
              .toList() ??
          [],
    );
  }
}

class RecentReportModel {
  final int id;
  final String title;
  final String areaName;
  final String categoryName;
  final String departmentName;
  final String status;
  final DateTime createdAt;
  final List<String> imageUrls;

  RecentReportModel({
    required this.id,
    required this.title,
    required this.areaName,
    required this.categoryName,
    required this.departmentName,
    required this.status,
    required this.createdAt,
    required this.imageUrls,
  });

  factory RecentReportModel.fromJson(Map<String, dynamic> json) {
    return RecentReportModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      areaName: json['areaName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      imageUrls: List<String>.from(json['imagesUrls'] ?? []),
    );
  }
}
