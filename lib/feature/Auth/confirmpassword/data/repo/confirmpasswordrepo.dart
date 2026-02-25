import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:dartz/dartz.dart';

class Confirmpasswordrepo {
  final Apiservice service;
  final InternetChecker networkChecker;
  Confirmpasswordrepo({required this.service, required this.networkChecker});
  Future<Either<FailureResponse, String>> createnewpassword({
    required String email,
    required String confirmPassword,
    required String otp,
  }) async {
    final hasInternet = await InternetChecker().checkInternet();
    if (!hasInternet) {
      return left(
        FailureResponse(errors: ["No internet connection"], statusCode: 0),
      );
    }

    try {
      final response = await service.post(
        path: Apiconstant.createnewpassowrdAPIEndpoint,
        body: {"email": email, "newPassword": confirmPassword, "otp": otp},
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
