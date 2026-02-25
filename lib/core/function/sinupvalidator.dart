import 'package:citifix/core/function/_isValidEmail.dart';
import 'package:citifix/core/function/_isValidPhone.dart';

String? phonevalidator(value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter phone number";
  }
  if (!isValidPhone(value.trim())) {
    return "Please enter a valid phone number";
  }
  return null;
}

String? emailvalidator(value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter email";
  }
  if (!isValidEmail(value.trim())) {
    return "Please enter a valid email address";
  }
  return null;
}

String? lnamevalidator(value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter last name";
  }
  return null;
}

String? fnamevalidator(value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter first name";
  }
  return null;
}

String? confvalidator(value, dynamic passwordController) {
  if (value == null || value.isEmpty) {
    return "Please confirm your password";
  }
  if (value != passwordController.text) {
    return "Passwords do not match";
  }
  return null;
}
