import 'dart:developer';

import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/routing/routingmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupgetit();
  await PrefrenceManager().init();
  bool falg =
      PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;

  String? access = PrefrenceManager().getstring(Constantmanger.refreshToken);

  bool isAuth = access == null ? false : true;

  runApp(MyApp(falg: falg, isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.falg, required this.isAuth});
  final bool falg;
  final bool isAuth;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: isAuth == true
            ? Routes.mainscreen
            : falg == true
            ? Routes.login
            : Routes.onbroading,
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
    );
  }
}



