import 'dart:io';

class Usermodel {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  File image;

  Usermodel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.password,
    required this.phone,
  });
}

  // "firstName": fnameController.text,
  //                                         "lastName": lnameController.text,
  //                                         "email": emailController.text,
  //                                         "phone": phoneController.text,
  //                                         "password": passwordController.text,
  //                                         "image": await MultipartFile.fromFile(
  //                                           image!.path,
  //                                           filename: image!.path
  //                                               .split("/")
  //                                               .last,
  //                                         ),
  //                                       }),