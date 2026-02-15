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




// {
//   "": true,
//   "": "Email confirmed successfully",
//   "": "elsaidmaher",
//   "": "elsaidmaher@students.du.edu.eg",
//   "": "WORKER",
//   "": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZWxzYWlkbWFoZXJAc3R1ZGVudHMuZHUuZWR1LmVnIiwianRpIjoiY2U3Y2YwMjctMDViMC00NTI5LWE3MzktMjAzYzgxYTg0N2Q4IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJiY2YwNzk0OC1jOTFmLTQ1ZjAtYTQ5Zi1iYmM1YmM3M2U5MDkiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJlbHNhaWRtYWhlckBzdHVkZW50cy5kdS5lZHUuZWciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJXb3JrZXIiLCJleHAiOjE3NzExODE1NjYsImlzcyI6IllvdXJBcHAiLCJhdWQiOiJZb3VyQXBwVXNlcnMifQ.RUmnaGRzmEik_odsqE9U43WPRdE_LSkme8UhSexddUY",
//   "": "Nyxn/EBUg0Q0U+ccKfGRG2fhOtiKxrzXTVYlQr4YBmc=",
//   "": "2026-02-22T17:52:46.9981541Z"
// }