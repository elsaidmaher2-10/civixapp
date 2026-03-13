class ReportResponseModel {
  final int id;
  final String title;
  final String description;
  final String categoryName;
  final String status;
  final String location;
  final String citizenName;
  final DateTime createdAt;
  final List<String> imagesUrls;

  ReportResponseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.status,
    required this.location,
    required this.citizenName,
    required this.createdAt,
    required this.imagesUrls,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    return ReportResponseModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      status: json['status'] ?? '',
      location: json['location'] ?? '',
      citizenName: json['citizenName'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      imagesUrls: List<String>.from(json['imagesUrls'] ?? []),
    );
  }
}