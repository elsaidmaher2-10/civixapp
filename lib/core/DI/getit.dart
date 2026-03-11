import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/home/data/Repos/UserProfileRepos/userprofileRepos.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setupgetit() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<InternetChecker>(InternetChecker());
  getIt.registerSingleton<Apiservice>(Apiservice(getIt<Dio>()));
  getIt.registerSingleton<Userprofilerepos>(
    Userprofilerepos(getIt<Apiservice>(), getIt<InternetChecker>()),
  );
}
