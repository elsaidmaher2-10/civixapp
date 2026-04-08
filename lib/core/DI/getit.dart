import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/citzenFeature/notication/data/repo/noticationRepo.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/commentRepo/commentRepo.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/workerFeature/home/data/repo/homrepo.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/repos/reportdetails.dart';
import 'package:citifix/feature/workerFeature/tasks/data/repos/worker_task_Repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../feature/citzenFeature/home/data/Repos/reports/reports.dart';
import '../../feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';

final GetIt getIt = GetIt.instance;
void setupgetit() {
  getIt.registerSingleton<InternetChecker>(InternetChecker());
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Apiservice>(Apiservice(getIt<Dio>()));

  getIt.registerSingleton<Userprofilerepos>(
    Userprofilerepos(getIt<Apiservice>(), getIt<InternetChecker>()),
  );
  getIt.registerLazySingleton<ReportCubit>(
    () => ReportCubit(getIt<ReportRepositoryT>()),
  );
  getIt.registerSingleton<ReportRepository>(
    ReportRepository(
      service: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );
  getIt.registerSingleton<ReportRepositoryT>(
    ReportRepositoryT(
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
  getIt.registerSingleton<Homreposatory>(
    Homreposatory(
      service: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );
  getIt.registerSingleton<VerficationInitRepo>(
    VerficationInitRepo(
      apiservice: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );
  getIt.registerSingleton<ReportdetailsRepo>(
    ReportdetailsRepo(getIt<InternetChecker>(), getIt<Apiservice>()),
  );
  getIt.registerSingleton<WorkerTaskRepo>(
    WorkerTaskRepo(
      service: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );

  getIt.registerSingleton<Commentrepo>(
    Commentrepo(
      service: getIt<Apiservice>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );
}
