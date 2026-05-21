class NotificationModel {
  final int id;
  final String title;
  final String message;
  final bool isRead;
  final String createdAt;
  final String type;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      type: json['type'],
    );
  }
}
