class CreateReportRequest {
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final int categoryId;
  final List<String> images;

  CreateReportRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    this.images = const [],
  });

  Map<String, String> toJson() {
    return {
      'Title': title,
      'Description': description,
      'Location': location,
      'Latitude': latitude.toString(),
      'Longitude': longitude.toString(),
      'CategoryId': categoryId.toString(),
      'Images': images.join(','),
    };
  }
}
