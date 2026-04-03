import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:dartz/dartz.dart';

class LogOutRepository {
  Apiservice service;
  LogOutRepository(this.service);
  Future<Either<FailureResponse, String>> getLogs() async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      String? refreshToken = PrefrenceManager().getstring(
        Constantmanger.refreshToken,
      );
      final response = await service.post(
        body: {"refreshToken": refreshToken},
        path: Apiconstant.logout,
      );
      return right(response);
    } on Serverexciptionmodel catch (e) {
      final dynamic errorData = e.errors;
      if (errorData is Map<String, dynamic>) {
        return left(FailureResponse.fromJson(errorData));
      }
      return left(
        FailureResponse(
          errors: [errorData?.toString() ?? "Unknown server error"],
          statusCode: e.statuscode,
        ),
      );
    } catch (e) {
      return left(
        FailureResponse(
          errors: ["An unexpected error occurred: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }
}
