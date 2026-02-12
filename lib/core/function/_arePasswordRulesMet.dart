import 'package:civixapp/core/resource/constantmanger.dart';

bool arePasswordRulesMet() {
  return Constantmanger.passwordRules.every((rule) => rule["status"] == true);
}
