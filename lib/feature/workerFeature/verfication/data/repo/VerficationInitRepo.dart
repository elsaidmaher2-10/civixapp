import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/verficationmodel.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/database/remote/api/ApiConstant.dart';
import '../../../../../core/database/remote/error/ServerExciptionmodel.dart';
import '../../../../../core/database/remote/error/failureResponse.dart';
import '../../../../../core/resource/constantmanger.dart';

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

  Future<Either<FailureResponse, VerficationInitList>>
  getDepartmentname() async {
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

  FailureResponse _handleServerException(Serverexciptionmodel e) {
    if (e.errors is Map?) {
      return FailureResponse.fromJson(e.errors);
    }
    return FailureResponse(
      errors: [e.errors.toString()],
      statusCode: e.statuscode,
    );
  }
}
