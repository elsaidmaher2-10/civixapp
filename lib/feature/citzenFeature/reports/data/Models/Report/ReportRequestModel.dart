

class CreateReportRequest {
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final int categoryId;
  final List<String> images;
  final List<String> videos;
  final bool isAnonymous;

  CreateReportRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    this.images = const [],
    this.videos = const [],
    required this.isAnonymous,
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
      'Videos': videos.join(','), 
      'IsAnonymous': isAnonymous,
    };
  }

  CreateReportRequest copyWith({
    String? title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    int? categoryId,
    List<String>? images,
    List<String>? videos,
    bool? isAnonymous,
  }) {
    return CreateReportRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      categoryId: categoryId ?? this.categoryId,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'categoryId': categoryId,
      'images': images,
      'videos': videos,
      'isAnonymous': isAnonymous,
    };
  }

  factory CreateReportRequest.fromMap(Map<String, dynamic> map) {
    return CreateReportRequest(
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      categoryId: map['categoryId'] as int,
      images: List<String>.from(map['images'] ?? []),
      videos: List<String>.from(map['videos'] ?? []),
      isAnonymous: map['isAnonymous'] as bool? ?? false,
    );
  }
}
