

class Loginsuccesresponse {
  bool isAuthenticated;
  String message;
  String Email;
  String role;
  String fullName;
  String accessToken;
  String refreshTokenExpiration;
  String refreshToken;
  Loginsuccesresponse({
    required this.fullName,
    required this.message,
    required this.refreshTokenExpiration,
    required this.role,
    required this.Email,
    required this.accessToken,
    required this.isAuthenticated,
    required this.refreshToken,
  });
  factory Loginsuccesresponse.fromjosn(json) {
    return Loginsuccesresponse(
      Email: json["email"],
      accessToken: json["accessToken"],
      isAuthenticated: json["isAuthenticated"],
      message: json["message"],
      refreshToken: json["refreshToken"],
      refreshTokenExpiration: json["refreshTokenExpiration"],
      role: json["role"],
      fullName: json["fullName"],
    );
  }
}
