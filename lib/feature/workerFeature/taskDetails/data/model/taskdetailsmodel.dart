class TaskDetailsModel {
  final int id;
  final String areaName;
  final String title;
  final String description;
  final String categoryName;
  final bool isCompleted;
  final String departmentName;
  final String citizenName;
  final String citizenProfileImageUrl;
  final String status;
  final String createdAt;
  final List<String> imagesUrls;
  final List<String> videosUrls;
  final double latitude;
  final String location;
  final double longitude;

  TaskDetailsModel({
    required this.id,
    required this.areaName,
    required this.categoryName,
    required this.departmentName,
    required this.citizenName,
    required this.status,
    required this.createdAt,
    required this.imagesUrls,
    required this.videosUrls,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.isCompleted,
    required this.citizenProfileImageUrl,
  });

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailsModel(
      id: json["id"] ?? 0,

      title: json["title"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",

      areaName: json["areaName"]?.toString() ?? "",
      categoryName: json["categoryName"]?.toString() ?? "",
      departmentName: json["departmentName"]?.toString() ?? "",
      citizenName: json["citizenName"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",
      createdAt: json["createdAt"]?.toString() ?? "",

      imagesUrls:
          (json["imagesUrls"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],

      videosUrls:
          (json["videosUrls"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],

      latitude: (json["latitude"] is num)
          ? (json["latitude"] as num).toDouble()
          : 0.0,

      longitude: (json["longitude"] is num)
          ? (json["longitude"] as num).toDouble()
          : 0.0,
      location: json["location"],
      isCompleted: json["isCompleted"],
      citizenProfileImageUrl: json['citizenProfileImageUrl'],
    );
  }
}
