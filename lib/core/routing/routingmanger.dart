import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/signupwidget.dart';
import 'package:civixapp/feature/onbroading/onbroading.dart';
import 'package:flutter/material.dart';

class Routingmanger {
  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      // case Routes.home:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeView(),
      //   );

      // case Routes.login:
      //   return MaterialPageRoute(
      //     builder: (_) => Loginpage(),
      //   );

      case Routes.onbroading:
        return MaterialPageRoute(builder: (_) => Onbroading());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => Singnup());
      // case Routes.register:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegisterView(),
      //   );

      // case Routes.foregetpassword:
      //   return MaterialPageRoute(
      //     builder: (_) => const ForgetPasswordView(),
      //   );

      // case Routes.otpverficationc:
      //   return MaterialPageRoute(
      //     builder: (_) => const OtpView(),
      //   );

      // case Routes.confirmPassword:
      //   return MaterialPageRoute(
      //     builder: (_) => const ConfirmPasswordView(),
      //   );

      // ✅ لو route مش موجود
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
