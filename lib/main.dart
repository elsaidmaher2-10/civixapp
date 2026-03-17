import 'dart:developer';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/routing/routingmanger.dart';
import 'package:citifix/core/service/observer.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupgetit();
  Bloc.observer = MyBlocObserver();
  await PrefrenceManager().init();
  final bool isOnboardingViewed =
      PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;

  final String? accessToken = PrefrenceManager().getstring(
    Constantmanger.accessToken,
  );
  final String? roleString = PrefrenceManager().getstring(Constantmanger.role);

  log('Access Token: $accessToken');
  log('Role: $roleString');

  runApp(
    MyApp(
      isOnboardingViewed: isOnboardingViewed,
      isAuth: accessToken != null,
      role: AppRole.fromString("worker"),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          navigatorKey: navigatorKey,
          initialRoute: _initialRoute,
          title: 'citifix',
          themeMode: ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: ColorManger.kprimary,
              selectionColor: ColorManger.kprimary.withOpacity(0.2),
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
