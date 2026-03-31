class Achievementmodel {
  final int reportId;
  final String title;
  final String areaName;
  final String categoryName;
  final String departmentName;
  final int workerId;
  final String workerName;
  final DateTime resolvedAt;
  final DateTime completedAt;
  final String completionNote;
  final List<String> completionImageUrls;

  Achievementmodel({
    required this.reportId,
    required this.title,
    required this.areaName,
    required this.categoryName,
    required this.departmentName,
    required this.workerId,
    required this.workerName,
    required this.resolvedAt,
    required this.completedAt,
    required this.completionNote,
    required this.completionImageUrls,
  });

  factory Achievementmodel.fromJson(Map<String, dynamic> json) {
    return Achievementmodel(
      reportId: json['reportId'],
      title: json['title'],
      areaName: json['areaName'],
      categoryName: json['categoryName'],
      departmentName: json['departmentName'],
      workerId: json['workerId'],
      workerName: json['workerName'],
      resolvedAt: DateTime.parse(json['resolvedAt']),
      completedAt: DateTime.parse(json['completedAt']),
      completionNote: json['completionNote'],
      completionImageUrls: List<String>.from(json['completionImageUrls']),
    );
  }
}

class AchievementmodelReportsResponse {
  final int offset;
  final int limit;
  final int totalCount;
  final List<Achievementmodel> items;

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
          .map((e) => Achievementmodel.fromJson(e))
          .toList(),
    );
  }
}
