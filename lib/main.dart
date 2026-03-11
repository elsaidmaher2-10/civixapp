import 'dart:developer';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/routing/routingmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  bool falg =
      PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;
  String? refresh =
      PrefrenceManager().getstring(Constantmanger.accessToken) ?? "";
  String? access =
      PrefrenceManager().getstring(Constantmanger.refreshToken) ?? "";
  String? expire =
      PrefrenceManager().getstring(Constantmanger.refreshTokenExpiration) ?? "";

  log("refresh$refresh");
  log("refresh$access");
  log("refresh$refresh");
  log("refresh$expire");
  runApp(MyApp(falg: falg));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.falg});
  final bool falg;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: falg == true ? Routes.login : Routes.onbroading,
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
