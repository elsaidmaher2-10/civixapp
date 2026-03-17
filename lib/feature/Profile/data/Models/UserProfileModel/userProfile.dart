class UserProfile {
  int? id;
  String? username;
  String? userId;
  String? email;
  String? role;
  String? fullName;
  String? nationalId;
  String? dateOfBirth;
  int? age;
  String? phoneNumber;
  String? address;
  bool? verified;
  String? profileImage;

  UserProfile({
    this.id,
    this.username,
    this.email,
    this.role,
    this.fullName,
    this.nationalId,
    this.dateOfBirth,
    this.age,
    this.phoneNumber,
    this.address,
    this.verified,
    this.userId,
    this.profileImage,
  });
  Map<String, dynamic> toJson() {
    return {
      'citizenId': id,
      'userId': userId,
      'username': username,
      'email': email,
      'role': role,
      'fullName': fullName,
      'nationalId': nationalId,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'phoneNumber': phoneNumber,
      'address': address,
      'verified': verified,
      'profileImage': profileImage,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['citizenId'],
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      fullName: json['fullName'],
      nationalId: json['nationalId'],
      dateOfBirth: json['dateOfBirth'],
      age: json['age'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      verified: json['verified'],
      profileImage: json['profileImage'],
    );
  }
}
