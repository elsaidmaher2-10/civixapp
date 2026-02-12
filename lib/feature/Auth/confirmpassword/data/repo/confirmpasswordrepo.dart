import 'package:civixapp/core/service/networkchecker.dart';

class Confirmpasswordrepo {
  // final Apiservice service;
  final Networkchecker networkChecker;
  Confirmpasswordrepo({required this.networkChecker});
  dynamic createnewpassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) {}
}
