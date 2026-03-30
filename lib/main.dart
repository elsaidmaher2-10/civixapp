import 'package:citifix/App/citifix.dart';
import 'package:citifix/App/manager/cubit/localization_controller_cubit.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/local_notification_service.dart';
import 'package:citifix/core/service/notification_service.dart';
import 'package:citifix/core/service/observer.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/data/repo/noticationRepo.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initApp();

  runApp(const MyAppWrapper());
}

Future<void> _initApp() async {
  SystemChrome.setSystemUIOverlayStyle(_statusBarStyle);
  setupgetit();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  await PrefrenceManager().init();
  await LocalNotificationService.init();
  await NotificationService.init();

  Bloc.observer = MyBlocObserver();
}

const SystemUiOverlayStyle _statusBarStyle = SystemUiOverlayStyle(
  statusBarColor: ColorManger.reportsPageBackground,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isOnboardingViewed =
        PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;

    final String? accessToken = PrefrenceManager().getstring(
      Constantmanger.accessToken,
    );
    final String? roleString = PrefrenceManager().getstring(
      Constantmanger.role,
    );
    print(accessToken);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserProfileInfoCubit(getIt())),
        BlocProvider(create: (_) => ReportCubit(getIt<ReportRepository>())),
        BlocProvider(create: (_) => MangeCustomBottomnavBarCubit()),
        BlocProvider(
          create: (_) => NotificationCubit(getIt<NotificationRepo>()),
        ),
        BlocProvider(
          create: (context) => LocalizationControllerCubit()..fetchLanguage(),
        ),
      ],
      child: Citifix(
        isOnboardingViewed: isOnboardingViewed,
        isAuth: accessToken != null,
        role: AppRole.fromString(roleString),
      ),
    );
  }
}
