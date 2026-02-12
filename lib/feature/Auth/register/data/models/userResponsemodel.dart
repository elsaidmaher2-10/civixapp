class Userresponsemodel {
  int statusCode;
  String message;
  String alert;
  User user;

  Userresponsemodel({
    required this.alert,
    required this.message,
    required this.statusCode,
    required this.user,
  });

  factory Userresponsemodel.fromjson(json) {
    return Userresponsemodel(
      alert: json["alert"],
      message: json["message"],
      statusCode: json["statusCode"],
      user: User.fromjson(json["user"]),
    );
  }
}

class User {
  int id;
  String first_name;
  String last_name;
  String image_path;
  String email;
  String is_verified;
  String phone;

  User({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.image_path,
    required this.is_verified,
    required this.phone,
    required this.id,
  });

  factory User.fromjson(json) {
    return User(
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      image_path: json["image_path"],
      is_verified: json["is_verified"],
      phone: json["phone"],
      id: json["id"],
    );
  }
}

// "statusCode": 201,
//     "message": "Signup successful!",
//     "alert": "We send verfication code to your email",
//     "user": {
//         "id": 1,
//         "first_name": "ahmed",
//         "last_name": "elsaid",
//         "email": "ahmed122727727@gmail.com",
//         "phone": "201001398831",
//         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
//         "is_verified": "false"
//     }
// }
