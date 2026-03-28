import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:dartz/dartz.dart';

class Homreposatory {
  final Apiservice service;
  final InternetChecker internetChecker;
  Homreposatory({required this.service, required this.internetChecker});
  Future<Either<FailureResponse, DashBroadHome>> workerdashboard({
    required CreateReportRequest request,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.get(path: Apiconstant.workerdashboard);
      return right(DashBroadHome.fromJson(response));
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
          errors: ["Unknown Error${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }
}
