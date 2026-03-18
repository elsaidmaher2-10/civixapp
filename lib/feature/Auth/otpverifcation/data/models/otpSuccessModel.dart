class Otpsuccessmodel {
  bool isAuthenticated;
  String message;
  String Email;
  String role;
  String fullName;
  String accessToken;
  String refreshTokenExpiration;
  String refreshToken;

  Otpsuccessmodel({
    required this.fullName,
    required this.Email,
    required this.accessToken,
    required this.isAuthenticated,
    required this.message,
    required this.refreshToken,
    required this.refreshTokenExpiration,
    required this.role,
  });

  factory Otpsuccessmodel.fromjson(Json) {
    return Otpsuccessmodel(
      Email: Json["email"],
      accessToken: Json["accessToken"],
      isAuthenticated: Json["isAuthenticated"],
      message: Json["message"],
      refreshToken: Json["refreshToken"],
      refreshTokenExpiration: Json["refreshTokenExpiration"],
      role: Json["role"],
      fullName: Json["fullName"],
    );
  }
}




