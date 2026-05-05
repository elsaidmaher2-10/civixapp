import 'package:citifix/App/manager/cubit/localization_controller_cubit.dart';
import 'package:citifix/core/cubit/theme/theme_cubit.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/theme/app_theme.dart';
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
                builder: (context, locState) {
                  Locale currentLocale = const Locale('en');
                  if (locState is LocalizationControllerChanged) {
                    currentLocale = Locale(locState.lang);
                  }
                  return BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return MaterialApp(
                        key: navigatorKey,
                        localizationsDelegates: const [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        initialRoute: Routes.animatedSplash,
                        locale: currentLocale,
                        onGenerateRoute: Routingmanger.onGenerateRoute,
                        title: Constantmanger.apptitle,
                        debugShowCheckedModeBanner: false,
                        themeMode: themeMode,
                        theme: AppTheme.light(role),
                        darkTheme: AppTheme.dark(role),
                      );
                    },
                  );
                },
              ),
        );
      },
    );
  }
}
