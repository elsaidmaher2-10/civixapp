// Phone validation regex (adjust pattern based on your requirements)
bool isValidPhone(String phone) {
  return RegExp(
    r'^\+?[0-9]{10,15}$',
  ).hasMatch(phone.replaceAll(RegExp(r'[\s-]'), ''));
}
