import 'dart:async';
import 'dart:convert';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:flutter/material.dart';

class Userprofilecontroller {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  bool isvalid = false;
  StreamController<bool> bntController = StreamController.broadcast();
  late UserProfile userProfile;
  @override
  void init() {
    String? userinfoStr = PrefrenceManager().getstring("user_profile_data");
    if (userinfoStr != null) {
      userProfile = UserProfile.fromJson(jsonDecode(userinfoStr));
    }
    emailController = TextEditingController(text: userProfile.email);
    phoneController = TextEditingController(text: userProfile.phoneNumber);
    nameController = TextEditingController(text: userProfile.fullName);
    addressController = TextEditingController(text: userProfile.address);

    addressController.addListener(checkEditReqeust);
    phoneController.addListener(checkEditReqeust);
    nameController.addListener(checkEditReqeust);
    emailController.addListener(checkEditReqeust);
  }

  checkEditReqeust() {
     isvalid =
        emailController.text != userProfile.email ||
        phoneController.text != userProfile.phoneNumber ||
        nameController.text != userProfile.fullName ||
        addressController.text != userProfile.address;

    bntController.add(isvalid);
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bntController.close();
  }
}
