class ReportResponse {
  final bool success;
  final String? message;
  final ReportData? data;

  ReportResponse({required this.success, this.message, this.data});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? ReportData.fromJson(json['data']) : null,
    );
  }
}

class ReportData {
  final int id;
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final int categoryId;
  final List<String> images;
  final DateTime? createdAt;

  ReportData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    this.images = const [],
    this.createdAt,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      categoryId: json['categoryId'],
      images: List<String>.from(json['images'] ?? []),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
