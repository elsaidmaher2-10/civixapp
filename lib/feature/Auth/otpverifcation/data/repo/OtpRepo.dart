import 'package:civixapp/core/database/remote/api/ApiConstant.dart';
import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpSuccessModel.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpmodel.dart';
import 'package:dartz/dartz.dart';

// /api/Account/OTPVerification
class OtpRepo {
  OtpRepo(this.service);
  Apiservice service;
  Future<Either<FailureResponse, Otpsuccessmodel>> OtPVerification(
    OtpModel otp,
    bool isreset,
  ) async {
    try {
      final response = await service.post(
        path: isreset ? Apiconstant.verifyotp : Apiconstant.confirmemaillogin,
        body: {"email": otp.Email, "code": otp.code},
      );

      return right(Otpsuccessmodel.fromjson(response));
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

  Future<Either<FailureResponse, String>> SendOtP(String email) async {
    try {
      final response = await service.post(
        path: Apiconstant.sendotp,
        body: {"email": email},
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