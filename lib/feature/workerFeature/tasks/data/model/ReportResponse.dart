class ReportResponse {
  final int totalCount;
  final List<ReportModelWorker> items;
  ReportResponse({required this.totalCount, required this.items});
  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      totalCount: json['totalCount'] ?? 0,
      items: (json['items'] as List)
          .map((i) => ReportModelWorker.fromJson(i))
          .toList(),
    );
  }
}

class ReportModelWorker {
  final int id;
  final String title;
  final String areaName;
  final String categoryName;
  final String departmentName;
  final String status;
  final DateTime createdAt;
  final List<String> imagesUrls;
  final double latitude;
  final double longitude;

  ReportModelWorker({
    required this.id,
    required this.title,
    required this.areaName,
    required this.categoryName,
    required this.departmentName,
    required this.status,
    required this.createdAt,
    required this.imagesUrls,
    required this.latitude,
    required this.longitude,
  });

  factory ReportModelWorker.fromJson(Map<String, dynamic> json) {
    return ReportModelWorker(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      areaName: json['areaName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      status: json['status'] ?? 'Assigned',
      createdAt: DateTime.parse(json['createdAt']),
      imagesUrls: List<String>.from(json['imagesUrls'] ?? []),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  // Helper to check status type
  bool get isResolved => status == "Resolved";
  bool get isInProgress => status == "InProgress";
  bool get isAssigned => status == "Assigned";
}

// Change the list type to ReportModel
List<ReportModelWorker> dummyReports = [
  ReportModelWorker(
    id: 83,
    title: 'Emergency Pipe Burst',
    areaName: '842 Riverside Dr, Apt 4B', // Mapped from address
    categoryName: 'Plumbing',
    departmentName: 'Maintenance',
    status: 'Assigned', // Mapped from available
    createdAt: DateTime.now(),
    imagesUrls: [
      'https://images.unsplash.com/photo-1581094288338-2314dddb7ece?auto=format&fit=crop&q=80&w=800',
    ],
    latitude: 31.4359,
    longitude: 31.6782,
  ),
  ReportModelWorker(
    id: 82,
    title: 'Electrical Rewiring',
    areaName: '156 Industrial Pkwy',
    categoryName: 'Electrical',
    departmentName: 'Infrastructure',
    status: 'InProgress',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    imagesUrls: [
      'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&q=80&w=800',
    ],
    latitude: 31.4359,
    longitude: 31.6782,
  ),
  ReportModelWorker(
    id: 80,
    title: 'HVAC Maintenance',
    areaName: '900 Corporate Blvd',
    categoryName: 'HVAC',
    departmentName: 'Administration',
    status: 'Resolved', // Mapped from completed
    createdAt: DateTime.parse('2023-10-24T10:00:00'),
    imagesUrls: [],
    latitude: 31.4500,
    longitude: 31.7000,
  ),
];
