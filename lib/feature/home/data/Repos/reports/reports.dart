import 'dart:io';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/home/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/home/data/Models/Report/CreateReportResponseModel.dart';
import 'package:dartz/dartz.dart';

class ReportRepository {
  final Apiservice service;
  final InternetChecker internetChecker;

  ReportRepository({required this.service, required this.internetChecker});

  Future<Either<FailureResponse, ReportResponse>> addReport({
    required CreateReportRequest request,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.post(
        body: request.toJson(),
        path: "/Reports",
      );
      return right(ReportResponse.fromJson(response));
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
