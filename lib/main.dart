import 'package:civixapp/core/database/local/prefmanger.dart';
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
        initialRoute: falg == true ? Routes.onbroading : Routes.login,
        title: 'Flutter Demo',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routingmanger.onGenerateRoute,
      ),
    );
  }
}
