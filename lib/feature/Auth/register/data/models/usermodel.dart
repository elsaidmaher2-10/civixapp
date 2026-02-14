import 'dart:io';

class Usermodel {
  String firstName;
  String lastName;
  String nationalId;
  String email;
  String phone;
  String address;
  String dateOfBirth;
  String password;
  String role;
  // File? image;

  Usermodel({
    required this.nationalId,
    required this.address,
    required this.dateOfBirth,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    // this.image,
  });
}


// {
//   "nationalId": "string",
//   "fullName": "string",
//   "email": "user@example.com",
//   "phoneNumber": "string",
//   "password": "r\\ArZpn&UgU*L,T>&!x4a^xMD/[A4JxV1n[S|ha'\\xAt+Y:[,VC<fC(Y[r**W6cupu*a gb`E%*2W'{LkN_FYn",
//   "address": "string",
//   "dateOfBirth": "2026-02-14",
//   "role": "string"
// }