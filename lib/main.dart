import 'package:civixapp/core/database/local/prefmanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/core/routing/routingmanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  bool falg =
      PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;
  runApp(MyApp(falg: falg));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.falg});
  final bool falg;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: falg == true ? Routes.login: Routes.onbroading ,
        title: 'Civix',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          brightness: Brightness.light,
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: ColorManger.kprimary,
              selectionColor: ColorManger.kprimary.withOpacity(0.2),
            cursorColor: Colors.black
          )
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routingmanger.onGenerateRoute,
      ),
    );
  }
}
