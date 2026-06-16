import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/database/remote/api/ApiConstant.dart';
import '../../../../../core/database/remote/api/ApiService.dart';
import '../../../../../core/database/remote/error/ServerExciptionmodel.dart';
import '../../../../../core/database/remote/error/failureResponse.dart';
import '../../../../../core/resource/constantmanger.dart';
import '../../../../../core/service/networkchecker.dart';
import '../model/taskdetailsmodel.dart';

class ReportdetailsRepo {
  ReportdetailsRepo(this.internetChecker, this.service);
  final Apiservice service;
  final InternetChecker internetChecker;
  Future<Either<FailureResponse, TaskDetailsModel>> getReportDetails({
    required int reportid,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.get(
        path: Apiconstant.wokrkerReportDetails(reportid),
      );
      return right(TaskDetailsModel.fromJson(response));
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

  Future<Either<FailureResponse, bool>> markasCompeleted({
    required String notes,
    required List<File> images,
    required int reportId,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      List<MultipartFile> imageFiles = [];
      for (var imgPath in images) {
        imageFiles.add(
          await MultipartFile.fromFile(
            imgPath.path,
            filename: imgPath.path.split('/').last,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        "Images": imageFiles,
        "Note": notes,
      });

      final response = await service.post(
        body: formData,
        path: Apiconstant.markasCompeleted(reportId),
      );
      return right(true);
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

  Future<Either<FailureResponse, bool>> updateCompletion({
    required int reportId,
    required String notes,
    required List<File> imagesToAdd,
    required List<int> imagesToDeleteIds,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      List<MultipartFile> imageFiles = [];
      for (var imgPath in imagesToAdd) {
        imageFiles.add(
          await MultipartFile.fromFile(
            imgPath.path,
            filename: imgPath.path.split('/').last,
          ),
        );
      }

      FormData formData = FormData.fromMap({
        "ImagesToAdd": imageFiles,
        "Note": notes,
        "ImagesToDeleteIds": imagesToDeleteIds,
      });

      final response = await service.put(
        body: formData,
        path: Apiconstant.markasCompeleted(reportId),
      );
      return right(true);
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
