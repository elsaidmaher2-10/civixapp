import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  Future<bool> checkInternet() async {
    final results = await Connectivity().checkConnectivity();
    if (results.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
