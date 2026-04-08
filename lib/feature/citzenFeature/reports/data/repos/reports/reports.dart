import 'dart:async';
import 'dart:io';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:video_compress/video_compress.dart';

import '../../Models/Achievment/achievementModel.dart';

class ReportRepositoryT {
  final Apiservice service;
  final InternetChecker internetChecker;

  ReportRepositoryT({required this.service, required this.internetChecker});

  Stream<double> get onprogressStream => service.onprogress.stream;
  Future<Either<FailureResponse, String>> addReport({
    required CreateReportRequest request,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      List<MultipartFile> imageFiles = [];
      for (var imgPath in request.images) {
        if (imgPath.isNotEmpty) {
          imageFiles.add(
            await MultipartFile.fromFile(
              imgPath,
              filename: imgPath.split('/').last,
            ),
          );
        }
      }

      List<MultipartFile> videoFiles = [];
      for (var vidPath in request.videos) {
        if (vidPath.isNotEmpty) {
          File? compressedVideo = await _getCompressedVideo(vidPath);
          String pathToSend = compressedVideo?.path ?? vidPath;

          videoFiles.add(
            await MultipartFile.fromFile(
              pathToSend,
              filename: pathToSend.split('/').last,
            ),
          );
        }
      }

      FormData formData = FormData.fromMap({
        "Title": request.title,
        "Description": request.description,
        "Location": request.location,
        "Latitude": request.latitude,
        "Longitude": request.longitude,
        "CategoryId": request.categoryId,
        "Images": imageFiles,
        "Videos": videoFiles,
        "IsAnonymous": request.isAnonymous,
      });

      final response = await service.post(
        header: {"Accept-Language": "en"},
        body: formData,
        path: Apiconstant.report,
      );
      await VideoCompress.deleteAllCache();
      return right(response.toString());
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
          errors: ["Unknown Error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, ReportResponseModelByid>> getReportById({
    required int reportId,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.get(
        path: "${Apiconstant.report}/$reportId",
      );
      return right(ReportResponseModelByid.fromJson(response));
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
          errors: ["Unknown Error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, List<ReportItem>>> getReports() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      String? userid = PrefrenceManager().getstring(Constantmanger.userid);

      final response = await service.get(
        path: "${Apiconstant.report}/citizen/$userid",
      );

      final List<dynamic> items = response['items'];

      final List<ReportItem> reports = items
          .map((e) => ReportItem.fromJson(e))
          .toList();

      return right(reports);
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

  Future<Either<FailureResponse, String>> deleteReport({
    required int reportId,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.delete(
        path: "${Apiconstant.report}/$reportId",
      );
      return right(response.toString());
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
          errors: ["Unknown Error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, AchievementmodelReportsResponse>>
  achievement() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.get(path: Apiconstant.achievemnent);
      return right(AchievementmodelReportsResponse.fromJson(response));
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
          errors: ["Unknown Error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }
}

Future<File?> _getCompressedVideo(String path) async {
  final MediaInfo? info = await VideoCompress.compressVideo(
    path,
    quality: VideoQuality.DefaultQuality,
    deleteOrigin: false,
  );
  if (info != null && info.file != null) {
    return info.file;
  }
  return null;
}
