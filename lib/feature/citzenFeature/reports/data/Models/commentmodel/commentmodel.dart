
List<CommentModel> dummyComments = [];

class CommentModel {
  final int id;
  final int reportid;
  final String userName;
  final String userProfileImageUrl;
  final String commentText;
  final DateTime createdAt;
  final UserType userRole;

  CommentModel({
    required this.id,
    required this.reportid,
    required this.userName,
    required this.userProfileImageUrl,
    required this.commentText,
    required this.createdAt,
    required this.userRole,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      reportid: json["reportId"] ?? 0,
      userName: json['userName'] ?? 'Unknown User',
      userProfileImageUrl: json["userProfileImageUrl"] ?? "",
      commentText: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      userRole: json['userRole'] == 'Worker'
          ? UserType.worker
          : UserType.citizen,
    );
  }
}

enum UserType { citizen, worker }
