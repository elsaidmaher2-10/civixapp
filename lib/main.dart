import 'dart:developer';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/routing/routingmanger.dart';
import 'package:citifix/core/service/local_notification_service.dart';
import 'package:citifix/core/service/notification_service.dart';
import 'package:citifix/core/service/observer.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManger.reportsPageBackground,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  setupgetit();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  await LocalNotificationService.init();
  await NotificationService.init();
  await PrefrenceManager().init();

  final bool isOnboardingViewed =
      PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;
  Bloc.observer = MyBlocObserver();
  final String? accessToken = PrefrenceManager().getstring(
    Constantmanger.accessToken,
  );
  final String? roleString = PrefrenceManager().getstring(Constantmanger.role);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserProfileInfoCubit(getIt())),
        BlocProvider(create: (_) => ReportCubit(getIt<ReportRepository>())),
        BlocProvider(create: (_) => MangeCustomBottomnavBarCubit()),
      ],
      child: MyApp(
        isOnboardingViewed: isOnboardingViewed,
        isAuth: accessToken != null,
        role: AppRole.fromString(roleString),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isOnboardingViewed,
    required this.isAuth,
    required this.role,
  });

  final bool isOnboardingViewed;
  final bool isAuth;
  final AppRole role;

  String get _initialRoute {
    if (!isOnboardingViewed) return Routes.onbroading;
    if (!isAuth) return Routes.login;
    switch (role) {
      case AppRole.citizen:
        return Routes.citizenMain;
      case AppRole.worker:
        return Routes.workerMain;
      case AppRole.unknown:
        return Routes.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider<ReportCubit>(
        lazy: false,
        create: (context) => getIt<ReportCubit>(),
        child: MaterialApp(
          key: navigatorKey,
          initialRoute: _initialRoute,
          title: 'citifix',
          themeMode: ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: ColorManger.kPrimary,
              selectionColor: ColorManger.kPrimary.withOpacity(0.2),
              cursorColor: Colors.black,
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routingmanger.onGenerateRoute,
        ),
      ),
    );
  }
}
