import 'dart:async';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/home/presentation/view/mainScreen.dart';
import 'package:citifix/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Dio _refreshDio;
  Completer<bool>? _refreshCompleter;
  AuthInterceptor(this.dio)
    : _refreshDio = Dio(
        BaseOptions(
          baseUrl: Apiconstant.baseurl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = PrefrenceManager().getstring(Constantmanger.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('🚀 ${options.method} → ${options.path}');
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode != 401) {
      return handler.next(error);
    }
    if (error.requestOptions.extra['retry'] == true) {
      _handleLogout();
      return handler.next(error);
    }

    final refreshToken = PrefrenceManager().getstring(
      Constantmanger.refreshToken,
    );

    final refreshExpireStr = PrefrenceManager().getstring(
      Constantmanger.refreshTokenExpiration,
    );

    bool isExpired = true;
    if (refreshExpireStr != null && refreshExpireStr.isNotEmpty) {
      try {
        isExpired = DateTime.parse(refreshExpireStr).isBefore(DateTime.now());
      } catch (_) {
        isExpired = true;
      }
    }
    if (refreshToken == null || refreshToken.isEmpty || isExpired) {
      _handleLogout();
      return handler.next(error);
    }
    if (_refreshCompleter != null) {
      final success = await _refreshCompleter!.future;
      if (success) {
        await _retryRequest(error.requestOptions, handler);
      } else {
        handler.next(error);
      }
      return;
    }

    _refreshCompleter = Completer<bool>();

    final refreshed = await _fetchNewAccessToken(refreshToken);
    _refreshCompleter!.complete(refreshed);
    _refreshCompleter = null;

    if (refreshed) {
      await _retryRequest(error.requestOptions, handler);
    } else {
      _handleLogout();
      handler.next(error);
    }
  }

  Future<void> _retryRequest(
    RequestOptions opts,
    ErrorInterceptorHandler handler,
  ) async {
    final newToken = PrefrenceManager().getstring(Constantmanger.accessToken);
    try {
      final response = await dio.request(
        opts.path,
        options: Options(
          method: opts.method,
          headers: {...opts.headers, 'Authorization': 'Bearer $newToken'},
          extra: {...opts.extra, 'retry': true},
          responseType: opts.responseType,
          contentType: opts.contentType,
        ),
        data: opts.data,
        queryParameters: opts.queryParameters,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<bool> _fetchNewAccessToken(String refreshToken) async {
    try {
      final response = await _refreshDio.post(
        'Account/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      debugPrint('🔑 Refresh Response: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccess =
            response.data['accessToken'] ??
            response.data['token'] ??
            response.data['access_token'];
        final newRefresh =
            response.data['refreshToken'] ?? response.data['refresh_token'];
        if (newAccess != null) {
          PrefrenceManager().setstring(Constantmanger.accessToken, newAccess);
          if (newRefresh != null) {
            PrefrenceManager().setstring(
              Constantmanger.refreshToken,
              newRefresh,
            );
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint('❌ Token refresh failed: $e');
      return false;
    }
  }

  void _handleLogout() {
    PrefrenceManager().remove(Constantmanger.accessToken);
    PrefrenceManager().remove(Constantmanger.refreshToken);
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
        (route) => false,
      );
    }
  }
}
