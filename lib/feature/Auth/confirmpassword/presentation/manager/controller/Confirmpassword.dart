import 'dart:async';
import 'package:flutter/material.dart';
import 'package:citifix/core/function/passvlidatorrules.dart';
import 'package:citifix/core/resource/constantmanger.dart';

class ConfirmpasswordController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final StreamController<List> forgotPasswordStreamController =
      StreamController.broadcast();
  final StreamController<List> changePasswordStreamController =
      StreamController.broadcast();
  final StreamController<bool> btnController =
      StreamController<bool>.broadcast();
  bool isValid = false;
  late bool isProfileScreen;

  void initState({required bool isProfileScreen}) {
    this.isProfileScreen = isProfileScreen;

    forgotPasswordStreamController.add(Constantmanger.passwordRules);
    changePasswordStreamController.add(Constantmanger.passwordRules);

    passwordController.addListener(matchPasswords);
    confirmPasswordController.addListener(matchPasswords);

    oldPasswordController.addListener(matchPasswords);
    newPasswordController.addListener(matchPasswords);
    confirmNewPasswordController.addListener(matchPasswords);
  }

  void matchPasswords() {
    if (isProfileScreen) {
      isValid =
          oldPasswordController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty &&
          passwordvalidatorrulesListener(newPasswordController.text);
      btnController.add(isValid);
    } else {
      isValid =
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text &&
          passwordvalidatorrulesListener(passwordController.text);

      btnController.add(isValid);
    }
  }

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();

    forgotPasswordStreamController.close();
    changePasswordStreamController.close();
    btnController.close();
  }
}
