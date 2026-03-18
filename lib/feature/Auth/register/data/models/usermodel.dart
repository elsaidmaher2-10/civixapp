
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
  });
}


