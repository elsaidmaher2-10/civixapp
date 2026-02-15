import 'package:civixapp/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:dio/dio.dart';

Serverexciptionmodel handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return Serverexciptionmodel(
        errors: e.message ?? "Connection Timeout",
        statuscode: e.response?.statusCode ?? 408,
      );
    case DioExceptionType.sendTimeout:
      return Serverexciptionmodel(
        errors: e.message ?? "Send Timeout",
        statuscode: e.response?.statusCode ?? 408,
      );
    case DioExceptionType.receiveTimeout:
      return Serverexciptionmodel(
        errors: e.message ?? "Receive Timeout",
        statuscode: e.response?.statusCode ?? 408,
      );
    case DioExceptionType.badCertificate:
      return Serverexciptionmodel(
        errors: e.message ?? "Bad Certificate",
        statuscode: e.response?.statusCode ?? 495,
      );
    case DioExceptionType.badResponse:
      return Serverexciptionmodel(
        errors: e.response?.data as Map? ?? "Bad Response",
        statuscode: e.response?.statusCode ?? 400,
      );
    case DioExceptionType.cancel:
      return Serverexciptionmodel(
        errors: e.message ?? "Request Cancelled",
        statuscode: e.response?.statusCode ?? 499,
      );
    case DioExceptionType.connectionError:
      return Serverexciptionmodel(
        errors: e.message ?? "Connection Error",
        statuscode: e.response?.statusCode ?? 503,
      );
    case DioExceptionType.unknown:
      return Serverexciptionmodel(
        errors: e.message ?? "Unknown Error",
        statuscode: e.response?.statusCode ?? 520,
      );
    // ignore: unreachable_switch_default
    default:
      return Serverexciptionmodel(
        errors: "Unexpected Error",
        statuscode: e.response?.statusCode ?? 500,
      );
  }
}
