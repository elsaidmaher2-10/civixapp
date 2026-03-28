import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';

class HomeDashboardLogic {
  static double calculateProgress(DashBroadHome data) {
    return data.totalReports > 0
        ? data.resolvedReports / data.totalReports
        : 0.0;
  }

  static String formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  static int calculateTrend(DashBroadHome data) {
    if (data.totalReports == 0) return 0;
    return ((data.resolvedReports / data.totalReports) * 100).toInt();
  }
}
