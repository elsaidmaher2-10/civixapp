class ReportResponseModel {
  final List<ReportItem> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  ReportResponseModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportResponseModel(
      items:
          (json['items'] as List?)
              ?.map((e) => ReportItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      totalCount: json['totalCount'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}

class ReportItem {
  final int id;
  final String title;
  final String description;
  final String location;
  final String areaName;
  final String status;
  final DateTime createdAt;
  final List<String> imagesUrls;

  ReportItem({
    required this.location,

    required this.id,
    required this.title,
    required this.description,
    required this.areaName,
    required this.status,
    required this.createdAt,
    required this.imagesUrls,
  });

  factory ReportItem.fromJson(Map<String, dynamic> json) {
    return ReportItem(
      location: json["location"],
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      areaName: json['areaName'] ?? '',
      status: json['status'] ?? 'Pending',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      imagesUrls: List<String>.from(json['imagesUrls'] ?? []),
    );
  }
}
