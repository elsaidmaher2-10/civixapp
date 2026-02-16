import 'package:civixapp/core/database/remote/api/ApiConstant.dart';
import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/service/networkchecker.dart';
import 'package:civixapp/feature/Auth/Login/data/models/loginsuccesresponse.dart';
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

      print(response);
      return right(Loginsuccesresponse.fromjosn(response));
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
