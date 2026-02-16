import 'package:civixapp/core/database/remote/api/ApiConstant.dart';
import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/service/networkchecker.dart';
import 'package:dartz/dartz.dart';

class Forgetpasswordrepo {
  Forgetpasswordrepo(this.service, this.internetChecker);
  Apiservice service;
  InternetChecker internetChecker;
  Future<Either<FailureResponse, String>> SendOtP({
    required String email,
    required String purpose,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.post(
        path: Apiconstant.sendotp,
        body: {"email": email, "purpose": purpose},
      );

      return right(response);
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

 



//Elsaidmaher@@500 d45549048a@webxio.pro