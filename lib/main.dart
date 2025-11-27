import 'package:civixapp/core/datesource/local/prefmanger.dart';
import 'package:civixapp/feature/Login/Login.dart';
import 'package:civixapp/feature/onbroading/onbroading.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  bool falg = PrefrenceManager().getbool("is_show_on_board") ?? false;
  runApp(MyApp(falg: falg));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.falg});
  final bool falg;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: falg ? Login() : Onbroading(),
    );
  }
}
