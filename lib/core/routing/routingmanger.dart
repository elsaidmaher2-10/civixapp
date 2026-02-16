import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/Login/presentation/views/LoginPage.dart';
import 'package:civixapp/feature/Auth/confirmpassword/presentation/view/Confirmpass.dart';
import 'package:civixapp/feature/Auth/foregetpassword/presentation/views/foregetpassword.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/view/otpvrificationcode.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/signupwidget.dart';
import 'package:civixapp/feature/onbroading/onbroading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Routingmanger {
  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.onbroading:
        return MaterialPageRoute(
          builder: (_) => PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              SystemNavigator.pop();
            },
            child: Onbroading(),
          ),
        );
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => Singnup());
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              SystemNavigator.pop();
            },
            child: Loginpage(),
          ),
        );

      case Routes.foregetpassword:
        return MaterialPageRoute(builder: (_) => Foregetpassword());
      case Routes.otpverficationc:
        return MaterialPageRoute(
          settings: route,
          builder: (_) => const Otpvrificationcode(),
        );

      case Routes.confirmPassword:
        return MaterialPageRoute(
          builder: (_) => CreatePasswordScreen(),
          settings: route,
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
