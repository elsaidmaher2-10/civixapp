// // {
// //     "statusCode": 200,
// //     "message": "Login successful",
// //     "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJhaG1lZDEyMjcyNzcyN0BnbWFpbC5jb20iLCJpYXQiOjE3NDk1NDQ1OTYsImV4cCI6MTc0OTYzMDk5NiwiaXNzIjoiYW5pbW9vb19hcGkifQ.v1iFaHX1U0nXn_0n9cB_WcJbAsLW898rrlLdr7ICoCU",
// //     "refresh_token": "7adfe0f0-a7b7-485a-a4e5-52a6928505b7",
// //     "user": {
// //         "id": 1,
// //         "first_name": "ahmed",
// //         "last_name": "elsaid",
// //         "email": "ahmed122727727@gmail.com",



// class Loginsuccesresponse {
//   int statusCode;
//   String message;
//   String access_token;
//   String refresh_token;

//   User? user;
//   Loginsuccesresponse({
//     required this.access_token,
//     required this.message,
//     required this.refresh_token,
//     required this.statusCode,
//     required this.user,
//   });
//   factory Loginsuccesresponse.fromjosn(json) {
//     print(json);
//     return Loginsuccesresponse(
//       access_token: json["access_token"],
//       message: json["message"],
//       refresh_token: json["refresh_token"],
//       statusCode: json["statusCode"],
//       user: json["user"] == null ? null : User.fromjson(json["user"]),
//     );
//   }
// }
