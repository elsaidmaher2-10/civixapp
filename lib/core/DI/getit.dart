import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/notication/data/repo/noticationRepo.dart';
import 'package:citifix/feature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setupgetit() {
  getIt.registerSingleton<InternetChecker>(InternetChecker());
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Apiservice>(Apiservice(getIt<Dio>()));

  getIt.registerSingleton<Userprofilerepos>(
    Userprofilerepos(getIt<Apiservice>(), getIt<InternetChecker>()),
  );
  getIt.registerLazySingleton<ReportCubit>(
    () => ReportCubit(getIt<ReportRepository>()),
  );
  getIt.registerSingleton<ReportRepository>(
    ReportRepository(
      service: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );
  getIt.registerSingleton<LogOutRepository>(
    LogOutRepository(getIt<Apiservice>()),
  );
  getIt.registerSingleton<NotificationRepo>(
    NotificationRepo(getIt<Apiservice>()),
  );
}
