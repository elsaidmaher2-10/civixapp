import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/citzenFeature/notication/data/model/notifavtionmodel.dart';
import 'package:dartz/dartz.dart';

class NotificationRepo {
  final Apiservice service;
  NotificationRepo(this.service);
  Future<Either<FailureResponse, String>> registerDevice({
    required String deviceToken,
    required String platform,
  }) async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.post(
        path: Apiconstant.notificationRegister,
        body: {"deviceToken": deviceToken, "platform": platform},
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, List<NotificationModel>>>
  getNotifications() async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.get(path: Apiconstant.notification);
      return right(
        (response as List).map((e) => NotificationModel.fromJson(e)).toList(),
      );
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, dynamic>> markAsRead({required int id}) async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.put(
        path: "${Apiconstant.notification}/$id/read",
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, Map>> deleteNotification({
    required int id,
  }) async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      final response = await service.delete(
        path: "${Apiconstant.notification}/$id",
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, Map>> clearAllNotifications() async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.delete(
        path: Apiconstant.clearallnotification,
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }

  Future<Either<FailureResponse, Map>> markAllNotificationsAsRead() async {
    if (!await InternetChecker().checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.put(path: Apiconstant.markallread);
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
          errors: ["Unexpected error: ${e.toString()}"],
          statusCode: 500,
        ),
      );
    }
  }
}
