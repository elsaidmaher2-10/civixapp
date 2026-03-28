import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/Auth/Login/presentation/views/LoginPage.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/view/Confirmpass.dart';
import 'package:citifix/feature/Auth/foregetpassword/presentation/views/foregetpassword.dart';
import 'package:citifix/feature/Auth/otpverifcation/presentation/view/otpvrificationcode.dart';
import 'package:citifix/feature/Auth/register/presentation/views/signupwidget.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/LogOut/LogOutcubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/editprofile.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/mainScreen.dart';
import 'package:citifix/feature/citzenFeature/onbroading/onbroading.dart';
import 'package:citifix/feature/workerFeature/main/Manager/cubit/worker_cubit_cubit.dart';
import 'package:citifix/feature/workerFeature/main/mainscreenwroker.dart';
import 'package:citifix/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routingmanger {
  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.onbroading:
        return _noPopRoute(child: Onbroading());
      case Routes.login:
        return _noPopRoute(child: Loginpage());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => Singnup());
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    UserProfileInfoCubit(getIt<Userprofilerepos>()),
              ),
              BlocProvider(
                create: (context) => LogCubit(getIt<LogOutRepository>()),
              ),
            ],
            child: const ProfileScreen(),
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
          settings: route,
          builder: (_) => CreatePasswordScreen(),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          settings: route,
          builder: (_) => BlocProvider.value(
            value: navigatorKey.currentContext!.read<UserProfileInfoCubit>(),
            child: EditProfileScreen(),
          ),
        );
      case Routes.citizenMain:
        return _noPopRoute(child: CitizenMainScreen());
      case Routes.workerMain:
        return _noPopRoute(
          child: BlocProvider(
            create: (BuildContext context) => WorkerCubit(),
            child: Mainscreenwroker(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }

  static MaterialPageRoute _noPopRoute({required Widget child}) {
    return MaterialPageRoute(
      builder: (BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) => SystemNavigator.pop(),
        child: child,
      ),
    );
  }
}
