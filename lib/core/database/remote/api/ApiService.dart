import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiConsumer.dart';
import 'package:citifix/core/database/remote/api/ApihanderDioExcp.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/home/presentation/view/mainScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Apiservice extends Apiconsumer {
  Dio dio;
  Apiservice(this.dio) {
    dio.options = BaseOptions(
      baseUrl: Apiconstant.baseurl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    );
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          String? accessToken = PrefrenceManager().getstring(
            Constantmanger.accessToken,
          );
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          handler.next(options);
        },

        onError: _onError,
      ),
      LogInterceptor(
        requestUrl: true,
        request: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    ]);
  }
  @override
  get({required String path, Map<String, dynamic>? queryprams}) async {
    try {
      Response response = await dio.get(path, queryParameters: queryprams);
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
  @override
  post({
    required Object body,
    Map<String, dynamic>? queryprams,
    required String path,
  }) async {
    try {
      Response response = await dio.post(
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
  patch({
    required String path,
    required Object body,
    Map<String, dynamic>? queryprams,
  }) async {
    try {
      Response response = await dio.patch(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  _onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      if (error.requestOptions.extra["retry"] == true) {
        handler.next(error);
        return;
      }

      String? refreshToken = PrefrenceManager().getstring(
        Constantmanger.refreshToken,
      );
      String? refreshExpiryStr = PrefrenceManager().getstring(
        Constantmanger.refreshTokenExpiration,
      );

      bool refreshExpired = true;
      if (refreshExpiryStr != null) {
        DateTime refreshExpiry = DateTime.parse(refreshExpiryStr);
        refreshExpired = DateTime.now().isAfter(refreshExpiry);
      }

      if (refreshToken != null && !refreshExpired) {
        bool refreshed = await _fetchNewAccessToken();
        if (refreshed) {
          final opts = error.requestOptions;
          opts.extra["retry"] = true;
          final newAccess = PrefrenceManager().getstring(
            Constantmanger.accessToken,
          );
          opts.headers['Authorization'] = 'Bearer $newAccess';

          final cloneReq = await dio.request(
            opts.path,
            options: Options(method: opts.method, headers: opts.headers),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );
          handler.resolve(cloneReq);
          return;
        }
      }

      PrefrenceManager().remove(Constantmanger.accessToken);
      PrefrenceManager().remove(Constantmanger.refreshToken);

      var context = mainscreenKey.currentContext;
      if (context != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      }

      handler.next(error);
      return;
    }
    handler.next(error);
  }

  Future<bool> _fetchNewAccessToken() async {
    String? refreshToken = PrefrenceManager().getstring(
      Constantmanger.refreshToken,
    );

    if (refreshToken == null) return false;
    Dio dio = Dio(BaseOptions(baseUrl: Apiconstant.baseurl));
    try {
      final response = await dio.post(
        options: Options(headers: {Constantmanger.refreshToken: refreshToken}),
        Apiconstant.newAccessToken,
      );

      final newAccessToken = response.data[Constantmanger.accessToken];
      if (newAccessToken != null) {
        PrefrenceManager().setstring(
          Constantmanger.accessToken,
          newAccessToken,
        );
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
