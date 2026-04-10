import 'package:citifix/App/manager/cubit/localization_controller_cubit.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/routing/routingmanger.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:citifix/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Citifix extends StatelessWidget {
  const Citifix({
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
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(lazy: false, create: (_) => getIt<ReportCubit>()),
            BlocProvider(
              create: (context) =>
                  LocalizationControllerCubit()..fetchLanguage(),
            ),
          ],
          child:
              BlocBuilder<
                LocalizationControllerCubit,
                LocalizationControllerState
              >(
                builder: (context, state) {
                  String currentLang = "en";

                  if (state is LocalizationControllerChanged) {
                    currentLang = state.lang;
                  }
                  return MaterialApp(
                    key: navigatorKey,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    initialRoute: _initialRoute,
                    locale: Locale(currentLang),
                    onGenerateRoute: Routingmanger.onGenerateRoute,
                    title: Constantmanger.apptitle,
                    debugShowCheckedModeBanner: false,
                    themeMode: ThemeMode.light,
                    theme: _lightTheme,
                  );
                },
              ),
        );
      },
    );
  }
}

final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: ColorManger.kPrimary,
    selectionColor: ColorManger.kPrimary.withOpacity(0.2),
    cursorColor: Colors.black,
  ),
);
