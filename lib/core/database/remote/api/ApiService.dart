import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiConsumer.dart';
import 'package:citifix/core/database/remote/api/ApihanderDioExcp.dart';
import 'package:citifix/core/database/remote/api/AuthInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Apiservice extends Apiconsumer {
  final Dio dio;

  Apiservice(this.dio) {
    dio.options = BaseOptions(
      baseUrl: Apiconstant.baseurl,
      sendTimeout: Duration(minutes: 5),
      receiveTimeout: Duration(minutes: 5),
      connectTimeout: Duration(minutes: 5),
    );

    dio.interceptors.addAll([
      AuthInterceptor(dio),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);
  }

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryprams,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryprams);
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future<dynamic> post({
    required String path,
    required Object body,
    Map<String, dynamic>? queryprams,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch({
    required String path,
    required Object body,
    Map<String, dynamic>? queryprams,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  put({
    required String path,
    Map<String, dynamic>? queryprams,
    Object? body,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  delete({
    required String path,
    Map<String, dynamic>? queryprams,
    Object? body,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}
