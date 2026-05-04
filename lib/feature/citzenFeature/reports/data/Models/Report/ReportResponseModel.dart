import 'package:citifix/feature/citzenFeature/reports/data/Models/commentmodel/commentmodel.dart';

class ReportResponseModelByid {
  final int id;
  final String title;
  final String description;
  final int? areaId;
  final String areaName;
  final String categoryName;
  final String departmentName;
  final String status;
  final String location;
  final double latitude;
  final double longitude;
  final int categoryId;
  final int citizenId;
  final String citizenName;
  final String citizenProfileImageUrl;
  final String userId;
  final int? workerId;
  final String workerName;
  final List<TimelineModel> timeline;
  final String workerProfileImageUrl;
  final List<CommentModel> comments;
  final DateTime createdAt;
  final List<String> imagesUrls;
  final List<String> videosUrls;

  ReportResponseModelByid({
    required this.id,
    required this.title,
    required this.description,
    this.areaId,
    required this.areaName,
    required this.categoryName,
    required this.departmentName,
    required this.status,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    required this.citizenId,
    required this.citizenName,
    required this.citizenProfileImageUrl,
    required this.userId,
    this.workerId,
    required this.workerName,
    required this.workerProfileImageUrl,
    required this.comments,
    required this.createdAt,
    required this.imagesUrls,
    required this.videosUrls,
    required this.timeline,
  });

  factory ReportResponseModelByid.fromJson(Map<String, dynamic> json) {
    return ReportResponseModelByid(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      areaId: json['areaId'],
      areaName: json['areaName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      status: json['status'] ?? '',
      location: json['location'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] ?? 0,
      citizenId: json['citizenId'] ?? 0,
      citizenName: json['citizenName'] ?? '',
      citizenProfileImageUrl: json['citizenProfileImageUrl'] ?? '',
      userId: json['userId'] ?? '',
      workerId: json['workerId'],
      workerName: json['workerName'] ?? '',
      workerProfileImageUrl: json['workerProfileImageUrl'] ?? '',
      comments:
          (json['comments'] as List?)
              ?.map((e) => CommentModel.fromJson(e))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      imagesUrls:
          (json['imagesUrls'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      videosUrls:
          (json['videosUrls'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      timeline:
          (json['timeline'] as List?)
              ?.map((e) => TimelineModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TimelineModel {
  final String date;
  final String status;

  TimelineModel({required this.date, required this.status});

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    return TimelineModel(
      date: json["date"] ?? "",
      status: json["status"] ?? "",
    );
  }
}
