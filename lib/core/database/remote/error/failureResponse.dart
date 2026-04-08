class FailureResponse {
  final int statusCode;
  final List<String> errors;

  FailureResponse({required this.errors, required this.statusCode});

  factory FailureResponse.fromJson(Map<String, dynamic> json) {
    return FailureResponse(
      errors: List<String>.from(json["errors"] ?? json["error"]),
      statusCode: json["statusCode"],
    );
  }
}
