import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/worker_verification_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/database/remote/api/ApiConstant.dart';
import '../../../../../core/database/remote/api/ApiService.dart';
import '../../../../../core/database/remote/error/ServerExciptionmodel.dart';
import '../../../../../core/database/remote/error/failureResponse.dart';
import '../../../../../core/resource/constantmanger.dart';
import '../../../../../core/service/networkchecker.dart';
import '../model/VerificationrequestModel.dart';
import '../model/verficationmodel.dart';

class VerficationInitRepo {
  InternetChecker internetChecker;
  Apiservice apiservice;

  VerficationInitRepo({
    required this.internetChecker,
    required this.apiservice,
  });

  Future<Either<FailureResponse, VerficationInitList>> getAreas() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await apiservice.get(path: Apiconstant.getareas);

      final updatedUser = VerficationInitList.fromjson(response);

      return right(updatedUser);
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  Future<Either<FailureResponse, WorkerRequestModel>>
  getvrificationRequest() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await apiservice.get(path: Apiconstant.verification);

      final updatedUser = WorkerRequestModel.fromJson(response);

      return right(updatedUser);
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  Future<Either<FailureResponse, List<WorkerVerificationModel>>>
  getvrificationRequests() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await apiservice.get(path: Apiconstant.verifications);

      return right(WorkerVerificationModel.fromJsonList(response));
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  Future<Either<FailureResponse, VerficationInitList>>
  getDepartmentname() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await apiservice.get(path: Apiconstant.getdepartment);

      final updatedUser = VerficationInitList.fromjson(response);

      return right(updatedUser);
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  FailureResponse _handleServerException(Serverexciptionmodel e) {
    if (e.errors is Map?) {
      return FailureResponse.fromJson(e.errors);
    }
    return FailureResponse(
      errors: [e.errors.toString()],
      statusCode: e.statuscode,
    );
  }

  Future<Either<FailureResponse, dynamic>> verificationrequest({
    required VerificationrequestModel request,
  }) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final NationalIdFrontImage = await MultipartFile.fromFile(
        request.NationalIdFrontImage!.path,
        filename: request.NationalIdFrontImage!.path.split('/').last,
      );
      final NationalIdBackImage = await MultipartFile.fromFile(
        request.NationalIdBackImage!.path,
        filename: request.NationalIdBackImage!.path.split('/').last,
      );

      FormData formData = FormData.fromMap({
        "AreaId": request.AreaId,
        "DepartmentId": request.DepartmentId,
        "Notes": request.Notes,
        "NationalIdFrontImage": NationalIdFrontImage,
        "NationalIdBackImage": NationalIdBackImage,
      });

      final response = await apiservice.post(
        body: formData,
        path: Apiconstant.VerifcatioRequest,
      );
      return right(response.toString());
    } on Serverexciptionmodel catch (e) {
      final dynamic errorData = e.errors;
      if (errorData is Map<String, dynamic>) {
        if (errorData.containsKey('error') && errorData['error'] is String) {
          return left(
            FailureResponse(
              errors: [errorData['error']],
              statusCode: e.statuscode,
            ),
          );
        }
        return left(FailureResponse.fromJson(errorData));
      }

      return left(
        FailureResponse(
          errors: [errorData?.toString() ?? "Unknown server error"],
          statusCode: e.statuscode,
        ),
      );
    }
  }
}
