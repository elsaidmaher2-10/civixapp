import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/ReportResponseModel.dart';

class AchievementModel {
  final int reportId;
  final String title;
  final String description;
  final String areaName;
  final int areaId;
  final String categoryName;
  final int categoryId;
  final String departmentName;
  final int departmentId;
  final int citizenId;
  final String citizenName;
  final String citizenUserId;
  final String? citizenProfileImageUrl;
  final int workerId;
  final String workerName;
  final String workerUserId;
  final String? workerProfileImageUrl;
  final String status;
  final String location;
  final double latitude;
  final double longitude;
  final List<String> reportImageUrls;
  final List<String> completionImageUrls;
  final String? completionNote;
  final DateTime createdAt;
  final List<TimelineModel> timeline;

  AchievementModel({
    required this.reportId,
    required this.title,
    required this.description,
    required this.areaName,
    required this.areaId,
    required this.categoryName,
    required this.categoryId,
    required this.departmentName,
    required this.departmentId,
    required this.citizenId,
    required this.citizenName,
    required this.citizenUserId,
    this.citizenProfileImageUrl,
    required this.workerId,
    required this.workerName,
    required this.workerUserId,
    this.workerProfileImageUrl,
    required this.status,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.reportImageUrls,
    required this.completionImageUrls,
    this.completionNote,
    required this.createdAt,
    required this.timeline,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      reportId: json['reportId'],
      title: json['title'],
      description: json['description'],

      areaName: json['areaName'],
      areaId: json['areaId'],

      categoryName: json['categoryName'],
      categoryId: json['categoryId'],

      departmentName: json['departmentName'] ?? '',
      departmentId: json['departmentId'],

      citizenId: json['citizenId'],
      citizenName: json['citizenName'],
      citizenUserId: json['citizenUserId'],
      citizenProfileImageUrl: json['citizenProfileImageUrl'],

      workerId: json['workerId'],
      workerName: json['workerName'],
      workerUserId: json['workerUserId'],
      workerProfileImageUrl: json['workerProfileImageUrl'],

      status: json['status'],

      location: json['location'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),

      reportImageUrls: List<String>.from(json['reportImageUrls'] ?? []),
      completionImageUrls: List<String>.from(json['completionImageUrls'] ?? []),

      completionNote: json['completionNote'],

      createdAt: DateTime.parse(json['createdAt']),

      timeline: (json['timeline'] as List)
          .map((e) => TimelineModel.fromJson(e))
          .toList(),
    );
  }
}

class AchievementmodelReportsResponse {
  final int offset;
  final int limit;
  final int totalCount;
  final List<AchievementModel> items;
  AchievementmodelReportsResponse({
    required this.offset,
    required this.limit,
    required this.totalCount,
    required this.items,
  });

  factory AchievementmodelReportsResponse.fromJson(Map<String, dynamic> json) {
    return AchievementmodelReportsResponse(
      offset: json['offset'],
      limit: json['limit'],
      totalCount: json['totalCount'],
      items: (json['items'] as List)
          .map((e) => AchievementModel.fromJson(e))
          .toList(),
    );
  }
}
