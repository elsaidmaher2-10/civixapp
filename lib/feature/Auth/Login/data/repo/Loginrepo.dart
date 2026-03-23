import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/Auth/Login/data/models/loginsuccesresponse.dart';
import 'package:citifix/feature/notication/data/repo/noticationRepo.dart';
import 'package:dartz/dartz.dart';

class Loginrepo {
  Apiservice apiservice;
  InternetChecker internetChecker;
  Loginrepo(this.apiservice, this.internetChecker);

  Future<Either<FailureResponse, Loginsuccesresponse>> login({
    required email,
    required password,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await apiservice.post(
        path: Apiconstant.loginendpoint,
        body: {"email": email, "password": password},
      );
      final loginResponse = Loginsuccesresponse.fromjosn(response);
      PrefrenceManager().setstring(Constantmanger.userid, loginResponse.id);
      PrefrenceManager().setstring(
        Constantmanger.accessToken,
        loginResponse.accessToken,
      );
      PrefrenceManager().setstring(
        Constantmanger.refreshToken,
        loginResponse.refreshToken,
      );
      PrefrenceManager().setstring(
        Constantmanger.refreshTokenExpiration,
        loginResponse.refreshTokenExpiration,
      );
      PrefrenceManager().setstring(Constantmanger.role, loginResponse.role);

      final String? fcmtoken = PrefrenceManager().getstring(Constantmanger.fcm);

      if (fcmtoken != null && fcmtoken.isNotEmpty) {
        final result = await getIt<NotificationRepo>().registerDevice(
          deviceToken: fcmtoken,
          platform: "Android",
        );
      }

      return right(loginResponse);
    } on Serverexciptionmodel catch (e) {
      if (e.errors is Map?) {
        final d = FailureResponse.fromJson(e.errors);
        return left(d);
      } else {
        return left(
          FailureResponse(
            errors: [e.errors.toString()],
            statusCode: e.statuscode,
          ),
        );
      }
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }
}
