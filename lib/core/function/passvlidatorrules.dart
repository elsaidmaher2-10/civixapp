import 'package:citifix/core/resource/constantmanger.dart';

List passwordvalidatorrules(String value) {
  if (value.trim().length >= 8) {
    Constantmanger.passwordRules[0]["status"] = true;
  } else {
    Constantmanger.passwordRules[0]["status"] = false;
  }

  if (value.contains(RegExp(r'[A-Z]'))) {
    Constantmanger.passwordRules[1]["status"] = true;
  } else {
    Constantmanger.passwordRules[1]["status"] = false;
  }

  if (value.contains(RegExp(r'[a-z]'))) {
    Constantmanger.passwordRules[2]["status"] = true;
  } else {
    Constantmanger.passwordRules[2]["status"] = false;
  }

  if (value.contains(RegExp(r'[0-9]'))) {
    Constantmanger.passwordRules[4]["status"] = true;
  } else {
    Constantmanger.passwordRules[4]["status"] = false;
  }

  if (value.contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]'))) {
    Constantmanger.passwordRules[3]["status"] = true;
  } else {
    Constantmanger.passwordRules[3]["status"] = false;
  }
  return Constantmanger.passwordRules;
}

bool passwordvalidatorrulesListener(String value) {
  if (value.trim().length >= 8) {
    Constantmanger.passwordRules[0]["status"] = true;
  } else {
    Constantmanger.passwordRules[0]["status"] = false;
  }

  if (value.contains(RegExp(r'[A-Z]'))) {
    Constantmanger.passwordRules[1]["status"] = true;
  } else {
    Constantmanger.passwordRules[1]["status"] = false;
  }

  if (value.contains(RegExp(r'[a-z]'))) {
    Constantmanger.passwordRules[2]["status"] = true;
  } else {
    Constantmanger.passwordRules[2]["status"] = false;
  }

  if (value.contains(RegExp(r'[0-9]'))) {
    Constantmanger.passwordRules[4]["status"] = true;
  } else {
    Constantmanger.passwordRules[4]["status"] = false;
  }

  if (value.contains(RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]'))) {
    Constantmanger.passwordRules[3]["status"] = true;
  } else {
    Constantmanger.passwordRules[3]["status"] = false;
  }
  return Constantmanger.passwordRules.every((e) => e["status"] == true);
}
