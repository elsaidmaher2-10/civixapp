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


  
  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Description': description,
      'Images': images.join(','),
      'Location': location,
      'Latitude': latitude,
      'Longitude': longitude,
      'CategoryId': categoryId.toString(),
    };
  }
}
